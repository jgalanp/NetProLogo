package primitives;

import java.util.ArrayList;

import org.nlogo.api.Argument;
import org.nlogo.api.Context;
import org.nlogo.api.DefaultReporter;
import org.nlogo.api.ExtensionException;
import org.nlogo.api.LogoException;
import org.nlogo.api.Syntax;

import utils.Utils;

// Allows to use NetLogo variables within Prolog calls. Returns a String (the call).
public class BuildPrologCall extends DefaultReporter {

	// The first argument should be a String.
    public Syntax getSyntax() {
        return Syntax.reporterSyntax(new int[] {Syntax.RepeatableType() | Syntax.WildcardType()}, Syntax.StringType(),2);
    }
  
	public Object report(Argument[] arg0, Context arg1) throws ExtensionException{
		try {
			String call = arg0[0].getString();
			// Read and convert (from netlogo to prolog types) arguments
			ArrayList<String> argsList=new ArrayList<String>();
		    for(int i=1;i<arg0.length;i++){
		    	argsList.add(Utils.nlArgToPlString(arg0[i].get()));
		    }
		    // Complete Prolog call
		    return Utils.stringReplacement(call, argsList);
		} catch (LogoException e) {
			throw new ExtensionException(e);
		}
	}
}
