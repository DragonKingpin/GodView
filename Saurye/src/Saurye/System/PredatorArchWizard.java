package Saurye.System;

import Pinecone.Framework.Util.JSON.JSONArray;
import Pinecone.Framework.Util.JSON.JSONObject;
import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.ArchPageson;
import Pinecone.Framework.Util.Summer.ArchWizardum;

public abstract class PredatorArchWizard extends ArchPageson {
    public Predator system(){
        return (Predator)(this.mParentSystem instanceof Predator ? this.mParentSystem : null);
    }

    public JSONObject getWizardProto( String prototypeName ) {
        return this.system().getWizardsConfig().getJSONObject( prototypeName );
    }

    public PredatorArchWizard ( ArchConnection session ) {
        super( session );
    }


    /** Role **/
    public int queryRoleIndex(String szRole ){
        return PredatorModularRoleInterpreter.interpret( szRole );
    }


    /** Wizard Archetype **/
    public String getTitle(){
        return this.getModularConfig().getString("title");
    }

    public JSONObject getModularConfig(){
        return this.getWizardProto( this.prototypeName() );
    }

    public String getModularRole(){
        return this.getModularConfig().getString("role");
    }

    public int getModularRoleIndex(){
        return this.queryRoleIndex( this.getModularRole() );
    }

    public JSONArray getMyNaughtyGenies() {
        return this.getModularConfig().optJSONArray("myNaughtyGenies");
    }
}
