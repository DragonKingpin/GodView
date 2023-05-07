package Saurye.Wizard.User.GeniusTranslator;

import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.JSONBasedControl;

public class GeniusTranslatorControl extends GeniusTranslator implements JSONBasedControl {
    public GeniusTranslatorControl( ArchConnection connection ){
        super(connection);
    }

    @Override
    public void defaultGenie() throws Exception {
        super.defaultGenie();
    }
}