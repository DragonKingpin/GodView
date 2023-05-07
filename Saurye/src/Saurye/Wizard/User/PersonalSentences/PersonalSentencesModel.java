package Saurye.Wizard.User.PersonalSentences;

import Pinecone.Framework.System.util.StringUtils;
import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Pagesion;
import Pinecone.Framework.Util.Summer.prototype.ModelEnchanter;
import Pinecone.Framework.Util.JSON.JSONArray;
import Saurye.Elements.User.Pamphlet.Sentence.BasicSentenceList;
import Saurye.System.Prototype.JasperModifier;

import java.io.IOException;
import java.sql.SQLException;


@JasperModifier
public class PersonalSentencesModel extends PersonalSentences implements Pagesion {
    private String mszSingleImgUploaderName = "SingleImgUploader";

    public PersonalSentencesModel( ArchConnection connection ) {
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
        this.pamphletList();
    }

    public void pamphletList() throws SQLException {
        this.alchemist().user().pamphlet().studio( this ).exhibit();
    }

    public void pamphletDeviser() throws SQLException {
        this.alchemist().user().pamphlet().studio( this ).pamphletDeviser();
    }

    public void pamphletEditor() throws SQLException, IOException {
        this.alchemist().user().pamphlet().studio( this ).pamphletEditor( this.isThisGenie() );
    }

    public void glossaryClone() throws SQLException, IOException {
        this.pamphletEditor();

        this.appendDefaultAttribute( this.mszSingleImgUploaderName, this.equipmentPeddler().purchase( this.mszSingleImgUploaderName ).mount(
                new JSONArray("[{'at':'pamphletCloneCoverField', 'name':'g_img_href', 'src': ' /root/root/System/img/noimg.jpg' }]")
        ) );
    }

    public void pamphletCollection() throws SQLException {
        this.alchemist().user().pamphlet().studio( this ).pamphletCollection();
    }




    public void sentenceList() throws SQLException, IOException  {
        if( this.mPageData.hasOwnProperty( "SentenceWordList" ) ){
            return;
        }

        String szClassId     = $_GSC().optString("class_id" );
        String szColumns     = "tBook.`ph_name`, tBook.`classid`, tBook.`ph_create_data`, tBook.`ph_img_href`, tBook.`ph_note`, tBook.`ph_c_usage`, tBook.`username`";
        boolean bIsOwned     = true;
        JSONArray pamphletProfile = this.mysql().fetch( String.format (
                "SELECT %s FROM %s AS tBook WHERE tBook.`classid` = '%s' AND ph_type = 'sentence' AND `username` = '%s' ",
                szColumns, this.alchemist().user().pamphlet().tabPamphletsNS(),
                szClassId, this.mszCurrentUser  )
        );
        if( pamphletProfile.isEmpty() ){
            pamphletProfile = this.mysql().fetch( String.format (
                    this.alchemist().user().pamphlet().getCollectedPamphletSQLProto(),
                    szColumns, String.format( " WHERE tCol.`classid` = '%s' AND tCol.`username` = '%s' ", szClassId, this.mszCurrentUser ),
                    " WHERE tBook.`ph_authority` = 'public' "  )
            );
            this.mPageData.put( "bgReadonly" , true );
            bIsOwned = false;
        }

        if( StringUtils.isEmpty( szClassId ) || pamphletProfile.isEmpty() ){
            this.redirect( this.spawnActionQuerySpell() );
            this.stop();
        }

        this.mPageData.put( "SentenceProfile", pamphletProfile );

        this.alchemist().user().pamphlet().sentenceFetcher().basicSentenceList().prepare(
                this.mszCurrentUser, szClassId, ( bIsOwned ? BasicSentenceList.Mode.M_OWNED : BasicSentenceList.Mode.M_SHARED )
        ).apply( this );
    }

    public void sentenceModify() throws SQLException, IOException {
        String szMId = this.$_GSC().optString( "mega_id" );
        if( !StringUtils.isEmpty( szMId ) ){
            this.mPageData.put( "SentenceInfo" , this.mysql().fetch( String.format (
                    "SELECT tUIdx.`id`, tUIdx.`mega_id`, tUIdx.`index_of`, tUIdx.`username`, tUIdx.`s_sentence`, tUIdx.`s_cn_def`, tUIdx.`s_note` " +
                            "FROM %s AS tUIdx  WHERE tUIdx.`mega_id` = '%s' AND tUIdx.`username` = '%s' ",
                    this.alchemist().user().pamphlet().sentence().tabEnSentencesNS(),
                    szMId, this.mszCurrentUser
            ) ) );

            this.mPageData.put( "SentenceWordsInfo" , this.mysql().fetch( String.format (
                    "SELECT `en_word` FROM %s WHERE `s_sent_id` = '%s' AND `username` = '%s' ",
                    this.alchemist().user().pamphlet().sentence().tabEnSentWordsNS(),
                    szMId, this.mszCurrentUser
            ) ) );

            if( !this.mPageData.optJSONArray("SentenceInfo").isEmpty() ){
                return;
            }
        }

        this.redirect( this.spawnActionQuerySpell("sentenceList") + "&class_id=" + this.$_GSC().optString( "class_id" ) );
        this.stop();
    }

    public void makeSentence(){
        this.mPageData.put( "class_id",$_GSC().optString("class_id") );
    }

    @ModelEnchanter
    public void getKeyWords() throws SQLException {
        String szSentence = $_GSC().optString( "sentence" );
        this.mPageData.put( "keyWords",
                this.alchemist().mutual().sentence().logicTree().apply( szSentence ).keyWordify( false )
        );
    }

    public void megaPamphlet () throws SQLException {
        this.mPageData.put( "bgMegaMode" , true );

        this.alchemist().user().pamphlet().sentenceFetcher().basicSentenceList().prepare(
                this.mszCurrentUser, "", BasicSentenceList.Mode.M_MEGA_ALL
        ).apply( this );
    }



    @ModelEnchanter
    public void loadGroupedDaily() throws SQLException {
        this.mPageData.put ( "DailyList", this.mysql().fetch( String.format(
                " SELECT tW.`s_add_date` FROM %s AS tW WHERE tW.`index_of` = '%s' GROUP BY tW.`s_add_date` ORDER BY tW.`s_add_date` DESC " ,
                this.alchemist().user().pamphlet().sentence().tabEnSentencesNS(),
                this.$_GSC().optString( "class_id" )
        ) ) );
    }
}