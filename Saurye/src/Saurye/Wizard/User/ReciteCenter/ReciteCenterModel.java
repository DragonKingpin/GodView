package Saurye.Wizard.User.ReciteCenter;
import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Pagesion;
import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.Peripheral.Skill.Util.DateHelper;
import Saurye.System.Prototype.JasperModifier;

import java.sql.SQLException;


@JasperModifier
public class ReciteCenterModel extends ReciteCenter implements Pagesion {
    private String mszSingleImgUploaderName = "SingleImgUploader";

    public ReciteCenterModel( ArchConnection connection ) {
        super(connection);
    }

    @Override
    public void beforeGenieInvoke() throws Exception {
        super.beforeGenieInvoke();
        this.mszCurrentUser = this.currentUser().username();
    }

    @Override
    public void defaultGenie() throws Exception {
        super.defaultGenie();
        this.planCenter();
    }

    public void planCenter() throws SQLException{

      boolean IsRecite = false;
      String szStlSelectSQL = String.format("SELECT `classid` FROM %s WHERE `p_now_plan` = 'true' AND `username` = '%s' ",this.alchemist().user().glossary().tabRecitePlanNS(),this.mszCurrentUser);
      String szMainSelectSQL = "SELECT %s FROM %s WHERE classid = (%s)";
      this.mPageData.put( "ReciteGlossaryInfo",this.mysql().fetch(
              String.format( szMainSelectSQL,"`g_name`,`g_create_data`,`g_authority`,`classid`,`g_c_usage`,`g_img_href`,`g_c_usage`,`g_state`",
                      this.alchemist().user().pamphlet().tabPamphletsNS(),szStlSelectSQL)
      ));


      if( !mPageData.getJSONArray("ReciteGlossaryInfo").isEmpty()){
          IsRecite = true;
          String szConditionSQL = String.format("WHERE classid = (%s) AND username = '%s'",szStlSelectSQL,this.mszCurrentUser);

          String szPlanInfoSelectSQL = String.format("SELECT COUNT(DISTINCT p_recite_date) AS sum_days,COUNT( en_word ) AS sum_words FROM %s %s",
                  this.alchemist().user().glossary().tabWordsNS(),szConditionSQL);


          String szPlanGlossaryInfoSelectSQL = String.format("SELECT `classid`,`username`,`p_word`,`p_create_date` FROM %s WHERE `p_now_plan` = 'true' AND `username` = '%s' "
                  ,this.alchemist().user().glossary().tabRecitePlanNS(),this.mszCurrentUser);


          JSONObject PlanInfo = new JSONObject();
          PlanInfo = this.mysql().fetch( szPlanInfoSelectSQL ).getJSONObject(0 );
          PlanInfo.put("today_recited_word",this.mysql().fetch(String.format("SELECT COUNT(p_recite_degree) AS recited_word FROM %s %s ",
                  this.alchemist().user().glossary().tabWordsNS(),
                  szConditionSQL+" AND p_recite_degree>0 AND p_recite_date = '"+ DateHelper.formatYMD()+"'")).getJSONObject(0).optInt("recited_word"));

          PlanInfo.put( "recited_word", this.mysql().fetch(String.format("SELECT COUNT(p_recite_degree) AS recited_word FROM %s %s "
                   ,this.alchemist().user().glossary().tabWordsNS(),szConditionSQL+" AND p_recite_degree>0")).getJSONObject(0).optInt("recited_word"));


          PlanInfo.put("recall_word",this.mysql().fetch(String.format("SELECT COUNT(p_recite_degree) AS recited_word FROM %s %s ",
                  this.alchemist().user().glossary().tabWordsNS(),
                  szConditionSQL+" AND p_recite_degree>0 AND p_recite_degree<100 AND p_recite_date = '"+ DateHelper.formatByBiasYMD( -1 )+"'")).getJSONObject(0).optInt("recited_word"));

          int recited_word = PlanInfo.getInt("recited_word");
          int sum_words = PlanInfo.getInt("sum_words");
          int finish_percent = (int)(recited_word*1.0/sum_words*1.0*100) ;
          PlanInfo.put( "finish_percent",finish_percent );
          PlanInfo.put("plan_glossary_info",this.mysql().fetch(szPlanGlossaryInfoSelectSQL).getJSONObject(0));
          PlanInfo.put("need_days",(sum_words-recited_word)/PlanInfo.getJSONObject("plan_glossary_info").getInt("p_word"));

          this.mPageData.put( "PlanInfo",PlanInfo );
      }

      this.mPageData.put( "IsRecite",IsRecite);
    }

    public void planList() throws SQLException{
       planCenter();
       String szPlanList = String.format("SELECT tPlan.`classid`,`p_word`,`p_create_date`,tPlan.`username`,COUNT(en_word) AS sum_words,`g_img_href`,`g_name`,`g_create_data`,`g_level`,`g_state`, " +
               "ROUND(COUNT(en_word)/p_word) AS sum_days" +
               " FROM %s AS tPlan LEFT JOIN %s AS tWord ON tPlan.`classid` = tWord.`classid` LEFT JOIN %s AS tGlossary \n" +
               " ON tGlossary.`classid` = tPlan.`classid` WHERE tPlan.`username` ='%s' AND tPlan.`p_now_plan` = 'false' GROUP BY `classid` ORDER BY `classid`"
               ,this.alchemist().user().glossary().tabRecitePlanNS()
               ,this.alchemist().user().glossary().tabWordsNS()
               ,this.alchemist().user().pamphlet().tabPamphletsNS()
               ,this.mszCurrentUser);

        String szPlanCount = String.format("SELECT COUNT(*) AS planCount FROM %s WHERE username = '%s'"
                ,this.alchemist().user().glossary().tabRecitePlanNS()
                ,this.mszCurrentUser);

       this.mPageData.put("planCount",this.mysql().fetch(szPlanCount));
       this.mPageData.put("planList",this.mysql().fetch(szPlanList));
    }


}