package Saurye.Wizard.System.PredatorAlertPage;

import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Wizard;
import Saurye.System.PredatorGenieBottle;

public class PredatorAlertPage extends PredatorGenieBottle implements Wizard {
    public PredatorAlertPage( ArchConnection connection ){
        super(connection);
    }

    public String prototypeName(){
        return this.getClass().getSuperclass().getSimpleName();
    }

}