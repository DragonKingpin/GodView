package Saurye.Wizard.User.EtymologyExplorer;

import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Wizard;
import Saurye.System.PredatorGenieBottle;

public class EtymologyExplorer extends PredatorGenieBottle implements Wizard {
    public EtymologyExplorer( ArchConnection connection ){
        super(connection);
    }

    public String prototypeName(){
        return this.getClass().getSuperclass().getSimpleName();
    }
}
