package Saurye.Wizard.User.PersonalSentences;

import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Wizard;
import Pinecone.Framework.Util.JSON.JSONArray;
import Saurye.Elements.User.Pamphlet.Pamphlet;
import Saurye.Elements.User.Pamphlet.PamphletIncarnation;
import Saurye.System.PredatorGenieBottle;

public class PersonalSentences extends PredatorGenieBottle implements Wizard, PamphletIncarnation {
    public static JSONArray sortStream = null;

    protected String mszCurrentUser = "";

    public PersonalSentences( ArchConnection connection ){
        super(connection);
    }

    public String prototypeName(){
        return this.getClass().getSuperclass().getSimpleName();
    }

    @Override
    public Pamphlet protoIncarnated() {
        return this.alchemist().user().pamphlet().sentence();
    }

}