package Saurye.Wizard.Public.UnifyLogin;

import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Pagesion;
import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.System.Prototype.JasperModifier;

import java.sql.SQLException;

@JasperModifier
public class UnifyLoginModel extends UnifyLogin implements Pagesion {
    public UnifyLoginModel( ArchConnection connection ){
        super(connection);
    }

    @Override
    public void beforeGenieInvoke() throws Exception {
        super.beforeGenieInvoke();
    }

    @Override
    public void defaultGenie() throws Exception {
        super.defaultGenie();
        this.unifyLogin();
    }


    public void unifyLogin() throws SQLException {
        JSONObject $_SPOST = this.$_POST( true );

        if( this.mPageData.hasOwnProperty( "warningInfo" ) ) {
            $_SPOST.moveSubFrom( this.mPageData,"warningInfo" );
        }

        this.mPageData.put( "S_POST", $_SPOST );
    }

}