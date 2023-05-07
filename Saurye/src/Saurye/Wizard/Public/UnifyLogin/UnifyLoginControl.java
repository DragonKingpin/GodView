package Saurye.Wizard.Public.UnifyLogin;

import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.JSONBasedControl;
import Pinecone.Framework.Util.JSON.JSONArray;
import Pinecone.Framework.Util.JSON.JSONObject;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.SQLException;

public class UnifyLoginControl extends UnifyLogin implements JSONBasedControl {
    public UnifyLoginControl( ArchConnection connection ){
        super(connection);
    }

    @Override
    public void defaultGenie() throws Exception {
        super.defaultGenie();
    }

    public void loginCheck() throws SQLException, IOException {
        JSONObject $_SPOST    = this.$_POST( true );
        JSONObject jModelPd   = this.revealYokedModel().getPageData();

        if( !$_SPOST.isEmpty() ) {
            JSONArray jUserInfos  = this.mysql().fetch( String.format(
                    "SELECT `username`,`password`, `authority` FROM %s WHERE `username` = '%s' ",
                    this.alchemist().user().profile().tabUsersNS(),
                    $_SPOST.optString( "username" )
            ) );

            if( jUserInfos.isEmpty() ) {
                jModelPd.put( "warningInfo", "Username is undefined." );
                return;
            }

            JSONObject jUserInfo  = jUserInfos.optJSONObject(0 );
            String     szRealPw   =  null;

            try {
                szRealPw = new String (
                        this.coach().cipher().simpleDecrypt( jUserInfo.optString( "password" ) ),
                        this.system().getServerCharset()
                ) ;
            }
            catch ( UnsupportedEncodingException e ) {
                szRealPw   =  null;
            }

            if( !$_SPOST.optString( "password" ).equals( szRealPw ) ) {
                jModelPd.put( "warningInfo", "Password is feckless." );
                return;
            }


            jUserInfo.remove( "password" );
            jUserInfo.put( "loginTime", System.currentTimeMillis() );

            this.currentUser().registerCookies( jUserInfo );

            this.redirect( $_GSC().optString( "referHref", "/" ) );
            this.stop();
        }
    }

    public void loginOut() throws SQLException, IOException {
        this.currentUser().expungeCookies();

        this.redirect( $_GSC().optString( "referHref", "/" ) );
        this.stop();
    }

}