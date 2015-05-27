package main;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Hashtable;
import java.util.LinkedHashSet;
import java.util.StringTokenizer;

import jpl.Query;

import org.nlogo.api.DefaultClassManager;
import org.nlogo.api.ExtensionException;
import org.nlogo.api.PrimitiveManager;

import primitives.BuildPrologCall;
import primitives.Close;
import primitives.DereferenceVarInStore;
import primitives.DereferenceVarJPL;
import primitives.NextSolutionInStore;
import primitives.RunNextJPL;
import primitives.RunQueryJPL;
import primitives.RunQueryNsolutions;
import utils.SolStore;

public class NetPrologoExtension extends DefaultClassManager {

	// Active Prolog query.
	private static Query jplQuery=null;
	// Denotes if there is an active query.
	private static boolean finished = true;
	// Stores current solution
	private static Hashtable jplSolution;
	// Id generator for solutions Stores.
	private static int idCounter;
	// Maps active solitions Stores with their ids.
	private static Hashtable<Integer,SolStore> solutionsStore;
	
	// Config file path.
	private static final String CONFIG_FILE  = "extensions/netprologo/config.txt";
	
    public java.util.List<String> additionalJars() {
        java.util.List<String> list = new java.util.ArrayList<String>();
        list.add("jpl.jar");
        return list;
    }
	
	@Override
	public void load(PrimitiveManager arg0) throws ExtensionException {
        arg0.addPrimitive("build-prolog-call", new BuildPrologCall());
        arg0.addPrimitive("run-query", new RunQueryJPL());
        arg0.addPrimitive("run-next", new RunNextJPL());
        arg0.addPrimitive("dereference-stored-var", new DereferenceVarInStore());
        arg0.addPrimitive("run-for-n-solutions", new RunQueryNsolutions());
        arg0.addPrimitive("next-stored-solution", new NextSolutionInStore());
        arg0.addPrimitive("dereference-var", new DereferenceVarJPL());
        arg0.addPrimitive("close-query", new Close());
	}
	
	public void runOnce(org.nlogo.api.ExtensionManager em) throws ExtensionException {
		try {
			initializeExtension();
		} catch (Exception e) {
			throw new ExtensionException(e);
		} 
		
	}
	
	// Initialize solutions Store and updates system path.
	private static void initializeExtension() throws IOException, NoSuchFieldException, SecurityException, IllegalArgumentException, IllegalAccessException{
		idCounter=0;
		solutionsStore=new Hashtable<Integer,SolStore>();
		
		if(getOs().indexOf("win") < 0){
			updateSystemPath();
		}
	}
	
	// Read path (where prolog native libraries are) from config file.
	private static String getConfigPath(File f) throws IOException{
		BufferedReader br = new BufferedReader(new FileReader(f));
		try {
		    String line = br.readLine();
		    if(line!=null && !line.equals(""))
		    	return line;
		    else
		    	throw new IOException("Exception while reading config.txt");
		} finally {
		    br.close();
		}
	}
	
	private static void updateSystemPath() throws IOException, NoSuchFieldException, SecurityException, IllegalArgumentException, IllegalAccessException {
		File f=new File(CONFIG_FILE);
		if(f.isFile()){
			LinkedHashSet<String> pathList = getSystemPath();
			pathList.add(getConfigPath(f));
			String path=listToPath(pathList);
			setLibraryPath(path);
		}
	}
	
	// Adds new path to system path.
	private static void setLibraryPath(String path) throws NoSuchFieldException, SecurityException, IllegalArgumentException, IllegalAccessException {
	    System.setProperty("java.library.path", path);
	    final Field sysPathsField = ClassLoader.class.getDeclaredField("sys_paths");
	    sysPathsField.setAccessible(true);
	    sysPathsField.set(null, null);
	}
	
	// Reads current system path.
	private static LinkedHashSet<String> getSystemPath(){
		LinkedHashSet<String> ret=new LinkedHashSet<String>();
		String property = System.getProperty("java.library.path");
		StringTokenizer parser = new StringTokenizer(property, ":");
		
		while (parser.hasMoreTokens()) {
			String token=parser.nextToken();
			if(!token.trim().equals(".")&&!token.trim().equals("")){
				ret.add(token.trim());
			}
		}
		return ret;
	}
	
	private static String listToPath(Collection<String> lp){
		String ret="";
		for(String s : lp){
			String token=s.replaceAll("\\\\", "/");
			ret+=token+":";
		}
		ret+=".";
		return ret;
	}
	
	public static String getOs(){
		return System.getProperty("os.name").toLowerCase();
	}
	
	// Close current query.
	public static void release(){
		if(jplQuery!=null){
			jplQuery.rewind();
			jplSolution = null;
			finished=true;
		}
	}
	
	// Opens a new Prolog query.
	public static boolean runQueryJPL(String q){
		release();
		jplQuery=new Query(q);
		if(jplQuery.hasSolution()){ // If there are not more solutions to be read ...
			finished=false;
			return true;
		}else{
			finished=true;
			return false;
		}
	}
	
	// Run a new query and store its first N solutions.
	public static int runQueryNsolutions(int n,String q){
		release();
		jplQuery=new Query(q);
		int count=0;
		ArrayList<Hashtable> sols=new ArrayList<Hashtable>();
		while(jplQuery.hasMoreSolutions() && count < n){
			sols.add(jplQuery.nextSolution());
			count++;
		}
		int id=idCounter++;
		solutionsStore.put(id, new SolStore(sols));
		return id;
	}
	
	// Load the next solution of the currently active Prolog query.
	public static boolean runNextJPL(){
		if (!jplQuery.hasMoreSolutions() || finished){
			finished = true;
			return false;
		}else{
			jplSolution=jplQuery.nextSolution();
			return true;
		}
	}
	
	// Dereference a specific variable from the last loaded solution of the active query.
	public static Object dereferenceVarJPL(String varName) throws ExtensionException {
		return jplSolution.get(varName);
	}

	// Load the next solution for a certain solutions store
	public static Object nextSolutionInStore(int storeId) {
		boolean ret=solutionsStore.get(storeId).nextSolution();
		if(!ret)
			solutionsStore.remove(storeId);
		return ret;
	}
	
	// Dereference a specific variable from the last solution loaded of a certain solution store.
	public static Object dereferenceVarInStore(int storeId, String varName) {
		return solutionsStore.get(storeId).dereferenceVar(varName);
	}
}
