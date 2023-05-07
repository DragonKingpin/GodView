package Saurye.Wizard.User.NovelGrimoire;

import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.JSONBasedControl;

public class NovelGrimoireControl extends NovelGrimoire implements JSONBasedControl {
    public NovelGrimoireControl( ArchConnection connection ) {
        super(connection);
    }

    @Override
    public void defaultGenie() throws Exception{
        super.defaultGenie();
    }
}
