package Saurye.Wizard.Public.PredatorIndex;

import Pinecone.Framework.Debug.Debug;
import Pinecone.Framework.Util.JSON.JSONArray;
import Pinecone.Framework.Util.JSON.JSONObject;
import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Pagesion;
import Saurye.Peripheral.Skill.Util.PaginateHelper;
import Saurye.System.Predator;

import javax.servlet.ServletException;
import java.io.IOException;
import java.sql.SQLException;

public class PredatorIndexModel extends PredatorIndex implements Pagesion {
    private int pageLimit = 0;
    private int sumOfPage = 0;

    public PredatorIndexModel( ArchConnection connection ){
        super(connection);
    }


    public void dispatch() throws IOException, ServletException {
        try {
            this.mPageData = new JSONObject("{}");
            this.mPageData.put("title", this.getTitle());
            this.mPageData.put(
                    "carouselMain",
                    new JSONArray(
                            this.mysql().fetch(
                                    "SELECT imageurl FROM " + this.tableName(Predator.TABLE_INDEX_ASSETS)
                                            + " where classof='carouselMain'").getJSONObject(0).getString("imageurl")
                    )
            );

            this.pageLimit = this.getModularConfig().getInt("pageLimit");
            this.sumOfPage = this.mysql().countFromTable("SELECT COUNT(*) FROM " + this.tableName(Predator.TABLE_NEWS_PAGE) + " WHERE authority=1 and type=0");
            int beginNum = PaginateHelper.getPageBeginDefault(this.$_GPC().opt("pageid"), this.sumOfPage, this.pageLimit);

            this.mPageData.put(
                    "tableData",
                    this.mysql().fetch(
                            "SELECT `posttime`, `mainimage` ,`classid` , `title`,`authority`,`content` "
                                    + " FROM " + this.tableName(Predator.TABLE_NEWS_PAGE) +
                                    " WHERE authority=1 and type=0 order by posttime desc limit " + beginNum + "," + this.pageLimit
                    )
            );

            this.mPageData.put(
                    "pageLimit", this.pageLimit
            );

            this.mPageData.put(
                    "sumOfPage", this.sumOfPage
            );

            this.mPageData.put(
                    "SelfClassName", this.prototypeName()
            );

            this.fertilizedHF();
        }
        catch (SQLException e){
            this.handleSQLException(e);
        }
    }

    public void test(){
        Debug.trace( "Shit" );
    }

}
