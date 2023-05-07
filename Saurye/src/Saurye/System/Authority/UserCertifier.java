package Saurye.System.Authority;

import Pinecone.Framework.Debug.Debug;
import Pinecone.Framework.Util.JSON.JSONException;
import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.Elements.Basic.User;
import Saurye.System.PredatorArchWizardum;

import javax.servlet.http.Cookie;
import java.io.UnsupportedEncodingException;

public class UserCertifier {
    public enum  DisqualifiedType {
        DT_UN_LOGIN, DT_MISS_MATCH, DT_MATCHED
    }

    protected AuthorityProperties       mAuthorityProperties ;
    protected String                    mszCurrentUsername   ;
    protected User mCurrentUser         = null               ; // Using lazy
    protected PredatorArchWizardum mSoul                ;

    public UserCertifier( PredatorArchWizardum soul ){
        this.mSoul                 = soul;
        this.mAuthorityProperties  = this.mSoul.properties().authority();

        if( !this.mAuthorityProperties.isVerifyUser() ) {
            this.mszCurrentUsername = this.mAuthorityProperties.getDefaultUsername();
        }
        else {
            this.loadUserInfoFromToken();
        }
    }

    public PredatorArchWizardum mySoul() {
        return this.mSoul;
    }


    public void registerCookies( JSONObject jUserInfo ) {
        try {
            Cookie cookie = new Cookie(
                    this.mAuthorityProperties.getUserTokenField(),
                    this.mSoul.coach().cipher().simpleEncrypt( jUserInfo.toJSONString().getBytes( this.mSoul.system().getServerCharset()) )
            );
            cookie.setMaxAge( this.mAuthorityProperties.getUserTokenAge() );
            cookie.setPath("/");
            this.mSoul.$_RESPONSE().addCookie(cookie);
        }
        catch ( UnsupportedEncodingException e ) {
            Debug.cerr( "This should never happened, but happened !", e );
        }
    }

    public void expungeCookies() {
        Cookie dummy = new Cookie( this.mAuthorityProperties.getUserTokenField(), "" );
        dummy.setMaxAge(0);
        dummy.setPath("/");
        this.mSoul.$_RESPONSE().addCookie( dummy );
    }

    public JSONObject getUserToken() {
        JSONObject jUserInfo = null;

        Cookie token = this.mSoul.$_COOKIE().get( this.mAuthorityProperties.getUserTokenField() );
        if( token!= null ) {
            try {
                String jszToken =  new String (
                        this.mSoul.coach().cipher().simpleDecrypt( token.getValue() ),
                        this.mSoul.system().getServerCharset()
                ) ;

                jUserInfo = new JSONObject( jszToken );
            }
            catch ( UnsupportedEncodingException | JSONException e ) {
                return null;
            }
        }

        return jUserInfo;
    }

    public boolean    verifyToken( JSONObject jUserInfo ) {
        if( jUserInfo != null ) {
            long nLoginTime = jUserInfo.optLong( "loginTime" );

            return ( System.currentTimeMillis() - nLoginTime ) <= this.mAuthorityProperties.getUserTokenAge() * 1000;
        }

        return false;
    }

    public DisqualifiedType privilegeQualified() {
        if( this.mSoul.getModularRole().equals( "Public" ) ) {
            return DisqualifiedType.DT_MATCHED;
        }

        if( this.mszCurrentUsername == null ) {
            return DisqualifiedType.DT_UN_LOGIN;
        }

        ////[Temporary] Uncheck miss-matched privilege.
        return DisqualifiedType.DT_MATCHED;
    }

    private void loadUserInfoFromToken() {
        JSONObject jUserInfo = this.getUserToken();

        if( this.verifyToken( jUserInfo ) ) {
            this.mszCurrentUsername = jUserInfo.optString( "username" );
        }
    }

    public UserCertifier refresh(){
        this.user().refresh();
        return this;
    }

    public User user() {
        if( this.mCurrentUser == null ){
            this.mCurrentUser = new User( this.mSoul, this.mszCurrentUsername );
        }
        return this.mCurrentUser;
    }

    public String username() {
        return this.mszCurrentUsername;
    }





}
