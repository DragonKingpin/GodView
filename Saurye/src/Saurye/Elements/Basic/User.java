package Saurye.Elements.Basic;

import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.Elements.EpitomeElement;
import Saurye.Elements.StereotypicalElement;
import Saurye.System.Predator;
import Saurye.System.PredatorArchWizardum;

import java.sql.SQLException;

public class User implements EpitomeElement, StereotypicalElement {
    public enum UserType {
        T_NORMAL, T_VIP, T_ADMIN, T_SUPER
    }

    private String      mszUserName;
    private String      mszAvatar;
    private String      mszNickName;
    private UserType    mUserType   = UserType.T_NORMAL;
    private String      mszEMail;
    private Predator    mHost;
    private String      mszUserTable;
    private JSONObject  mUserFocus;
    private JSONObject  mUserInfoCache;

    public User( Predator host, String szUsername ) {
        this.mHost = host;
        this.mszUserName = szUsername;
        this.asPrototype( this.getUserCache() );
    }

    public User(PredatorArchWizardum soul, String szUsername ) {
        this( soul.system(), szUsername );
    }

    public User( Predator host, JSONObject prototype ) {
        this.mHost = host;
        this.asPrototype( prototype );
    }

    @Override
    public String elementName() {
        return this.getClass().getSimpleName();
    }

    @Override
    public StereotypicalElement stereotype() {
        return this;
    }

    @Override
    public void javaify ( String szPrefix, Object that, JSONObject proto ){

    }

    public User asPrototype( JSONObject prototype ) {
        this.mUserInfoCache  = prototype;
        this.mszUserName     = prototype.optString( "username" );
        this.mszAvatar       = prototype.optString( "avatar" );
        this.mszNickName     = prototype.optString( "nickname" );
        this.mszEMail        = prototype.optString( "email" );
        this.mUserType       = User.userType( prototype.optString( "authority" ) );
        this.mUserFocus      = prototype.optJSONObject ( "userFocus" );

        return this;
    }

    public String getUserTable() {
        if( this.mszUserTable == null ){
            this.mszUserTable = this.mHost.mysql().tableName( this.mHost.alchemist().user().profile().tabUsers() );
        }
        return this.mszUserTable;
    }

    public JSONObject getUserRaw() {
        try {
            this.mUserInfoCache = this.mHost.mysql().fetch(
                    "SELECT `username`, `avatar`, `nickname`, `email`, `authority` FROM `" +
                            this.getUserTable() + "` WHERE `username` = '" + this.mszUserName + "'"
            ).optJSONObject(0);

            this.mUserInfoCache.put( "userFocus",
                    this.mHost.alchemist().user().profile().getUserFocus( this.mszUserName )
            );
            return this.mUserInfoCache;
        }
        catch ( SQLException e ){
            return null;
        }
    }

    public JSONObject getUserCache() {
        if ( this.mUserInfoCache == null ){
            this.mUserInfoCache = this.getUserRaw();
        }

        return this.mUserInfoCache;
    }

    public JSONObject getDetail() {
        try {
            return this.mHost.mysql().fetch( "SELECT * FROM `" + this.getUserTable() + "` WHERE `username` = '" + this.mszUserName + "'" ).optJSONObject(0);
        }
        catch ( SQLException e ){
            return null;
        }
    }

    public User refresh() {
        return this.asPrototype( this.getUserRaw() );
    }


    public String getUserName() {
        return this.mszUserName;
    }

    public void setUserName( String szUserName ) {
        this.mszUserName = szUserName;
    }

    public String getAvatar(){
        return this.mszAvatar;
    }

    public void setAvatar( String szAvatar ) {
        this.mszAvatar = szAvatar;
    }

    public String getNickName() {
        return this.mszNickName;
    }

    public void setNickName( String szNickName ) {
        this.mszNickName = szNickName;
    }

    public User.UserType getUserType() {
        return this.mUserType;
    }

    public void setUserType( User.UserType userType ) {
        this.mUserType = userType;
    }

    public String getEMail() {
        return this.mszEMail;
    }

    public void setEMail( String szEMail ) {
        this.mszEMail = szEMail;
    }

    public JSONObject getUserFocus() {
        return this.mUserFocus;
    }

    public void setUserFocus( JSONObject userFocus ) {
        this.mUserFocus = userFocus;
    }


    public static User.UserType userType (String szUserType ) {
        switch (szUserType) {
            case "normal": {
                return UserType.T_NORMAL;
            }
            case "vip": {
                return UserType.T_VIP;
            }
            case "admin": {
                return UserType.T_ADMIN;
            }
            case "super": {
                return UserType.T_SUPER;
            }
        }
        return UserType.T_NORMAL;
    }
}
