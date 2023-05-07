package Saurye.Wizard.Public.SiteNavigation;

import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Pagesion;
import Saurye.System.Prototype.JasperModifier;

@JasperModifier
public class SiteNavigationModel extends SiteNavigation implements Pagesion {
    public SiteNavigationModel( ArchConnection connection ){
        super(connection);
    }

    @Override
    public void beforeGenieInvoke() throws Exception {
        super.beforeGenieInvoke();
    }

    @Override
    public void defaultGenie() throws Exception {
        super.defaultGenie();
    }


}