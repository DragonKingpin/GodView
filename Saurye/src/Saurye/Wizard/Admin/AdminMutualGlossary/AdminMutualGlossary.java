package Saurye.Wizard.Admin.AdminMutualGlossary;

import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Wizard;
import Saurye.System.PredatorGenieBottle;

public class AdminMutualGlossary extends PredatorGenieBottle implements Wizard {
    public AdminMutualGlossary( ArchConnection connection ){
        super(connection);
    }

    public String prototypeName(){
        return this.getClass().getSuperclass().getSimpleName();
    }
}