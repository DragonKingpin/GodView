package Saurye.Wizard.User.UserIndex;

import Pinecone.Framework.Debug.Debug;
import Pinecone.Framework.System.util.StringUtils;
import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.JSONBasedControl;
import Pinecone.Framework.Util.JSON.JSONException;
import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.Peripheral.Skill.Util.FileHelper;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;
import java.util.TreeMap;

public class UserIndexControl extends UserIndex implements JSONBasedControl {
    public UserIndexControl( ArchConnection connection ){
        super(connection);
    }

    @Override
    public void defaultGenie() throws Exception {
        super.defaultGenie();
    }

    public void modifyBase() throws IOException {
        JSONObject userInfo = this.$_POST( true );
        String szYokedErrorPage = this.spawnActionQuerySpell( "infoMaintain" );

        try{
            JSONObject dbUserInfo = this.mysql().fetch(
                    String.format( "SELECT `avatar`,`password` FROM %s WHERE `username` = '%s'",
                            this.alchemist().user().profile().tabUsersNS(), this.currentUser().username()
                    )
            ).optJSONObject( 0 );


            if( !userInfo.isEmpty() ){
                if( userInfo.optInt("noImgFlag" ) == 1 ){
                    userInfo.put( "avatar", "" );
                    String szOldImg = dbUserInfo.optString( "avatar" );

                    if( !StringUtils.isEmpty( szOldImg ) ){
                        if( ! FileHelper.erase( this, szOldImg ) ){
                            Debug.console().error( "UserIndexControl: File gone missing." );
                        }
                    }
                }
                userInfo.remove( "noImgFlag" );
            }

            if( userInfo.hasOwnProperty( "oldPassword" ) ){
                String szDBOldPw = dbUserInfo.optString( "password" );
                String szUOldPw  = userInfo.optString("oldPassword");
                if( ! szUOldPw.equals( new String( this.coach().cipher().simpleDecrypt( szDBOldPw ) ) ) ){
                    this.alert( "旧密码输入错误，请重试！", 0, szYokedErrorPage );
                }
                userInfo.put( "password", this.coach().cipher().simpleEncrypt( userInfo.optString("newPassword").getBytes() ) );
                userInfo.remove( "newPassword" );
                userInfo.remove( "oldPassword" );
            }
            else if ( !this.$_FILES().get("avatar").isEmpty() ){
                try {
                    userInfo.put( "avatar",
                            this.alchemist().user().profile().fileOperator().avatarUploader( this ).exertBuff( "Image", "avatar", szYokedErrorPage )
                    );

                    String szOldImg = dbUserInfo.optString( "avatar" );
                    if( !StringUtils.isEmpty( szOldImg ) && ! FileHelper.erase( this, szOldImg ) ){
                        Debug.console().error( "UserIndexControl: File gone missing." );
                    }
                }
                catch ( Exception e ){
                    this.rethrowStopSignal( e );
                }

            }

            Map<String, String > condition = new TreeMap<>();
            condition.put( "username", this.currentUser().username() );
            this.checkResult(
                    this.mysql().updateWithArray( this.alchemist().user().profile().tabUsers(), userInfo.getMap(), condition ) > 0
            );

        }
        catch ( IllegalStateException | NullPointerException | SQLException | JSONException e ) {
            this.alert( "未知错误，请联系管理员。", 0, this.spawnActionQuerySpell( "infoMaintain" ) );
        }
    }

}