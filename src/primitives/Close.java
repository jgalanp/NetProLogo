package primitives;

import main.NetPrologoExtension;

import org.nlogo.api.Argument;
import org.nlogo.api.Context;
import org.nlogo.api.DefaultCommand;
import org.nlogo.api.ExtensionException;
import org.nlogo.api.LogoException;
import org.nlogo.api.Syntax;

//Close current query.
public class Close extends DefaultCommand {
	public Syntax getSyntax() {
        return Syntax.commandSyntax();
    }

	@Override
	public void perform(Argument[] arg0, Context arg1)throws ExtensionException, LogoException {
		NetPrologoExtension.release();	
	}
}
