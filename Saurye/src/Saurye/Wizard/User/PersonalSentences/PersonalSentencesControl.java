package Saurye.Wizard.User.PersonalSentences;

import Pinecone.Framework.System.util.StringUtils;
import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.JSONBasedControl;
import Pinecone.Framework.Util.JSON.JSONArray;
import Pinecone.Framework.Util.JSON.JSONObject;
import Pinecone.Framework.Util.Random.SeniorRandom;
import Saurye.Peripheral.Skill.MVC.ControlLayerSkill;
import Saurye.Peripheral.Skill.Util.DateHelper;

import java.io.IOException;
import java.sql.SQLException;
import java.util.*;

public class PersonalSentencesControl extends PersonalSentences implements JSONBasedControl {
    public PersonalSentencesControl( ArchConnection connection ) {
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



    /** Sentence **/

    protected boolean saveSentenceWord( Map<String, String > map, String szWord ) throws SQLException {
        if( this.alchemist().mutual().word().hasSuchWord( szWord ) ){
            map.put( "en_word", szWord );
            return this.mysql().insertWithArray( this.alchemist().user().pamphlet().sentence().tabEnSentWords(), map ) > 0;
        }
        return true;
    }

    protected boolean saveSentenceWords( JSONObject $_SPOST, boolean bIsUpdate ) throws SQLException {
        Object dyWord = $_SPOST.opt( "en_word[]" );
        boolean bRes  = true;
        if( dyWord != null ) {
            String insertedId = $_SPOST.optString( "mega_id" ) ; // this.mysql().fetch( "SELECT LAST_INSERT_ID() AS `id`" )

            TreeMap<String, String > map = new TreeMap<>();
            map.put( "s_sent_id", insertedId );
            map.put( "username", this.mszCurrentUser );
            map.put( "ph_id", $_SPOST.optString( "index_of" ) );

            if( bIsUpdate ){
                this.mysql().deleteWithArray( this.alchemist().user().pamphlet().sentence().tabEnSentWords(), map );
            }

            if( dyWord instanceof String ){
                bRes = this.saveSentenceWord(map, (String) dyWord );
            }
            else {
                TreeSet<String > onlySet = new TreeSet<>();
                for( Object oWord : (JSONArray) dyWord ){
                    if( !onlySet.contains( (String)oWord ) ){
                        if( onlySet.size() > 8 ){
                            break;
                        }
                        bRes &= this.saveSentenceWord( map, (String)oWord );
                        onlySet.add( (String) oWord );
                    }
                }
            }
        }
        return bRes;
    }

    public void makeSentence() throws IOException, SQLException {
        JSONObject $_SPOST = this.$_POST( true );
        if( !$_SPOST.isEmpty() && !StringUtils.isEmpty( $_SPOST.optString( "index_of" ) ) ){
            JSONObject data    = $_SPOST.subJson( new String[] { "index_of", "s_sentence", "s_cn_def", "s_note" } );
            String szMId       = (new SeniorRandom()).nextString(20 );
            $_SPOST.put( "mega_id", szMId );
            data.put( "mega_id", szMId );
            data.put( "username", this.mszCurrentUser );
            data.put( "s_add_date", DateHelper.formatYMD() );

            boolean bRes = this.mysql().insertWithArray( this.alchemist().user().pamphlet().sentence().tabEnSentences(), data.getMap() ) > 0;

            bRes &= this.saveSentenceWords( $_SPOST, false );

            this.checkResult( bRes, null, $_SPOST.optString("referHref" ) );
        }
    }

    public void sentenceModify() throws IOException,SQLException {
        JSONObject $_SPOST = this.$_POST( true );
        if( !$_SPOST.isEmpty() && !StringUtils.isEmpty( $_SPOST.optString( "index_of" ) ) ){
            JSONObject data    = $_SPOST.subJson( new String[] { "index_of", "s_sentence", "s_cn_def", "s_note" } );
            data.put( "username", this.mszCurrentUser );
            data.put( "s_add_date", DateHelper.formatYMD() );

            TreeMap<String, String > conditionS = new TreeMap<>();
            conditionS.put( "mega_id",  $_SPOST.optString( "mega_id" ) );
            conditionS.put( "username", this.mszCurrentUser );
            boolean bRes = this.mysql().updateWithArray( this.alchemist().user().pamphlet().sentence().tabEnSentences(), data.getMap(), conditionS ) > 0;

            bRes &= this.saveSentenceWords( $_SPOST, true );

            this.checkResult( bRes, null, $_SPOST.optString("referHref" ) );
        }
    }

    public void deleteOneSentence()throws IOException, SQLException {
        this.checkResult( this.deleteOneSentence( $_GSC().optString("id") ) );
    }

    public boolean deleteOneSentence( String szID ) throws IOException, SQLException {
        return this.mysql().deleteWithSQL( this.alchemist().user().pamphlet().sentence().tabEnSentences(), String.format(
                " WHERE id='%s' AND username='%s'" , szID, this.mszCurrentUser )
        ) > 0; // Using trigger
    }

    public void sentenceMassDelete() throws IOException, SQLException {
        ControlLayerSkill.commonMassDelete( this, "id[]", "deleteOneSentence" );
    }

    public void saveSortedWordList() throws SQLException, IOException {
        PersonalSentencesModel hModelBrother = (PersonalSentencesModel)this.revealYokedModel();
        try{
            hModelBrother.beforeGenieInvoke();
        } catch ( Exception e ){
            return;
        }
        hModelBrother.sentenceList();

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




}