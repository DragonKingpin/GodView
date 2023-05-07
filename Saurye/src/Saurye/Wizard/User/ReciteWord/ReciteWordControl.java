package Saurye.Wizard.User.ReciteWord;

import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.JSONBasedControl;
import Pinecone.Framework.Util.JSON.JSONArray;
import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.Peripheral.Skill.Util.DateHelper;

import java.sql.SQLException;
import java.util.Map;
import java.util.TreeMap;

public class ReciteWordControl extends ReciteWord implements JSONBasedControl {
    public ReciteWordControl( ArchConnection connection ) {
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

    public void analysisReciteResult() throws SQLException{
        JSONObject $_POST_C = this.$_POST();
        JSONObject $_GSC_C  = this.$_GSC();


        String szWordData = $_POST_C.optString( "wordData" );
        JSONArray wordDataList = new JSONArray( szWordData );
        //Debug.trace(wordDataList);


        Map<String,String> dataMap = new TreeMap<>();
        Map<String,String> condition = new TreeMap<>();
        Map<String,Integer> mproperty = new TreeMap<>();
        Integer WrongTimeWord[] = new Integer[wordDataList.length()];

        Map<String,Integer> wordTestData = wordClassification();

        condition.put("classid",$_GSC_C.optString("class_id"));

        for( int i = 0 ;i<wordDataList.length();i++) {
            JSONObject wordInfo = wordDataList.optJSONObject(i);
            String szProperty = wordInfo.getString("szProperty");
            if (mproperty.get(szProperty) == null) {
                mproperty.put(szProperty, 1);
            } else {
                int oldNum = mproperty.get(szProperty) + 1;
                mproperty.put(szProperty, oldNum);
            }
            int index = wordInfo.optInt("nWrongTimes");
            int nDegree = wordInfo.optInt("nDegree");

            if (nDegree != 0) {
                dataMap.put("p_recite_date", DateHelper.formatByBiasYMD( -1 ));
                if (index > 0) {
                    int temp = wordTestData.get("WrongRecallWord") + 1;
                    wordTestData.put("WrongRecallWord", temp);
                } else {
                    int temp = wordTestData.get("RightRecallWord") + 1;
                    wordTestData.put("RightRecallWord", temp);
                }
            } else {
                dataMap.put("p_recite_date", DateHelper.formatYMD());
                if (index > 0) {
                    int temp = wordTestData.get("WrongReciteWord") + 1;
                    wordTestData.put("WrongReciteWord", temp);
                } else {
                    int temp = wordTestData.get("RightReciteWord") + 1;
                    wordTestData.put("RightReciteWord", temp);
                }
            }

            nDegree = this.jugeDegree(nDegree, index, wordTestData);
            WrongTimeWord[i] = index==-1?index+1:index;
            condition.put("en_word", wordInfo.optString("szEnWord"));
            dataMap.put("p_recite_degree", Integer.toString(nDegree));
            this.mysql().updateWithArray(this.alchemist().user().glossary().tabWords(),dataMap,condition);
        }

        String szConditionSQL = String.format("`classid` = '%s' AND `username` = '%s'",$_GSC_C.optString("class_id"),this.mszCurrentUser);
        String szAllReciteDate = String.format("SELECT `p_recite_date`,COUNT(*) AS daily_word FROM %s " +
                "WHERE %s AND `p_recite_date` >= now()-INTERVAL 5 DAY  GROUP BY `p_recite_date`",this.alchemist().user().glossary().tabWordsNS(),szConditionSQL);

        String szRecallDate = String.format("SELECT p_recite_date,COUNT(*) AS daily_word FROM %s " +
                "WHERE %s AND `p_recite_degree`>50 AND `p_recite_degree`<=100 AND `p_recite_date` >= now()-INTERVAL 5 DAY GROUP BY `p_recite_date`",this.alchemist().user().glossary().tabWordsNS(),szConditionSQL);

        String szForgetDate = String.format("SELECT p_recite_date,COUNT(*) AS daily_word FROM %s " +
                "WHERE %s AND `p_recite_degree`>50 AND `p_recite_degree`<100 AND `p_recite_date` >= now()-INTERVAL 5 DAY GROUP BY `p_recite_date`",this.alchemist().user().glossary().tabWordsNS(),szConditionSQL);

        this.mPageData.put("AllReciteDate",this.mysql().fetch(szAllReciteDate));
        this.mPageData.put("RecallDate",this.mysql().fetch(szRecallDate));
        this.mPageData.put("ForgetDate",this.mysql().fetch(szForgetDate));


        this.mPageData.put( "WordWrongTimeRank", wrongTimeRank(WrongTimeWord,wordDataList ));
        this.mPageData.put( "WordPropertyList", new JSONObject(mproperty) );
        this.mPageData.put( "WordTestData", new JSONObject(wordTestData) );
    }

    private Map wordClassification(){
        Map<String,Integer> wordcClassification = new TreeMap<>();
        wordcClassification.put("RightReciteWord",0);
        wordcClassification.put("WrongReciteWord",0);
        wordcClassification.put("RightRecallWord",0);
        wordcClassification.put("WrongRecallWord",0);
        wordcClassification.put("RecallSkipWord",0);
        wordcClassification.put("ReciteSkipWord",0);
        return wordcClassification;
    }

    private int jugeDegree( int nDegree,int index,Map<String,Integer> wordTestData ){
        int newWordDegree[] ={50,40,30,20,10};
        int recallWordDegree[] ={100,90,80,70,60};
        if(index > 5){
            index = 4;
        }
        if(index==-1){
            if(nDegree>0){
                int temp = wordTestData.get("RecallSkipWord")+1;
                wordTestData.put("RecallSkipWord",temp);
            }
            else{
                int temp = wordTestData.get("ReciteSkipWord")+1;
                wordTestData.put("ReciteSkipWord",temp);
            }
            nDegree = 100;
        }
        else if(nDegree>0){
            nDegree = recallWordDegree[index];
        }
        else{
            nDegree = newWordDegree[index];
        }
        return nDegree;
    }

    private JSONArray wrongTimeRank( Integer[] WrongTimeWord,JSONArray wordDataList ){
        JSONArray wordWrongTimeRank = new JSONArray();
        for( int i=0; i < WrongTimeWord.length; i++ ){
            if( WrongTimeWord[i] > 0 ){
                JSONObject word = wordDataList.getJSONObject(i);
                wordWrongTimeRank.put(word);
            }
        }
        return wordWrongTimeRank;
    }

}
