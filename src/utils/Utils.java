package utils;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import jpl.Atom;
import jpl.Float;
import jpl.Integer;
import jpl.Term;
import jpl.Util;

import org.nlogo.api.ExtensionException;
import org.nlogo.api.LogoException;
import org.nlogo.api.LogoList;
import org.nlogo.api.LogoListBuilder;

public class Utils {
	private static final String NL_STRING="java.lang.String";
	private static final String NL_NUMBER="java.lang.Double";
	private static final String NL_LIST="org.nlogo.api.LogoList";
    
	// Type conversion from NetLogo to Prolog.
    public static String nlArgToPlString(Object obj) throws ExtensionException{
    	String clase=obj.getClass().getCanonicalName();
    	if(clase.equals(NL_NUMBER)){
    		int ival=((Double)obj).intValue();
    		double dval=((Double)obj);
    		if(ival==dval)
    			return java.lang.Integer.toString(ival);
    		else
    			return Double.toString(dval);
    	}else if(clase.equals(NL_STRING)){
    		return ((String)obj).toString();
    	}else if(clase.equals(NL_LIST)){
    		return nlListToPlString((LogoList) obj);
    	}else{
    		throw new ExtensionException("Invalid Type("+clase+"), parameters must be Numeric , String or List");
    	}
    }
    
    // List conversion, from NetLogo list to Prolog list.
    public static String nlListToPlString(LogoList l) throws ExtensionException{
    	String ret="[";
    	Iterator<Object> it=l.iterator();
    	boolean first=true;
    	while(it.hasNext()){
    		if(!first)
    			ret+=",";
    		else
    			first=false;
    		ret+=nlArgToPlString(it.next());
    	}
    	ret+="]";
    	return ret;
    }
    
    // Builds a prolog call (String) converting NetLogo arguments to Prolog format.
    public static String stringReplacement(String rearCall, ArrayList<String> argsList) throws ExtensionException{
    	String call=rearCall;
  
    	Pattern p=Pattern.compile("\\?\\d+");
		Matcher m=p.matcher(call);
		Hashtable<java.lang.Integer,String> replacements=new Hashtable<java.lang.Integer,String>();
		while(m.find()){
			// Each tag ?1 ... ?N is mapped with to its corresponding value (regarding their order).
			String key=m.group();
			int keyVal=java.lang.Integer.parseInt(key.substring(1));
			if(!replacements.containsKey(keyVal)){
				replacements.put(new java.lang.Integer(keyVal), argsList.get(keyVal-1));
			}
		}
		
		// Checking
		if(replacements.size()!=argsList.size()){
			throw new ExtensionException("netprologo:build-prolog-call --> wrong parameters.");
		}
		for(int i=1;i<=argsList.size();i++){
			if(!replacements.containsKey(i)){
				throw new ExtensionException("netprologo:build-prolog-call --> wrong parameters.");
			}
		}
		
		// Each tag is replaced (repetition of tags is supported) by its corresponding value.
		for(java.lang.Integer i : replacements.keySet()){
			call=call.replaceAll("\\?"+i, replacements.get(i));
		}
		return call;
    }
    
    // Type conversion from Prolog to NetLogo
    public static Object plTermTOnlTermJPL(Term t) throws ExtensionException, LogoException{

    	if(t.isCompound()&&!t.isAtom()){
			LogoListBuilder res=new LogoListBuilder();
			if(t.name().equals(".")){		// if t is a list
				Term [] lterm=Util.listToTermArray(t);
				for(int i=0;i<lterm.length;i++){
					res.add(plTermTOnlTermJPL(lterm[i]));
				}
			}else{		// if t is a functor
				String functor=new String(t.name());
				res.add(functor);
				Term [] lterm = t.args();
				for(int i=0;i<lterm.length;i++){
					res.add(plTermTOnlTermJPL(lterm[i]));
				}
			}
			return res.toLogoList();
		}else if(t.isFloat()){
			return new Double(((Float)t).doubleValue());
		}else if(t.isInteger()){
			return new Double(((Integer)t).intValue());
		}else if(t.isAtom()){
			String atom=new String(((Atom)t).toString());
			if(atom.equals("[]")){
				LogoListBuilder res=new LogoListBuilder();
				return res.toLogoList();
			}
			return atom;
		}else{
			throw new ExtensionException("Output Type is invalid or not supported("+t.getClass().getCanonicalName()+").Check your Prolog Code");
		}	 
	}
    
}
