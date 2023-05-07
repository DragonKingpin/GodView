package Saurye.Wizard.Admin.AdminUserManage;

import Pinecone.Framework.Util.JSON.JSONObject;
import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.JSONBasedControl;
import Saurye.Peripheral.Skill.MVC.ControlLayerSkill;

import java.io.IOException;
import java.sql.SQLException;

public class AdminUserManageControl extends AdminUserManage implements JSONBasedControl {
    public AdminUserManageControl( ArchConnection connection ) {
        super(connection);
    }

    @Override
    public void defaultGenie() throws Exception{
        super.defaultGenie();
    }

    public void appendNewUser() throws SQLException, IOException  {
        JSONObject $_SPOST = this.$_POST(true);

        String szNewUser = $_SPOST.optString("username");
        if( this.mysql().countFromTable(
                String.format(
                        "SELECT COUNT(*) FROM %s WHERE `username` = '%s'" ,
                        this.alchemist().user().profile().tabUsersNS(), szNewUser )
        ) > 0 ){
            this.alert( "User '"  + szNewUser +"' has been existed.", 0, -1 );
        }

        String szRealPassword = this.coach().cipher().simpleEncrypt( $_SPOST.optString( "password" ).getBytes( this.system().getServerCharset() ) ) ;
        $_SPOST.put( "password", szRealPassword );
        boolean bRes = this.mysql().insertWithArray( this.alchemist().user().profile().tabUsers(), $_SPOST.getMap() ) > 0;
        this.checkResult( bRes, null, this.spawnActionQuerySpell() );
    }

    public void modifyOneUser() throws IOException, SQLException {
        JSONObject $_SPOST = this.$_POST( true );

        JSONObject condition  = $_SPOST.subJson( "id" );
        String szRealPassword = this.coach().cipher().simpleEncrypt( $_SPOST.optString( "password" ).getBytes( this.system().getServerCharset() ) ) ;
        $_SPOST.put( "password", szRealPassword );
        boolean bRes = this.mysql().updateWithArray( this.alchemist().user().profile().tabUsers() , $_SPOST.getMap(), condition.getMap() ) > 0;
        this.checkResult( bRes );
    }

    public void deleteOneUser() throws IOException,SQLException {
        this.checkResult(
                this.deleteOneUser( null )
        );
    }

    public boolean deleteOneUser( String szID ) throws IOException, SQLException {
        return false;
        //return this.coach().control().simpleDeleteSingleObject( "id", szID, this.alchemist().user().profile().tabUsers() );
    }

    public void userMassDelete() throws IOException, SQLException {
        ControlLayerSkill.commonMassDelete( this, "id[]", "deleteOneUser" );
    }
}