package Saurye.Wizard.User.PersonalFragments;

import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Wizard;
import Pinecone.Framework.Util.JSON.JSONArray;
import Saurye.System.PredatorGenieBottle;

public class PersonalFragments extends PredatorGenieBottle implements Wizard {
    public static JSONArray sortStream = null;

    protected String mszCurrentUser = "";

    public PersonalFragments ( ArchConnection session ) {
        super( session );
    }

    public String prototypeName(){
        return this.getClass().getSuperclass().getSimpleName();
    }

}