package Saurye.Wizard.User.PersonalFragments;

import Pinecone.Framework.Debug.Debug;
import Pinecone.Framework.System.util.StringUtils;
import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.JSONBasedControl;
import Pinecone.Framework.Util.JSON.JSONArray;
import Pinecone.Framework.Util.JSON.JSONException;
import Pinecone.Framework.Util.JSON.JSONObject;
import Pinecone.Framework.Util.Random.SeniorRandom;
import Saurye.Peripheral.Skill.MVC.ControlLayerSkill;
import Saurye.Peripheral.Skill.Util.DateHelper;
import Saurye.Peripheral.Skill.Util.FileHelper;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;
import java.util.TreeMap;
import java.util.TreeSet;

public class PersonalFragmentsControl extends PersonalFragments implements JSONBasedControl {
    public PersonalFragmentsControl( ArchConnection connection ) {
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

    private String appendNewGlossary( boolean bIsCloneMode ) throws IOException,SQLException {
        try {
            JSONObject $_SPOST = this.$_POST( true );
            JSONObject glossaryData = $_SPOST.subJson( new String[]{ "ph_name","ph_note","ph_authority"} );
            String szUsername = this.currentUser().username();
            String szYokedErrorPage = this.spawnActionQuerySpell( bIsCloneMode ? "cloneGlossary" : "appendNewGlossary" );


            if( $_SPOST.optInt("noImgFlag" ) == 1 ){
                glossaryData.put( "ph_img_href", "" );
            }
            else if ( !this.$_FILES().get("ph_img_href").isEmpty() ) {
                try {
                    glossaryData.put("ph_img_href",
                            this.alchemist().user().pamphlet().fileOperator().coverUploader( this ).exertBuff("Image", "ph_img_href",szYokedErrorPage )
                    );
                } catch (Exception e) {
                    this.rethrowStopSignal(e);
                }
            }

            String szClassId = new SeniorRandom().nextString(15 );
            glossaryData.put( "classid", szClassId );
            glossaryData.put( "username", szUsername );
            String szNewGlossaryName = $_SPOST.optString("ph_name");
            glossaryData.put( "ph_create_data", DateHelper.formatYMD() );
            glossaryData.put( "ph_type","fragment");

            if( this.mysql().countFromTable(
                    String.format(
                            "SELECT COUNT(*) FROM %s WHERE `username` = '%s' AND `ph_name` = '%s' AND `ph_type` = 'fragment'" ,
                            alchemist().user().pamphlet().tabPamphletsNS(), glossaryData.optString("username"),szNewGlossaryName )
            ) > 0 ){
                this.alert( "'"+ glossaryData.optString("username") +"'"+"的"+"'"  + szNewGlossaryName + "'单词本已经存在", 0, szYokedErrorPage );
            }

            if( this.mysql().insertWithArray( this.alchemist().user().fragment().tabGlossary(), glossaryData.getMap() ) > 0 ){
                return szClassId;
            }
        }
        catch ( JSONException e ){
            return null;
        }
        return null;
    }

    public void appendNewGlossary() throws IOException,SQLException {
        this.checkResult(
                this.appendNewGlossary( false ) != null, null, this.spawnActionQuerySpell( "appendNewGlossary" )
        );
    }

    public void deleteOneGlossary()throws IOException, SQLException {
        this.checkResult ( this.deleteOneGlossary(null) );
    }

    public boolean deleteOneGlossary( String szClassId ) throws SQLException {
        if( szClassId == null ){
            szClassId = $_GSC().optString("classid");
        }
        String szCondition = String.format( " WHERE `classid` = '%s' AND `username` = '%s' ",
                szClassId , this.mszCurrentUser
        );
        JSONArray old = this.mysql().fetch (
                "SELECT `ph_img_href` FROM " + this.alchemist().user().fragment().tabGlossaryNS() + szCondition
        );
        if( old.isEmpty() ){
            return false;
        }
        if( ! FileHelper.erase( this, old.optJSONObject(0 ).optString( "ph_img_href" ) ) ){
            Debug.console().error( "UserIndexControl: File gone missing." );
        }
        return this.mysql().deleteWithSQL( this.alchemist().user().fragment().tabGlossary(), szCondition ) > 0; // Using trigger
    }

    public void editGlossary() throws SQLException,IOException {
        JSONObject $_SPOST = this.$_POST( true );
        JSONObject glossaryInfo = $_SPOST.subJson(new String[]{ "classid","ph_name","ph_note","ph_authority"});
        String szYokedErrorPage = this.spawnControlQuerySpell("editGlossary");

        JSONObject dbGlossaryInfo = this.mysql().fetch(
                String.format( "SELECT `classid`,`ph_name`,`ph_note`,`ph_img_href`,`ph_authority`, `username` FROM %s WHERE `classid`= '%s' AND `ph_type` = 'fragment'"
                        ,this.alchemist().user().fragment().tabGlossaryNS()
                        ,glossaryInfo.optString("classid")
                )
        ).optJSONObject( 0 );

        if( !dbGlossaryInfo.optString("username").equals(this.mszCurrentUser) ){
            this.checkResult( false );
        }

        String szNewGlossaryName = glossaryInfo.optString("ph_name");

        if(!szNewGlossaryName.equals(dbGlossaryInfo.optString("ph_name"))){
            if( this.mysql().countFromTable(
                    String.format(
                            "SELECT COUNT(*) FROM %s WHERE `username` = '%s' AND `ph_name` = '%s'" ,
                            this.alchemist().user().fragment().tabGlossaryNS(), this.currentUser().username(), szNewGlossaryName)
            ) > 0 ){
                this.alert( "'"+ this.currentUser().username() +"'"+"的"+"'"  + szNewGlossaryName + "'单词本已经存在", 0, -1 );
            }
        }

        if( !glossaryInfo.isEmpty() ){
            if( $_POST().optInt("noImgFlag" ) == 1 ){
                glossaryInfo.put( "ph_img_href", "" );
                String szOldImg = dbGlossaryInfo.optString( "ph_img_href" );

                if( !StringUtils.isEmpty( szOldImg ) ){
                    if( ! FileHelper.erase( this, szOldImg ) ){
                        Debug.console().error( "UserIndexControl: File gone missing." );
                    }
                }
            }
        }
        if ( !this.$_FILES().get("ph_img_href").isEmpty() ){
            try {
                glossaryInfo.put( "ph_img_href",
                        this.alchemist().user().pamphlet().fileOperator().coverUploader( this ).exertBuff("Image", "ph_img_href",szYokedErrorPage )
                );

                String szOldImg = dbGlossaryInfo.optString( "ph_img_href" );
                if( !StringUtils.isEmpty( szOldImg ) && ! FileHelper.erase( this, szOldImg ) ){
                    Debug.console().error( "UserIndexControl: File gone missing." );
                }
            }
            catch ( Exception e ){
                this.rethrowStopSignal( e );
            }

        }
        Map<String, String > condition = new TreeMap<>();
        condition.put( "classid",glossaryInfo.optString("classid") );
        condition.put( "username", this.mszCurrentUser );
        this.checkResult(
                this.mysql().updateWithArray( this.alchemist().user().fragment().tabGlossary(), glossaryInfo.getMap(), condition ) > 0
        );
    }

    public void cloneGlossary() throws IOException, SQLException {

        String szNewClassId    = this.appendNewGlossary( true ) ;
        String szClassIdProto  = this.$_GSC().optString( "classid" );
        String szUsernameProto = this.$_GSC().optString( "usernameProto" );


        boolean bRes = szNewClassId != null;

        bRes &= this.mysql().execute( String.format(
                "INSERT INTO %s ( `en_root`, `g_note`, `d_sort_id`,  `classid`,  `username`, `d_add_date`,`f_clan_name` ) " +
                        " ( SELECT `en_root`, `g_note`, `d_sort_id`,  '%s' AS `classid`,  '%s' AS `username`, '%s' AS `d_add_date` ,`f_clan_name`" +
                        "   FROM %s WHERE `classid` = '%s' AND `username` = '%s' ORDER BY `id` ASC ) " ,
                this.alchemist().user().fragment().tabRootsNS(), szNewClassId  , this.mszCurrentUser, DateHelper.formatYMD(),
                this.alchemist().user().fragment().tabRootsNS(), szClassIdProto, szUsernameProto
        ) ) > 0;

        this.checkResult(
                bRes, null, this.spawnActionQuerySpell( "rootList" ) + "&class_id=" + szNewClassId
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
        return this.mysql().deleteWithSQL( this.alchemist().user().fragment().tabCollection(), szCondition ) > 0;
    }


    /** Word **/

    public void appendNewRoot() throws IOException,SQLException{
        JSONObject $_SPOST = this.$_POST( true );

        String szWords  = $_SPOST.optString( "en_root" );
        String[] words  = szWords.split( "\\\\r\\\\n|\\\\n|,|;| " );
        System.out.println(szWords);

        boolean bRes = true;
        boolean bIsMultiple = words.length > 1;
        for( String word : words ){
            JSONObject wordData = $_SPOST.subJson( new String[]{ "classid" } );
            wordData.put( "username",this.mszCurrentUser );
            wordData.put( "en_root", word.trim() );
            wordData.put( "d_add_date", DateHelper.formatYMD() );

            if( this.mysql().countFromTable(  String.format ( "SELECT COUNT(*) FROM %S WHERE `f_stub_name`= '%s'  ",
                    this.alchemist().mutual().frag().tabFragsNS(),wordData.optString("en_root") ) ) <= 0
            ){
                if( bIsMultiple ){
                    continue;
                }
                this.alert( "不存在'"+wordData.optString("en_root") +"'该单词", 0, -1 );
            }

            if( this.mysql().countFromTable(
                    String.format( "SELECT COUNT(*) FROM %S WHERE en_root = '%s' AND classid = '%s' AND username = '%s' ",
                            this.alchemist().user().fragment().tabRootsNS(),
                            wordData.optString("en_root"),  wordData.optString("classid"),  this.mszCurrentUser
                    ) )>0
            ){
                if( bIsMultiple ){
                    continue;
                }
                this.alert( "'" + wordData.optString("en_root") + "'在单词本中已经存在", 0, -1 );
            }
            wordData.put("f_clan_name" ,
                    this.mysql().fetch(
                            String.format(
                                    "SELECT `f_clan_name` FROM %s WHERE `f_stub_name` = '%s'",
                                    this.alchemist().mutual().frag().tabFragsNS(),word.trim()
                            )
                    ).getJSONObject(0).getString("f_clan_name"));

            bRes &= this.mysql().insertWithArray( this.alchemist().user().fragment().tabRoots(), wordData.getMap() ) > 0;
        }


        this.checkResult( bRes, null,
                this.spawnActionQuerySpell("rootList" )+"&class_id=" + $_SPOST.optString("classid" )
        );
    }

    public void deleteOneRoot()throws IOException, SQLException {
        this.checkResult( this.deleteOneRoot( $_GSC().optString("id") ) );
    }

    public boolean deleteOneRoot( String szID ) throws IOException, SQLException {
        return this.mysql().deleteWithSQL( this.alchemist().user().fragment().tabRoots(), String.format(
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

        trace( $_SPOST );
        Map<String, String > condition = new TreeMap<>();
        condition.put( "id", szId );
        condition.put( "username", this.mszCurrentUser );
        this.checkResult(
                this.mysql().updateWithArray( this.alchemist().user().fragment().tabRoots(), data.getMap(),condition ) > 0
        );
    }

    public void saveSortedWordList() throws SQLException, IOException {
        PersonalFragmentsModel hModelBrother = (PersonalFragmentsModel)this.revealYokedModel();
        try{
            hModelBrother.beforeGenieInvoke();
        } catch ( Exception e ){
            return;
        }
        hModelBrother.rootList();

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
                String szWord = jGlossaryWordList.getJSONObject(i).optString("en_root");
                if( !indexSet.contains( szWord ) ){
                    indexSet.add( szWord );
                    data.put( "d_sort_id", indexSet.size() );
                    condition.put( "en_root", szWord );
                    bRes &= this.mysql().updateWithArray( this.alchemist().user().fragment().tabRoots(), data, condition ) > 0;
                }
            }
        }
        else {
            bRes = false;
        }
        this.checkResult( bRes, null, this.spawnActionQuerySpell( "wordList" ) + "&class_id=" + szClassId );
    }

    public void BuildCompare() throws SQLException {
        double Sum =0;
        double SqrtSum1 =0;
        double SqrtSum2 =0;
        int compare1[] = new int[100000];
        int compare2[] = new int[100000];

        String result = null;
        String szUsername = "undefined";
        String szFather_g_name = $_POST().optString("BuildA");
        String szSon_g_name = $_POST().optString("BuildB");

        JSONArray AllArray =this.mysql().fetch(String.format("SELECT `en_word` ,count(en_word) AS word_sum ,`classid` FROM %s AS tDict WHERE classid in \n" +
                        "(SELECT `classid` FROM %s AS tGlossary WHERE `username` = '%s' AND ( `g_name` = '%s' OR `g_name` = '%s')) GROUP BY en_word ORDER BY count(en_word) DESC",
                this.alchemist().user().glossary().tabWordsNS(),
                alchemist().user().pamphlet().tabPamphletsNS(),
                szUsername,szFather_g_name,szSon_g_name));

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