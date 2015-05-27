package primitives;

import main.NetPrologoExtension;

import org.nlogo.api.Argument;
import org.nlogo.api.Context;
import org.nlogo.api.DefaultReporter;
import org.nlogo.api.ExtensionException;
import org.nlogo.api.LogoException;
import org.nlogo.api.Syntax;

import utils.Utils;

//Dereference a specific variable from the last solution loaded of a certain solution store.
public class DereferenceVarInStore extends DefaultReporter {

	public Syntax getSyntax() {
		return Syntax.reporterSyntax(new int[] {Syntax.NumberType(),Syntax.StringType()}, Syntax.WildcardType());
    }
	
	@Override
	public Object report(Argument[] arg0, Context arg1) throws ExtensionException{
    	String varName;
    	int storeId;
    	try{
    		storeId = arg0[0].getIntValue();
        	varName=arg0[1].getString();
        }catch( LogoException e ){
        	throw new ExtensionException(e.getMessage());
        }
		Object obj=NetPrologoExtension.dereferenceVarInStore(storeId,varName);
		Object ret;
		try {
			// Type conversion from Prolog to NetLogo
			ret = Utils.plTermTOnlTermJPL((jpl.Term)obj);
		} catch (LogoException e) {
			throw new ExtensionException(e.getMessage());
		}
		return ret;
	}
}
