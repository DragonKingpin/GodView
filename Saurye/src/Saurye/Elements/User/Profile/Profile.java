package Saurye.Elements.User.Profile;

import Pinecone.Framework.Util.JSON.JSONArray;
import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.Elements.StereotypicalElement;
import Saurye.Elements.User.UserAlchemist;
import Saurye.Elements.User.OwnedElement;

import java.sql.SQLException;

public class Profile extends OwnedElement implements StereotypicalElement {
    protected String mTabUsers             = "";
    protected String mTabProfile           = "";
    protected String mTabFocusMajor        = "";

    public Profile ( UserAlchemist alchemist ){
        super( alchemist );
        this.tableJavaify( this, this.mTableProto );
        this.assetJavaify( this, this.mAssetProto );
    }

    @Override
    public String elementName() {
        return this.getClass().getSimpleName();
    }

    public String tabUsers           (){ return this.mTabUsers; }
    public String tabProfile         (){ return this.mTabProfile; }
    public String tabFocusMajor      (){ return this.mTabFocusMajor; }

    public String tabUsersNS         (){ return this.tableName( this.mTabUsers ); }
    public String tabProfileNS       (){ return this.tableName( this.mTabProfile ); }
    public String tabFocusMajorNS    (){ return this.tableName( this.mTabFocusMajor ); }


    /** Asset **/
    protected String              mAstAvatarSrc         = "";
    protected ProfileFileOperator mFileOperator         = null;

    public String                astAvatarSrc      (){ return this.mAstAvatarSrc; }

    public ProfileFileOperator   fileOperator      (){
        if( this.mFileOperator == null ){
            this.mFileOperator = new ProfileFileOperator( this );
        }
        return this.mFileOperator;
    }


    public JSONObject            getUserFocus      ( String szUsername ) throws SQLException {
        JSONArray jUserFocusBand = mysql().fetch( String.format(
                "SELECT `u_focus_band` FROM %s WHERE `username` = '%s' ",
                this.tabProfileNS(), szUsername
        ) );

        JSONArray jUserFocusMajor = mysql().fetch( String.format(
                "SELECT `m_focus` FROM %s WHERE `username` = '%s'",
                this.tabFocusMajorNS(), szUsername
        ) );

        JSONObject jMap = new JSONObject();

        jMap.put( "band", jUserFocusBand.optJSONObject(0).optString("u_focus_band") );
        jMap.put( "major", new JSONArray() );

        for ( int i = 0; i < jUserFocusMajor.length(); i++ ) {
            jMap.getJSONArray( "major" ).put( jUserFocusMajor.optJSONObject(i).optString( "m_focus" ) );
        }

        return jMap;
    }
}
