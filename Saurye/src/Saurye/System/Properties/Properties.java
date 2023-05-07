package Saurye.System.Properties;

import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.System.Authority.AuthorityProperties;
import Saurye.System.Predator;

public class Properties {
    private Predator              mParentSystem;
    private JSONObject            mGlobalPropertiesConf;
    private Paginate              mPaginate;
    private AuthorityProperties   mAuthority;

    private void javaifyProperties() {
        this.mPaginate  = new Paginate( this.mGlobalPropertiesConf.optJSONObject( "Paginate" ) );
        this.mAuthority = new AuthorityProperties( this.mParentSystem );
    }

    public Properties( Predator predator ) {
        this.mParentSystem         = predator;
        this.mGlobalPropertiesConf = this.mParentSystem.getGlobalPropertiesConfig();
        this.javaifyProperties();
    }

    public Predator parent(){
        return this.mParentSystem;
    }

    public boolean  hasOwnProperty( Object key ) {
        return this.mGlobalPropertiesConf.hasOwnProperty( key );
    }

    public JSONObject getJsonGlobalProperties() {
        return this.mGlobalPropertiesConf;
    }

    public Paginate             paginate() {
        return this.mPaginate;
    }

    public AuthorityProperties  authority() { return this.mAuthority; }

}
