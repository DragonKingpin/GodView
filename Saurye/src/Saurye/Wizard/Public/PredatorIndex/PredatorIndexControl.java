package Saurye.Wizard.Public.PredatorIndex;

import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.JSONBasedControl;

import javax.servlet.ServletException;
import java.io.IOException;

public class PredatorIndexControl extends PredatorIndex implements JSONBasedControl {
    public PredatorIndexControl( ArchConnection connection  ){
        super(connection);
    }

    @Override
    public void dispatch() throws IOException, ServletException {

    }
}
