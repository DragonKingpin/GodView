package Saurye.Wizard.User.PersonalGlossary;

import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.JSONBasedControl;
import Pinecone.Framework.Util.JSON.JSONArray;
import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.Peripheral.Skill.MVC.ControlLayerSkill;
import Saurye.Peripheral.Skill.Util.DateHelper;

import java.io.IOException;
import java.sql.SQLException;
import java.util.*;

public class PersonalGlossaryControl extends PersonalGlossary implements JSONBasedControl {
    public PersonalGlossaryControl( ArchConnection connection ) {
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

    public void appendNewPamphlet() throws IOException,SQLException {
        this.checkResult(
                this.alchemist().user().pamphlet().studio( this ).appendNewPamphlet( false ) != null,
                 null, this.spawnActionQuerySpell( "devisePamphlet" )
        );
    }

    public void editPamphlet() throws SQLException,IOException {
        this.alchemist().user().pamphlet().studio( this ).editPamphlet();
    }

    public void cloneGlossary() throws IOException, SQLException {
        String szNewClassId    = this.alchemist().user().pamphlet().studio( this ).appendNewPamphlet( true ) ;
        String szClassIdProto  = this.$_GSC().optString( "classid" );
        String szUsernameProto = this.$_GSC().optString( "usernameProto" );

        boolean bRes = szNewClassId != null;

        bRes &= this.mysql().execute( String.format(
                "INSERT INTO %s ( `en_word`, `ph_note`, `d_sort_id`, `d_similar_w`,  `classid`,  `username`, `d_add_date` ) " +
                        " ( SELECT `en_word`, `ph_note`, `d_sort_id`, `d_similar_w`,  '%s' AS `classid`,  '%s' AS `username`, '%s' AS `d_add_date` " +
                        "   FROM %s WHERE `ph_type` = 'glossary' AND `classid` = '%s' AND `username` = '%s' ORDER BY `id` ASC ) " ,
                this.alchemist().user().glossary().tabWordsNS(), szNewClassId  , this.mszCurrentUser, DateHelper.formatYMD(),
                this.alchemist().user().glossary().tabWordsNS(), szClassIdProto, szUsernameProto
        ) ) > 0;

        this.checkResult(
                bRes, null, this.spawnActionQuerySpell( "wordList" ) + "&class_id=" + szNewClassId
        );
    }

    public void deleteOnePamphlet()throws IOException, SQLException {
        this.checkResult (
                this.alchemist().user().pamphlet().studio( this ).deleteOnePamphlet(null)
        );
    }




    /** Collection **/
    public void abortOneCollection()throws IOException, SQLException {
        this.checkResult ( this.abortOneCollection(null) );
    }

    public boolean abortOneCollection( String szClassId ) throws SQLException {
        if( szClassId == null ){
            szClassId = $_GSC().optString("classid");
        }
        String szCondition = String.format( " WHERE `classid` = '%s' AND `username` = '%s' ",
                szClassId , this.mszCurrentUser
        );
        return this.mysql().deleteWithSQL( this.alchemist().user().pamphlet().tabCollection(), szCondition ) > 0;
    }



    /** Word **/

    public void appendNewWord() throws IOException,SQLException {
        JSONObject $_SPOST = this.$_POST( true );

        String szWords  = $_SPOST.optString( "en_word" );
        String[] words  = szWords.split( "\\\\r\\\\n|\\\\n|,|;| " );
        String szClassId = $_SPOST.optString("classid");


        if( this.glossaryIsReciting(szClassId) ){
            this.alert( "该单词本正在背诵中！", 0, -1 );
        }
        else{
            boolean bRes = true;
            boolean bIsMultiple = words.length > 1;
            for( String word : words ){
                JSONObject wordData = $_SPOST.subJson( new String[]{ "classid" } );
                wordData.put( "username",this.mszCurrentUser );
                wordData.put( "en_word", word.trim() );
                wordData.put( "d_add_date", DateHelper.formatYMD() );


                if( !this.alchemist().mutual().word().hasSuchWord( wordData.optString("en_word") ) ){
                    if( bIsMultiple ){
                        continue;
                    }
                    this.alert( "不存在'"+wordData.optString("en_word") +"'该单词", 0, -1 );
                }
                if( this.mysql().countFromTable(
                        String.format( "SELECT COUNT(*) FROM %S WHERE en_word = '%s' AND classid = '%s' AND username = '%s' ",
                                this.alchemist().user().glossary().tabWordsNS(),
                                wordData.optString("en_word"),  wordData.optString("classid"),  this.mszCurrentUser
                        ) )>0
                ){
                    if( bIsMultiple ){
                        continue;
                    }
                    this.alert( "'" + wordData.optString("en_word") + "'在单词本中已经存在", 0, -1 );
                }

                bRes &= this.mysql().insertWithArray( this.alchemist().user().glossary().tabWords(), wordData.getMap() ) > 0;
            }


            this.checkResult( bRes, null, $_SPOST.optString("referHref" ) );
        }
    }

    public void deleteOneWord()throws IOException, SQLException {
        String szClassId = $_GSC().optString("class_id");
        if( this.glossaryIsReciting(szClassId) ){
            this.alert( "该单词本正在背诵中！", 0, -1 );
        }
        else{
            this.checkResult( this.deleteOneWord( $_GSC().optString("id") ) );
        }
    }

    public boolean deleteOneWord( String szID ) throws IOException, SQLException {
        return this.mysql().deleteWithSQL( this.alchemist().user().glossary().tabWords(), String.format(
                " WHERE id='%s' AND username='%s'" , szID, this.mszCurrentUser )
        ) > 0;
    }

    public void wordMassDelete() throws IOException, SQLException {
        ControlLayerSkill.commonMassDelete( this, "id[]", "deleteOneWord" );
    }

    public void editWordProfile() throws SQLException,IOException {
        JSONObject $_SPOST = $_POST(true );
        String szId = $_SPOST.optString("id");
        JSONObject data = $_POST(true).subJson(new String[]{ "g_note", "d_sort_id" });

        Map<String, String > condition = new TreeMap<>();
        condition.put( "id", szId );
        condition.put( "username", this.mszCurrentUser );
        this.checkResult(
                this.mysql().updateWithArray( this.alchemist().user().glossary().tabWords(), data.getMap(),condition ) > 0
        );
    }

    public void saveSortedWordList() throws SQLException, IOException {
        PersonalGlossaryModel hModelBrother = (PersonalGlossaryModel)this.revealYokedModel();
        try{
            hModelBrother.beforeGenieInvoke();
        } catch ( Exception e ){
            return;
        }
        hModelBrother.wordList();

        JSONObject brotherPageData  = hModelBrother.getPageData();
        boolean bReadOnly = brotherPageData.optBoolean( "bgReadonly" );

        JSONArray jGlossaryWordList = bReadOnly ? null : brotherPageData.optJSONArray( "GlossaryWordList" );
        String szClassId = $_GSC().optString( "class_id" );
        boolean bRes = true;
        if( jGlossaryWordList != null ){
            Map<String, Object > condition = new TreeMap<>();
            condition.put( "username", this.mszCurrentUser );
            condition.put( "classid", szClassId );
            Map<String, Object > data = new TreeMap<>();

            TreeSet<String > indexSet = new TreeSet<>();
            for( int i = 0; i < jGlossaryWordList.length(); i++ ){
                String szWord = jGlossaryWordList.getJSONObject(i).optString("en_word");
                if( !indexSet.contains( szWord ) ){
                    indexSet.add( szWord );
                    data.put( "d_sort_id", indexSet.size() );
                    condition.put( "en_word", szWord );
                    bRes &= this.mysql().updateWithArray( this.alchemist().user().glossary().tabWords(), data, condition ) > 0;
                }
            }
        }
        else {
            bRes = false;
        }
        this.checkResult( bRes, null, this.spawnActionQuerySpell( "wordList" ) + "&class_id=" + szClassId );
    }



    /** History **/

    public void deleteOneHistory()throws IOException, SQLException {
        this.checkResult( this.deleteOneHistory( $_GSC().optString("id") ) );
    }

    public boolean deleteOneHistory( String szID ) throws IOException, SQLException {
        return this.mysql().deleteWithSQL( this.alchemist().user().word().tabRecord(), String.format(
                " WHERE id='%s' AND username='%s'" , szID, this.mszCurrentUser )
        ) > 0;
    }

    public void historyMassDelete() throws IOException, SQLException {
        ControlLayerSkill.commonMassDelete( this, "id[]", "deleteOneHistory" );
    }


    /** Recall **/
    public void forgetOneRecall()throws IOException, SQLException {
        this.checkResult( this.forgetOneRecall( $_GSC().optString("en_word") ) );
    }

    public boolean forgetOneRecall ( String szWord ) throws IOException, SQLException {
        return this.mysql().deleteWithSQL( this.alchemist().user().word().tabRecall(), String.format(
                " WHERE `en_word`='%s' AND username='%s'" , szWord, this.mszCurrentUser )
        ) > 0;
    }

    public void wordsRankMassDelete() throws IOException, SQLException {
        ControlLayerSkill.commonMassDelete( this, "en_word[]", "forgetOneRecall" );
    }




    public void BuildCompare() throws SQLException {
        double Sum =0;
        double SqrtSum1 =0;
        double SqrtSum2 =0;
        int compare1[] = new int[100000];
        int compare2[] = new int[100000];

        String result = null;
        String szUsername = "undefined";
        String szFather_ph_name = $_POST().optString("BuildA");
        String szSon_ph_name = $_POST().optString("BuildB");

        JSONArray AllArray =this.mysql().fetch(String.format("SELECT `en_word` ,count(en_word) AS word_sum ,`classid` FROM %s AS tDict WHERE classid in \n" +
                        "(SELECT `classid` FROM %s AS tGlossary WHERE `username` = '%s' AND ( `ph_name` = '%s' OR `ph_name` = '%s')) GROUP BY en_word ORDER BY count(en_word) DESC",
                this.alchemist().user().glossary().tabWordsNS(),
                this.alchemist().user().pamphlet().tabPamphletsNS(),
                szUsername,szFather_ph_name,szSon_ph_name));

        String szCompareTarget = AllArray.getJSONObject(0).getString("classid");
        for(int i=0;i<AllArray.length();i++){
            if(AllArray.optJSONObject(i).optInt("word_sum")>=2){
                compare1[i]++;
                compare2[i]++;
            }
            else{
                if(AllArray.optJSONObject(i).optString("classid").equals(szCompareTarget)){
                    compare1[i]++;
                    compare2[i]=0;
                }
                else {
                    compare1[i]=0;
                    compare2[i]++;
                }
            }
        }
        for(int i=0;i<AllArray.length();i++){
            Sum += compare1[i]*compare2[i];
            SqrtSum1 +=compare1[i]*compare1[i];
            SqrtSum2 +=compare2[i]*compare2[i];
        }
        double SqrtSum = Math.sqrt(SqrtSum1)*Math.sqrt(SqrtSum2);

        if(SqrtSum!=0){
            result = String.format("%.2f",(Sum/SqrtSum)*100);
        }
        else
        {
            result = "0";
        }
        $_GET().put("result",result);
    }



}