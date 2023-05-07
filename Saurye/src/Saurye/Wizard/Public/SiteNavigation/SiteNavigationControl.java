package Saurye.Wizard.Public.SiteNavigation;

import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.JSONBasedControl;

public class SiteNavigationControl extends SiteNavigation implements JSONBasedControl {
    public SiteNavigationControl( ArchConnection connection ){
        super(connection);
    }

    @Override
    public void defaultGenie() throws Exception {
        super.defaultGenie();
    }

}