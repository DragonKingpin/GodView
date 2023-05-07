package Saurye.Wizard.User.ReciteWord;

import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Wizard;
import Pinecone.Framework.Util.JSON.JSONArray;
import Saurye.System.PredatorGenieBottle;

public class ReciteWord extends PredatorGenieBottle implements Wizard {
    public static JSONArray sortStream = null;

    protected String mszCurrentUser = "";

    public ReciteWord( ArchConnection connection ){
        super(connection);
    }

    public String prototypeName(){
        return this.getClass().getSuperclass().getSimpleName();
    }

}
