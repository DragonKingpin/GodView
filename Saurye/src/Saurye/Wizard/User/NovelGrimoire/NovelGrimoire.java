package Saurye.Wizard.User.NovelGrimoire;

import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Wizard;
import Saurye.System.PredatorGenieBottle;

public class NovelGrimoire extends PredatorGenieBottle implements Wizard {
    public NovelGrimoire( ArchConnection connection ){
        super(connection);
    }

    public String prototypeName(){
        return this.getClass().getSuperclass().getSimpleName();
    }

}
