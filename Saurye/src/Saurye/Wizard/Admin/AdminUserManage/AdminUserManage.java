package Saurye.Wizard.Admin.AdminUserManage;

import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Wizard;
import Saurye.System.PredatorGenieBottle;

public class AdminUserManage extends PredatorGenieBottle implements Wizard {
    public AdminUserManage( ArchConnection connection ){
        super(connection);
    }

    public String prototypeName(){
        return this.getClass().getSuperclass().getSimpleName();
    }

}