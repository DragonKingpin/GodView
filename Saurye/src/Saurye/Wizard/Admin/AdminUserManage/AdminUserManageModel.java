package Saurye.Wizard.Admin.AdminUserManage;

import Pinecone.Framework.System.util.StringUtils;
import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Pagesion;
import Saurye.Peripheral.Skill.Util.PaginateHelper;
import Saurye.System.Prototype.JasperModifier;

import javax.servlet.ServletException;
import java.io.IOException;
import java.sql.SQLException;

@JasperModifier
public class AdminUserManageModel extends AdminUserManage implements Pagesion {
    public AdminUserManageModel( ArchConnection connection ) {
        super(connection);
    }

    @Override
    public void defaultGenie() throws Exception {
        super.defaultGenie();
        this.mutualUsersList();
    }

    public void mutualUsersList() throws SQLException {
        String szModularBasicSQL = String.format(
                "SELECT %%s FROM %s %%s",
                this.alchemist().user().profile().tabUsersNS()
        );


        String szAuthority = this.$_GSC().optString( "authority" ), szNameID = this.$_GSC().optString( "nameID" );
        String szSelectAuthoritySQL = StringUtils.isEmpty( szAuthority ) ? "" : " `authority` = '" + szAuthority + "'";
        String szSelectNameIDSQL = StringUtils.isEmpty( szNameID ) ?  "" : String.format(
                " %s (nickname like '%%%s%%' or username like '%%%s%%')",
                szSelectAuthoritySQL.isEmpty() ? "" : "AND",
                szNameID, szNameID
        );

        String szConditionSQL = szSelectAuthoritySQL.isEmpty() && szSelectNameIDSQL.isEmpty() ? "" : " WHERE " + szSelectAuthoritySQL + szSelectNameIDSQL;

        this.coach().model().simplePaginationPreTreat( this, szModularBasicSQL, szConditionSQL );

        this.mPageData.put(
                "UsersList", this.mysql().fetch(
                        String.format(
                                szModularBasicSQL ,
                                "`id`, `username`, `nickname`, `authority`, `registration_date`",
                                szConditionSQL + " " + PaginateHelper.formatLimitSentence(
                                        this.mPageData.optLong( "nBeginNum" ), this.mPageData.optLong( "nPageLimit" )
                                )
                        )
                )
        );
    }

    public void appendNewUser() throws SQLException {}

    public void userEditor() throws IOException, ServletException, SQLException {
        String szModularBasicSQL = String.format(
                "SELECT %%s FROM %s %%s",
                this.alchemist().user().profile().tabUsersNS()
        );

        this.mPageData.put(
                "CurrentUserInfo", this.assertSelectResult(this.mysql().fetch(
                        String.format(
                                szModularBasicSQL ,
                                "`id`, `username`, `nickname`, `authority`, `password`, `avatar`,`registration_date`",
                                " WHERE id = '" + this.assertString( this.$_GSC().optString("id") ) + "'"
                        )
                )
                ).optJSONObject(0)
        );

        String szRealPassword = new String( this.coach().cipher().simpleDecrypt( this.mPageData.optJSONObject("CurrentUserInfo").optString( "password" ) ), this.system().getServerCharset() ) ;
        this.mPageData.optJSONObject("CurrentUserInfo").put( "password", szRealPassword );
    }
}