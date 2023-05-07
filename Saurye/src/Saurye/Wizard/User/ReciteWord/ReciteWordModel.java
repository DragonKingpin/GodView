package Saurye.Wizard.User.ReciteWord;

import Pinecone.Framework.Debug.Debug;
import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Pagesion;
import Pinecone.Framework.Util.Summer.prototype.ModelEnchanter;
import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.Peripheral.Skill.Util.DateHelper;
import Saurye.System.Prototype.JasperModifier;

import java.io.IOException;
import java.sql.SQLException;

@JasperModifier
public class ReciteWordModel extends ReciteWord implements Pagesion {
    private String mszSingleImgUploaderName = "SingleImgUploader";

    public ReciteWordModel( ArchConnection connection ) {
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
    }

    public void reciteWordList() throws SQLException, IOException {
        String szClassID = $_GSC().optString("class_id");

        if(szClassID!="") {
            int nNoFinishWord = this.mysql().countFromTable(String.format("SELECT COUNT(*) FROM %s WHERE `classid` = '%s' AND `p_recite_degree` = 0"
                    ,this.alchemist().user().glossary().tabWordsNS(),szClassID));
            int nPlanWord = this.mysql().fetch(String.format("SELECT `p_word` FROM %s WHERE `classid` = '%s' AND `username` = '%s'",
                    this.alchemist().user().glossary().tabRecitePlanNS(), szClassID, this.mszCurrentUser)).optJSONObject(0).optInt("p_word");
            if(nNoFinishWord==0){
                this.alert( "该单词本任务已完成", 0, -1 );
            }
            if(nPlanWord>nNoFinishWord){
                nPlanWord = nNoFinishWord;
            }

            String szReciteWordListSQL = String.format(
                    "SELECT tPlan.`en_word`,`m_property`,`cn_means`,`uk_phonetic_symbol` AS phonetic,`p_recite_degree` FROM %s AS tPlan " +
                            " LEFT JOIN %s AS tEn2Cn" +
                            " ON tPlan.`en_word` = tEn2Cn.`en_word`" +
                            " LEFT JOIN %s AS tPhonetic" +
                            " ON tPhonetic.`en_word` = tPlan.`en_word`" +
                            " WHERE `classid`= '%s'" +
                            " AND `p_recite_degree` = 0  GROUP BY tPlan.`en_word` ORDER BY `d_sort_id` LIMIT 0,%s "
                    , this.alchemist().user().glossary().tabWordsNS()
                    , this.alchemist().mutual().dict().tabEn2CnNS()
                    , this.alchemist().mutual().word().tabWordNS(), szClassID, Integer.toString(nPlanWord)
            );
            System.out.println(szReciteWordListSQL);


            String szRecallWordListSQL = String.format(
                    "SELECT tPlan.`en_word`,`m_property`,`cn_means`,`uk_phonetic_symbol` AS phonetic,`p_recite_degree` FROM %s AS tPlan " +
                            " LEFT JOIN %s AS tEn2Cn" +
                            " ON tPlan.`en_word` = tEn2Cn.`en_word`" +
                            " LEFT JOIN %s AS tPhonetic" +
                            " ON tPhonetic.`en_word` = tPlan.`en_word`" +
                            " WHERE `classid`= '%s'" +
                            " AND `p_recite_degree`>=0 AND `p_recite_degree`<100 AND `p_recite_date`= '%s' GROUP BY tPlan.`en_word`"
                    , this.alchemist().user().glossary().tabWordsNS()
                    , this.alchemist().mutual().dict().tabEn2CnNS()
                    , this.alchemist().mutual().word().tabWordNS(), szClassID
                    , DateHelper.formatByBiasYMD( -1 )
            );

            int nRecallWord = this.mysql().fetch(
                    String.format("SELECT COUNT(*) FROM %s WHERE `classid`='%s' AND `p_recite_degree`>=0 AND `p_recite_degree`<100 AND `p_recite_date`= '%s'"
                            , this.alchemist().user().glossary().tabWordsNS(), szClassID, DateHelper.formatByBiasYMD( -1 ))).optJSONObject(0).getInt("COUNT(*)");


            String szMassWordListSQL = String.format(
                    "  SELECT `m_property`,`cn_means` FROM " +
                            "   %s AS tEn2Cn " +
                            "   LEFT JOIN " +
                            "    %s AS tFrenquency" +
                            "        ON tFrenquency.`en_word` = tEn2Cn.`en_word`" +
                            "        WHERE `e_frequency`<20000 AND tEn2Cn.`en_word` NOT IN " +
                            "        (SELECT `cn_means` FROM(" +
                            "        SELECT `en_word` FROM %s  WHERE `classid`= '%s' " +
                            "        AND p_recite_degree = 0 LIMIT 0,%s)  AS tPlan )" +
                            "        ORDER BY RAND() LIMIT 0,%s", this.alchemist().mutual().dict().tabEn2CnNS()
                    , this.alchemist().mutual().word().tabBandFreqNS()
                    , this.alchemist().user().glossary().tabWordsNS(), szClassID, Integer.toString(nPlanWord), Integer.toString(nPlanWord * 4));

            this.mPageData.put("reciteWordList", this.mysql().fetch(szReciteWordListSQL));
            this.mPageData.put("recallWordList", this.mysql().fetch(szRecallWordListSQL));
            this.mPageData.put("massWordList", this.mysql().fetch(szMassWordListSQL));
            this.mPageData.put("sum_word", nPlanWord);
            this.mPageData.put("recall_sum", nRecallWord);
            this.mPageData.put("classid", szClassID);

        }
    }
    @ModelEnchanter
    public void reciteResult() throws SQLException{
           ReciteWordControl hControlBrother = (ReciteWordControl) this.revealYokedControl();
            try{
                hControlBrother.beforeGenieInvoke();
            } catch ( Exception e ){
                return;
            }
            hControlBrother.analysisReciteResult();
            JSONObject brotherPageData  = hControlBrother.getPageData();
            this.mPageData.put("WordPropertyList",brotherPageData.getJSONObject("WordPropertyList"));
            this.mPageData.put( "WordTestData",brotherPageData.getJSONObject("WordTestData") );
            this.mPageData.put( "WordWrongTimeRank", brotherPageData.getJSONArray("WordWrongTimeRank"));
        this.mPageData.put("AllReciteDate",brotherPageData.getJSONArray("AllReciteDate"));
        this.mPageData.put("RecallDate",brotherPageData.getJSONArray("RecallDate"));
        this.mPageData.put("ForgetDate",brotherPageData.getJSONArray("ForgetDate"));
            Debug.trace(mPageData);
    }

    public void goodJob() throws SQLException{

        String szClassId = $_GSC().optString("class_id");
        String szConditionSQL = String.format("WHERE classid = '%s' AND username = '%s'",szClassId,this.mszCurrentUser);
        String szSumDaysSQL = String.format("SELECT COUNT(DISTINCT p_recite_date) AS sum_days FROM %s %s",
                this.alchemist().user().glossary().tabWordsNS(),szConditionSQL);

        this.mPageData.put("sum_days",this.mysql().fetch(szSumDaysSQL).getJSONObject(0).optInt("sum_days"));
    }
}
