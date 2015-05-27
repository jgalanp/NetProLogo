package utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.lang.reflect.Field;
import java.util.Collection;
import java.util.LinkedHashSet;
import java.util.StringTokenizer;

public class PathManagement {
	
	// Config file path.
	private static final String CONFIG_FILE  = "extensions/netprologo/config.txt";
	
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
	
	public static void updateSystemPath() throws IOException, NoSuchFieldException, SecurityException, IllegalArgumentException, IllegalAccessException {
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
}
