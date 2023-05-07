package Saurye.Wizard.User.GeniusExplorer;

import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Wizard;
import Saurye.System.PredatorGenieBottle;

public class GeniusExplorer extends PredatorGenieBottle implements Wizard {
    public GeniusExplorer( ArchConnection connection ){
        super(connection);
    }

    public String prototypeName(){
        return this.getClass().getSuperclass().getSimpleName();
    }
}
