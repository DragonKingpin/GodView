package Saurye.Wizard.User.EtymologyExplorer;

import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.JSONBasedControl;

public class EtymologyExplorerControl extends EtymologyExplorer implements JSONBasedControl {
    public EtymologyExplorerControl( ArchConnection connection  ){
        super(connection);
    }

    @Override
    public void defaultGenie() throws Exception {
        super.defaultGenie();
    }

}