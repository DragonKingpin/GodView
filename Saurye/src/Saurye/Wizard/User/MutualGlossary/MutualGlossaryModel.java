package Saurye.Wizard.User.MutualGlossary;

import Pinecone.Framework.System.util.StringUtils;
import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Pagesion;
import Pinecone.Framework.Util.JSON.JSONArray;
import Saurye.Elements.User.Pamphlet.Glossary.BasicWordList;
import Saurye.Peripheral.Skill.Util.PaginateHelper;
import Saurye.System.Prototype.JasperModifier;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Vector;


@JasperModifier
public class MutualGlossaryModel extends MutualGlossary implements Pagesion {
    public MutualGlossaryModel( ArchConnection connection ) {
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
        this.mutualGlossaryList();
    }

    public String filter ( String szCondition,Vector<String> conditionVector){

        if(!conditionVector.isEmpty()) {
            for(String szKey:conditionVector ){
                if(!StringUtils.isEmpty( $_GSC().optString( szKey ) )){
                    szCondition += String.format(" AND `%s` LIKE '%s' ",szKey,$_GSC().optString( szKey ));
                }
            }
        }

        return szCondition;
    }

    public void mutualGlossaryList() throws SQLException {
        if( this.mszCurrentUser != null ) {
            String szCondition = " WHERE `ph_type` = 'glossary' AND `ph_authority` = 'public' ";

            String szModelUserBuildSQL = String.format(
                    "SELECT %%s FROM %s AS tGlossary %%s",
                    this.alchemist().user().pamphlet().tabPamphletsNS()
            );

            Vector<String> conditionVector = new Vector<String>();
            conditionVector.add("ph_name");
            szCondition = this.filter( szCondition ,conditionVector);


            int nPageLimit = this.coach().model().adjustablePaginationPreTreat(
                    this, szModelUserBuildSQL, szCondition, "COUNT(*)",
                    this.getModularConfig().optInt( "glossaryPageLimit" )
            );

            this.mPageData.put(
                    "PamphletList", this.mysql().fetch(
                            String.format( szModelUserBuildSQL,
                                    "`ph_name`,`ph_create_data`,`username`,`classid`,`ph_c_usage`,`ph_img_href`,`ph_c_usage`",
                                    szCondition + PaginateHelper.formatLimitSentence(
                                            this.mPageData.optLong( this.paginateProperty().getVarBeginNum() ), nPageLimit
                                    )
                            )
                    )
            );

        }
    }

    public void systemGlossaryList() throws  SQLException {
        String szCondtionSQL        = "WHERE `g_authority` = 'public'";
        String szSystemWordBuildSQL = "SELECT `g_name` AS classid,`g_nickname` AS g_name,`g_create_data`,`g_level`,`g_authority`,`g_c_usage`,`g_note`,`gt_name` FROM %s %s";


        int nPageLimit = this.coach().model().adjustablePaginationPreTreat(
                this, szSystemWordBuildSQL, szCondtionSQL, "COUNT(*)",
                this.getModularConfig().optInt( "glossaryPageLimit" )
        );

        this.mPageData.put( "systemGlossaryList",this.mysql().fetch(String.format(
                szSystemWordBuildSQL,this.alchemist().mutual().glossary().tabGlossaryNS(),
                szCondtionSQL + PaginateHelper.formatLimitSentence(
                        this.mPageData.optLong( this.paginateProperty().getVarBeginNum() ),nPageLimit
                )
        )));
    }

