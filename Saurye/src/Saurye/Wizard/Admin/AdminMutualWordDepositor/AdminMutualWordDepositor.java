package Saurye.Wizard.Admin.AdminMutualWordDepositor;

import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Wizard;
import Saurye.System.PredatorGenieBottle;

public class AdminMutualWordDepositor extends PredatorGenieBottle implements Wizard {
    public AdminMutualWordDepositor( ArchConnection connection ){
        super(connection);
    }

    public String prototypeName(){
        return this.getClass().getSuperclass().getSimpleName();
    }

}
