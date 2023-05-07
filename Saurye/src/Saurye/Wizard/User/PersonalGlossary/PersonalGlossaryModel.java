package Saurye.Wizard.User.PersonalGlossary;

import Pinecone.Framework.System.util.StringUtils;
import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Pagesion;
import Pinecone.Framework.Util.Summer.prototype.ModelEnchanter;
import Pinecone.Framework.Util.JSON.JSONArray;
import Saurye.Elements.User.Pamphlet.Glossary.BasicWordList;
import Saurye.Peripheral.Skill.Util.PaginateHelper;
import Saurye.System.Prototype.JasperModifier;

import java.io.IOException;
import java.sql.SQLException;


@JasperModifier
public class PersonalGlossaryModel extends PersonalGlossary implements Pagesion {
    private String mszSingleImgUploaderName = "SingleImgUploader";

    public PersonalGlossaryModel( ArchConnection connection ) {
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

        ////[Temporary] Config reading temporary code.
        this.mPageData.put( "GlossaryConfig", this.mysql().fetch(
                String.format(
                        "SELECT `pc_sort_default`, `pc_each_page` FROM %s WHERE `username` = '%s' AND `pc_rule` = 'global' " ,
                        this.alchemist().user().pamphlet().tabConfigsNS(),
                        this.mszCurrentUser
                )
        ).optJSONObject( 0 ) );
    }

    public void pamphletDeviser() throws SQLException {
        this.alchemist().user().pamphlet().studio( this ).pamphletDeviser();
    }

    public void pamphletEditor() throws SQLException, IOException {
        this.alchemist().user().pamphlet().studio( this ).pamphletEditor( this.isThisGenie() );
    }

    public void pamphletClone() throws SQLException, IOException {
        this.pamphletEditor();

        this.appendDefaultAttribute( this.mszSingleImgUploaderName, this.equipmentPeddler().purchase( this.mszSingleImgUploaderName ).mount(
                new JSONArray("[{'at':'pamphletCloneCoverField', 'name':'ph_img_href', 'src': ' /root/root/System/img/noimg.jpg' }]")
        ) );
    }

    public void pamphletCollection() throws SQLException {
        this.alchemist().user().pamphlet().studio( this ).pamphletCollection();
    }



    public void wordList() throws SQLException, IOException  {
        if( this.mPageData.hasOwnProperty( "GlossaryWordList" ) ){
            return;
        }
        String szClassId     = $_GSC().optString("class_id" );

        this.mPageData.put( "bIsReciting" ,this.glossaryIsReciting(szClassId));

        String szColumns     = "tBook.`ph_name`, tBook.`classid`, tBook.`ph_create_data`, tBook.`ph_img_href`, tBook.`ph_note`, tBook.`ph_c_usage`, tBook.`username`,tBook.`g_state`";
        boolean bIsOwned     = true;
        JSONArray glossaryProfile = this.mysql().fetch( String.format (
                "SELECT %s FROM %s AS tBook WHERE tBook.`ph_type` = 'glossary' AND tBook.`classid` = '%s' AND `username` = '%s' ",
                szColumns, this.alchemist().user().pamphlet().tabPamphletsNS(),
                szClassId, this.mszCurrentUser  )
        );
        if( glossaryProfile.isEmpty() ){
            glossaryProfile = this.mysql().fetch( String.format (
                    this.alchemist().user().pamphlet().getCollectedPamphletSQLProto( ),
                    szColumns, String.format( " WHERE tCol.`classid` = '%s' AND tCol.`username` = '%s' ", szClassId, this.mszCurrentUser ),
                    " WHERE tBook.`ph_authority` = 'public' "  )
            );
            this.mPageData.put( "bgReadonly" , true );
            bIsOwned = false;
        }

        if( StringUtils.isEmpty( szClassId ) || glossaryProfile.isEmpty() ){
            this.redirect( this.spawnActionQuerySpell() );
            this.stop();
        }

        this.mPageData.put( "GlossaryProfile", glossaryProfile );

        this.alchemist().user().glossary().wordFetcher().basicWordList().prepare(
                this.mszCurrentUser, szClassId, ( bIsOwned ? BasicWordList.Mode.M_OWNED : BasicWordList.Mode.M_SHARED )
        ).apply( this );
    }

    public void appendNewWord(){
        this.mPageData.put( "class_id",$_GSC().optString("class_id") );
    }