    public void wordList() throws SQLException,IOException{

        String szClassId     = $_GSC().optString("class_id" );
        String szColumns     = "tBook.`ph_name`, tBook.`classid`, tBook.`ph_create_data`, tBook.`ph_img_href`, tBook.`ph_note`, tBook.`ph_c_usage`, tBook.`username`";

        JSONArray glossaryProfile = this.mysql().fetch( String.format (
                "SELECT %s FROM %s AS tBook WHERE tBook.`classid` = '%s' AND `username` = '%s' ",
                szColumns, this.alchemist().user().pamphlet().tabPamphletsNS(),
                szClassId, this.mszCurrentUser  )
        );
        this.mPageData.put( "bgReadonly" , true );
        if( glossaryProfile.isEmpty() ){
             glossaryProfile = this.mysql().fetch( String.format (
                    "SELECT %s FROM %s AS tBook WHERE tBook.`classid` = '%s'",
                    szColumns, this.alchemist().user().pamphlet().tabPamphletsNS(),
                    szClassId)
            );
            this.mPageData.put( "bgReadonly" , false );
            if( this.mysql().countFromTable(
                    String.format( "SELECT COUNT(*) FROM %s WHERE username = '%s' AND classid = '%s' ",
                            this.alchemist().user().pamphlet().tabCollectionNS(),this.mszCurrentUser,
                            szClassId
                    ) )>0
            ){
                this.mPageData.put( "bgReadonly" ,true );
            }
        }

        this.mPageData.put( "GlossaryProfile", glossaryProfile );

        this.alchemist().user().glossary().wordFetcher().basicWordList().prepare(
                this.mszCurrentUser, szClassId, BasicWordList.Mode.M_SHARED
        ).apply( this );
    }


    public void wordSystemList() throws SQLException,IOException{
        String szClassId  = $_GSC().optString("class_id" );
        JSONArray glossaryProfile = this.mysql().fetch( String.format (
                "SELECT tBook.`g_name` AS classid, tBook.`g_nickname` AS g_name, tBook.`g_create_data`, tBook.`g_img_href`, tBook.`g_note`, tBook.`g_c_usage`,tBook.`gt_name` " +
                        " FROM %s AS tBook WHERE tBook.`g_name` = '%s' ",
                this.alchemist().mutual().glossary().tabGlossaryNS(),
                szClassId )
        );

        if( StringUtils.isEmpty( szClassId ) || glossaryProfile.isEmpty() ){
            this.redirect( this.spawnActionQuerySpell() );
            this.stop();
        }

        this.mPageData.put( "GlossaryProfile", glossaryProfile );

        String sqlWordListCondition  = "";

        String sqlRawWordList = String.format(
                "SELECT tUD.`id`,tUD.`en_word`,tUD.`g_name` AS classid, " +
                        "       tDictEn2Cn.`cn_means`, tDictEn2Cn.`m_property`, tBand.`w_level_cache` AS `w_level`, tFreq.`coca_rank` " +
                        "FROM ( " +
                        " ( " +
                        "   ( " +
                        "       ( SELECT tUD.* FROM %s AS tUD WHERE tUD.`g_name` = '%s' %%s ) AS tUD " +
                        "       LEFT JOIN %s AS tDictEn2Cn ON tDictEn2Cn.`en_word` = tUD.`en_word` AND BINARY tUD.`en_word` = BINARY tDictEn2Cn.`en_word` " +
                        "   ) LEFT JOIN %s AS tBand ON tBand.`en_word` = tUD.`en_word` AND BINARY tUD.`en_word` = BINARY tBand.`en_word` " +
                        " ) LEFT JOIN %s AS tFreq ON tFreq.`en_word` = tUD.`en_word` " +
                        ")",
                this.alchemist().mutual().glossary().tabBookNS(), szClassId,
                this.alchemist().mutual().dict().tabEn2CnNS(),
                this.alchemist().mutual().glossary().tabBandNS(),
                this.alchemist().mutual().word().tabFrequencyNS()
        );



        int nPageLimit = this.coach().model().adjustablePaginationPreTreat( this, String.format (
                "SELECT %%s FROM %s AS tUD WHERE tUD.`ph_name` = '%s' %%s", this.alchemist().user().glossary().tabWordsNS(), szClassId ), sqlWordListCondition
        );

        this.mPageData.put( "GlossaryWordList",this.mysql().fetch( String.format( sqlRawWordList,
                sqlWordListCondition + " " + PaginateHelper.formatLimitSentence(
                        this.mPageData.optLong( this.paginateProperty().getVarBeginNum() ), nPageLimit
                )) )
        );
    }

}