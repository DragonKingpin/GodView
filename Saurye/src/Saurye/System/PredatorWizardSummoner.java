package Saurye.System;

import Pinecone.Framework.Util.JSON.JSONException;
import Pinecone.Framework.Util.JSON.JSONObject;
import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.ArchWizardSummoner;

public class PredatorWizardSummoner extends ArchWizardSummoner {
    public PredatorWizardSummoner(ArchConnection connection ) {
        super(connection);
    }

    public String getWizardRoleName( String szNickName ){
        String szRole = "Public";
        JSONObject proto = null;

        try {
            proto = ((Predator)this.mParentSystem).getWizardProto( szNickName );
            szRole = proto.getString("role");
        }
        catch (JSONException e1){
            return szRole;
        }

        return szRole;
    }

    @Override
    public String queryNamespace( String szNickName ){
        return this.mParentSystem.getWizardPackageName() + "." + this.getWizardRoleName(szNickName) + "." + szNickName;
    }
}
