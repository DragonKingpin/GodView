package Saurye.Wizard.User.PersonalGlossary;

import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Wizard;
import Saurye.Elements.User.Pamphlet.Pamphlet;
import Saurye.Elements.User.Pamphlet.PamphletIncarnation;
import Saurye.System.PredatorGenieBottle;

import java.io.IOException;
import java.sql.SQLException;

public class PersonalGlossary extends PredatorGenieBottle implements Wizard, PamphletIncarnation {
    protected String mszCurrentUser = "";

    public PersonalGlossary( ArchConnection connection ){
        super(connection);
    }

    public String prototypeName(){
        return this.getClass().getSuperclass().getSimpleName();
    }

    @Override
    public Pamphlet protoIncarnated() {
        return this.alchemist().user().pamphlet().glossary();
    }

    /**
     * Code by JiaYiYuan. Temp
     * */
    public boolean glossaryIsReciting( String szClassId )throws SQLException, IOException {
        String szCondition = String.format( " WHERE `classid` = '%s'",
                szClassId , this.mszCurrentUser
        );
        String szGlossaryState = this.mysql().fetch(
                "SELECT `g_state` FROM " + this.alchemist().user().pamphlet().tabPamphletsNS()+ szCondition
        ).getJSONObject(0).getString("g_state");
        return szGlossaryState.equals("reciting");
    }

}