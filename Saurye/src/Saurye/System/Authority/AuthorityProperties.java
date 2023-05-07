package Saurye.System.Authority;

import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.System.Predator;

public class AuthorityProperties {
    private JSONObject                mAuthorityConfig    = null;
    private boolean                   mbVerifyUser        = true;
    private String                    mszDefaultUsername  = ""  ;
    private String                    mszUserTokenField   = ""  ;
    private int                       mnUserTokenAge            ;

    public AuthorityProperties ( Predator host ) {
        this.mAuthorityConfig   = host.getHostSystemConfig().optJSONObject( "AuthorityConfig" );
        this.mbVerifyUser       = this.mAuthorityConfig.optBoolean( "VerifyUser" );
        this.mszDefaultUsername = this.mAuthorityConfig.optString ( "DefaultUsername" );
        this.mszUserTokenField  = this.mAuthorityConfig.optString ( "UserTokenField" );
        this.mnUserTokenAge     = this.mAuthorityConfig.optInt    ( "UserTokenAge" );
    }

    public JSONObject getAuthorityConfig() {
        return this.mAuthorityConfig;
    }

    public boolean isVerifyUser() {
        return this.mbVerifyUser;
    }

    public String getDefaultUsername() {
        return this.mszDefaultUsername;
    }

    public String getUserTokenField() {
        return this.mszUserTokenField;
    }

    public int getUserTokenAge() {
        return this.mnUserTokenAge;
    }
}
