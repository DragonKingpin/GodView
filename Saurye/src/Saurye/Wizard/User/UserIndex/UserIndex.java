package Saurye.Wizard.User.UserIndex;

import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Wizard;
import Saurye.System.PredatorGenieBottle;

public class UserIndex extends PredatorGenieBottle implements Wizard {
    public UserIndex( ArchConnection connection ){
        super(connection);
    }

    public String prototypeName(){
        return this.getClass().getSuperclass().getSimpleName();
    }

}