package primitives;

import main.NetPrologoExtension;

import org.nlogo.api.Argument;
import org.nlogo.api.Context;
import org.nlogo.api.DefaultReporter;
import org.nlogo.api.ExtensionException;
import org.nlogo.api.LogoException;
import org.nlogo.api.Syntax;

//Load the next solution of the currently active Prolog query.
public class RunNextJPL extends DefaultReporter {

	public Syntax getSyntax() {
        return Syntax.reporterSyntax(Syntax.BooleanType());
    }
	
	@Override
	public Object report(Argument[] arg0, Context arg1) throws ExtensionException, LogoException {		
		return NetPrologoExtension.runNextJPL(); 
	}
}
