package Saurye.Wizard.User.WordExplicater;

import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.JSONBasedControl;

public class WordExplicaterControl extends WordExplicater implements JSONBasedControl {
    public WordExplicaterControl( ArchConnection connection ){
        super(connection);
    }

    @Override
    public void defaultGenie() throws Exception {
        super.defaultGenie();
    }

}