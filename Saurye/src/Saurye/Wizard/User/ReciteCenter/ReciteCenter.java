package Saurye.Wizard.User.ReciteCenter;

import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Wizard;
import Pinecone.Framework.Util.JSON.JSONArray;
import Saurye.System.PredatorGenieBottle;

public class ReciteCenter extends PredatorGenieBottle implements Wizard {
    public static JSONArray sortStream = null;

    protected String mszCurrentUser = "";

    public ReciteCenter( ArchConnection connection ){
        super(connection);
    }

    public String prototypeName(){
        return this.getClass().getSuperclass().getSimpleName();
    }

}