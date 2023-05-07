package Saurye.Wizard.User.MutualGlossary;

import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Wizard;
import Saurye.System.PredatorGenieBottle;

public class MutualGlossary extends PredatorGenieBottle implements Wizard {
    protected String mszCurrentUser = "";

    public MutualGlossary( ArchConnection connection ){
        super(connection);
    }

    public String prototypeName(){
        return this.getClass().getSuperclass().getSimpleName();
    }

}