    public void wordsHistory() throws SQLException {
        this.mPageData.put( "bgHistoryMode" , true );

        this.alchemist().user().glossary().wordFetcher().basicWordList().prepare(
                this.mszCurrentUser, "", BasicWordList.Mode.M_HISTORY
        ).apply( this );
    }

    public void megaPamphlet() throws SQLException {
        this.mPageData.put( "glossaryWordEachSum", this.mysql().fetch( String.format(
                "SELECT tUIdx.*, tGlo.`ph_name` FROM " +
                        "( " +
                        "   SELECT COUNT(*) AS nCount, `classid`  FROM %s AS tUIdx WHERE tUIdx.`username` = '%s' GROUP BY tUIdx.`classid` " +
                        ") AS tUIdx LEFT JOIN %s AS tGlo ON tGlo.`classid` = tUIdx.`classid` ",
                this.alchemist().user().glossary().tabWordsNS(), this.mszCurrentUser,
                this.alchemist().user().pamphlet().tabPamphletsNS() )
        ) );

        this.mPageData.put( "glossaryWordSum", this.mysql().fetch( String.format(
                "SELECT COUNT( DISTINCT `en_word` ) AS nCount, `classid`  FROM %s AS tUIdx WHERE tUIdx.`username` = '%s'",
                this.alchemist().user().glossary().tabWordsNS(), this.mszCurrentUser )
        ).getJSONObject(0).optString("nCount") );

        this.mPageData.put( "glossaryWordPoS", this.mysql().fetch(
                String.format(
                "SELECT m_property, COUNT( m_property ) AS nCount  FROM" +
                "(" +
                "   SELECT `m_property`  FROM" +
                "   (" +
                "     ( SELECT tW.`en_word` AS `e_word` FROM %s AS tW WHERE tW.username = '%s' ) AS tW " +
                "     LEFT JOIN %s AS tDict  ON tW.`e_word` = tDict.`en_word` " +
                "   ) GROUP BY `e_word`" +
                ") AS tW GROUP BY `m_property`",
                        this.alchemist().user().glossary().tabWordsNS(), this.mszCurrentUser,
                        this.alchemist().mutual().dict().tabEn2CnNS()
                ) )
        );
    }

    public void wordsRank()  throws SQLException {
        String szMainSQL = String.format(
                "SELECT `id`, `en_word`, COUNT(`en_word`) AS nCount FROM %s AS tRecall WHERE `username` = '%s' %%s GROUP BY `en_word` ",
                this.alchemist().user().word().tabRecallNS(), this.mszCurrentUser
        );

        String szCondition = "";

        String szKeyWord = this.$_GSC().optString( "en_word" );
        if( !StringUtils.isEmpty( szKeyWord ) ){
            szCondition = " AND tRecall.`en_word` LIKE '" + szKeyWord + "'";
        }
        int nPageLimit = this.coach().model().adjustablePaginationPreTreat(this,
                String.format( "SELECT %%s FROM ( %s ) AS tRecall", szMainSQL ), szCondition, "COUNT(*)"
        );

        szMainSQL += " %s ";

        this.mPageData.put( "wordsRecallRanks" , this.mysql().fetch(
                String.format(
                        String.format(
                                "SELECT tRecall.*, tDict.`cn_word`, tDict.`m_property`  FROM ( %s ) AS tRecall " +
                                        "LEFT JOIN %s AS tDict ON tDict.`en_word` = tRecall.`en_word` GROUP BY tRecall.`en_word` ORDER BY `nCount` DESC , `id` ASC ",
                                szMainSQL , this.alchemist().mutual().dict().tabEnCnIndexNS()
                        ),
                        szCondition , " ORDER BY `nCount` DESC , `id` ASC " + PaginateHelper.formatLimitSentence (
                                this.mPageData.optLong( this.paginateProperty().getVarBeginNum() ), nPageLimit
                        )
                )
        ));
    }



    @ModelEnchanter
    public void loadGroupedDaily() throws SQLException {
        this.mPageData.put ( "DailyList", this.mysql().fetch( String.format(
                " SELECT tW.`d_add_date` FROM %s AS tW WHERE tW.`classid` = '%s' GROUP BY tW.`d_add_date` ORDER BY tW.`d_add_date` DESC " ,
                this.alchemist().user().pamphlet().glossary().tabWordsNS(),
                this.$_GSC().optString( "class_id" )
        ) ) );
    }
}