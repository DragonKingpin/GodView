package Saurye.Wizard.User.NovelExhibitor;

import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Wizard;
import Saurye.System.PredatorGenieBottle;

public class NovelExhibitor extends PredatorGenieBottle implements Wizard {
    public NovelExhibitor( ArchConnection connection ){
        super(connection);
    }

    public String prototypeName(){
        return this.getClass().getSuperclass().getSimpleName();
    }

}
