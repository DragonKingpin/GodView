package Saurye.Wizard.User.PersonalFragments;

import Pinecone.Framework.Debug.Debug;
import Pinecone.Framework.System.util.StringUtils;
import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Pagesion;
import Pinecone.Framework.Util.JSON.JSONArray;
import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.Elements.User.Fragment.FragmentFetcher.BasicRootList;
import Saurye.Peripheral.Skill.Util.PaginateHelper;
import Saurye.System.Prototype.JasperModifier;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Vector;


@JasperModifier
public class PersonalFragmentsModel extends PersonalFragments implements Pagesion {
    private String mszSingleImgUploaderName = "SingleImgUploader";

    public PersonalFragmentsModel( ArchConnection connection ) {
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
        this.glossaryList();
    }

    public String filter (String szCondition, Vector<String> conditionVector){
        if(!conditionVector.isEmpty()) {
            for(String szKey:conditionVector ){
                if(!StringUtils.isEmpty( $_GSC().optString( szKey ) )){
                    if( szCondition.isEmpty() ){
                        szCondition+=" WHERE "+String.format(" `%s` LIKE '%s' ",szKey,$_GSC().optString( szKey ));
                    }
                    else{
                        szCondition += String.format(" AND `%s` LIKE '%s' ",szKey,$_GSC().optString( szKey ));
                    }

                }
            }
        }

        return szCondition;
    }


    public void glossaryList() throws SQLException {
        if( this.mszCurrentUser != null ) {
            String szCondition = " WHERE `username` = '" + this.mszCurrentUser + "' AND `ph_type` = 'fragment' ";

            String szModelSQL = String.format(
                    "SELECT %%s From %s AS tGlossary %%s",
                    this.alchemist().user().fragment().tabGlossaryNS()
            );

            Vector<String> conditionVector = new Vector<String>();
            conditionVector.add( "ph_name" );
            conditionVector.add( "ph_authority" );
            szCondition = this.filter( szCondition,conditionVector );

            trace( szCondition );

            int nPageLimit = this.coach().model().adjustablePaginationPreTreat(
                    this, szModelSQL, szCondition, "COUNT(*)",
                    this.getModularConfig().optInt( "pamphletPageLimit" )
            );

            this.mPageData.put(
                    "PamphletList", this.mysql().fetch(
                            String.format( szModelSQL,
                                    "`ph_name`,`ph_create_data`,`ph_authority`,`classid`,`ph_c_usage`,`ph_img_href`,`ph_c_usage`",
                                    szCondition + PaginateHelper.formatLimitSentence(
                                            this.mPageData.optLong( this.paginateProperty().getVarBeginNum() ), nPageLimit
                                    )
                            )
                    )
            );

            Debug.trace(mPageData.optJSONArray("PamphletList"));

        }
    }

    public void glossaryCollection() throws SQLException {
        if( this.mszCurrentUser != null ) {
            String szCondition     = " WHERE `username` = '" + this.mszCurrentUser + "' ";
            String sqlOutCondition = "";


            String szModelSQL = this.alchemist().user().fragment().getCollectedGlossarySQLProto();

            Vector<String> conditionVector = new Vector<String>();
            conditionVector.add( "ph_name");
            sqlOutCondition = this.filter(sqlOutCondition,conditionVector);

            int nPageLimit = this.coach().model().adjustablePaginationPreTreat(
                    this, String.format( szModelSQL, "%s", szCondition , "%s" ), sqlOutCondition ,"COUNT(*)",
                    this.getModularConfig().optInt( "pamphletPageLimit" )
            );

            this.mPageData.put(
                    "collectedPamphletList", this.mysql().fetch(
                            String.format( szModelSQL,
                                    "tBook.`ph_name`, tBook.`ph_create_data`, tBook.`username`, tBook.`classid`, tBook.`ph_c_usage`, tBook.`ph_img_href`, tBook.`ph_c_usage`",
                                    szCondition + PaginateHelper.formatLimitSentence(
                                            this.mPageData.optLong( this.paginateProperty().getVarBeginNum() ), nPageLimit
                                    ), sqlOutCondition
                            )
                    )
            );

        }
    }

    public void rootList() throws SQLException, IOException  {
        if( this.mPageData.hasOwnProperty( "GlossaryRootList" ) ){
            return;
        }
        String szClassId     = $_GSC().optString("class_id" );
        String szColumns     = "tBook.`ph_name`, tBook.`classid`, tBook.`ph_create_data`, tBook.`ph_img_href`, tBook.`ph_note`, tBook.`ph_c_usage`, tBook.`username`";
        boolean bIsOwned     = true;
        JSONArray glossaryProfile = this.mysql().fetch( String.format (
                "SELECT %s FROM %s AS tBook WHERE tBook.`classid` = '%s' AND `username` = '%s' AND `ph_type` = 'fragment'",
                szColumns, this.alchemist().user().fragment().tabGlossaryNS(),
                szClassId, this.mszCurrentUser  )
        );

        if( glossaryProfile.isEmpty() ){
            glossaryProfile = this.mysql().fetch( String.format (
                    this.alchemist().user().fragment().getCollectedGlossarySQLProto(),
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

        this.alchemist().user().fragment().fragmentFetcher().basicRootList().prepare(
                this.mszCurrentUser, szClassId, ( bIsOwned ? BasicRootList.Mode.M_OWNED : BasicRootList.Mode.M_SHARED )
        ).apply( this );
    }

    public void appendNewGlossary() {
        this.appendDefaultAttribute( this.mszSingleImgUploaderName, this.equipmentPeddler().purchase( this.mszSingleImgUploaderName ).mount(
                new JSONArray("[{'at':'newPamphletCoverField', 'name':'ph_img_href', 'src': ' /root/root/System/img/noimg.jpg' }]")
        ) );
    }

    public void editGlossary() throws SQLException, IOException {
        String szClassId = $_GSC().optString("class_id" );

        JSONObject data = this.mysql().fetch(
                String.format( "SELECT `classid`,`ph_name`, `username`, `ph_note`,`ph_img_href`,`ph_authority` FROM %s WHERE `classid`= '%s' AND `ph_type` = 'fragment'"
                        ,this.alchemist().user().fragment().tabGlossaryNS()
                        ,szClassId )
        ).optJSONObject(0);

        if( StringUtils.isEmpty( szClassId ) || data == null ){
            this.redirect( this.spawnActionQuerySpell() );
            this.stop();
        }

        this.mPageData.put("oldGlossaryProfile", data  );

        if( this.isThisGenie() ){
            String szImgUrl = this.mPageData.optJSONObject("oldGlossaryProfile").optString("ph_img_href");
            this.appendDefaultAttribute( this.mszSingleImgUploaderName, this.equipmentPeddler().purchase( this.mszSingleImgUploaderName ).mount(
                    new JSONArray("[{'at':'glossaryCoverField', 'name':'ph_img_href', 'src': '"+szImgUrl+"' }]")
            ) );
        }
    }

    public void glossaryClone() throws SQLException, IOException {
        this.editGlossary();

        this.appendDefaultAttribute( this.mszSingleImgUploaderName, this.equipmentPeddler().purchase( this.mszSingleImgUploaderName ).mount(
                new JSONArray("[{'at':'pamphletCloneCoverField', 'name':'ph_img_href', 'src': ' /root/root/System/img/noimg.jpg' }]")
        ) );
    }

    public void appendNewRoot(){
        this.mPageData.put( "class_id",$_GSC().optString("class_id") );
    }

    public void overallAnalysis() throws SQLException {
        this.mPageData.put( "glossaryWordEachSum", this.mysql().fetch( String.format(
                "SELECT tUIdx.*, tGlo.`g_name` FROM " +
                        "( " +
                        "   SELECT COUNT(*) AS nCount, `classid`  FROM %s AS tUIdx WHERE tUIdx.`username` = '%s' GROUP BY tUIdx.`classid` " +
                        ") AS tUIdx LEFT JOIN %s AS tGlo ON tGlo.`classid` = tUIdx.`classid` ",
                this.alchemist().user().glossary().tabWordsNS(), this.mszCurrentUser,
                alchemist().user().pamphlet().tabPamphletsNS() )
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

    //    public void root1List() throws SQLException, IOException  {
//        if( this.mPageData.hasOwnProperty( "GlossaryRootList" ) ){
//            return;
//        }
//        String szClassId     = $_GSC().optString("class_id" );
//        String szColumns     = "tBook.`ph_name`, tBook.`classid`, tBook.`ph_create_data`, tBook.`ph_img_href`, tBook.`ph_note`, tBook.`ph_c_usage`, tBook.`username`";
//        boolean bIsOwned     = true;
//
//        JSONArray glossaryProfile = this.mysql().fetch( String.format (
//                "SELECT %s FROM %s AS tBook WHERE tBook.`classid` = '%s' AND `username` = '%s' AND `ph_type` = 'fragment'",
//                szColumns, this.alchemist().user().fragment().tabGlossaryNS(),
//                szClassId, this.mszCurrentUser  )
//        );
//
//        if( glossaryProfile.isEmpty() ){
//            glossaryProfile = this.mysql().fetch( String.format (
//                    this.alchemist().user().fragment().getCollectedGlossarySQLProto(),
//                    szColumns, String.format( " WHERE tCol.`classid` = '%s' AND tCol.`username` = '%s' ", szClassId, this.mszCurrentUser ),
//                    " WHERE tBook.`ph_authority` = 'public' "  )
//            );
//            this.mPageData.put( "bgReadonly" , true );
//            bIsOwned = false;
//        }
//
//        if( StringUtils.isEmpty( szClassId ) || glossaryProfile.isEmpty() ){
//
//            this.redirect( this.spawnActionQuerySpell() );
//            this.stop();
//        }
//
//        this.mPageData.put( "GlossaryProfile", glossaryProfile );
//
//        String sqlWordListCondition = " ";
//
//        String szUserCondition= "";
//        if ( bIsOwned ){
//            szUserCondition = String.format(" AND username = '%s'",this.mszCurrentUser);
//        }
//
//        String sqlRootList = String.format(
//                "SELECT tUD.*, " +
//                        "       tDefs.`cn_def` AS 'cn_means', tEpitome.`w_epitome`, tAffixes.`en_fragment` " +
//                        "FROM ( " +
//                        " ( " +
//                        "   ( " +
//                        "       ( SELECT tUD.* FROM %s AS tUD WHERE tUD.`classid` = '%s' %s %%s ) AS tUD " +
//                        "       LEFT JOIN %s AS tDefs ON  tDefs.`f_clan_name` = tUD.`f_clan_name` AND BINARY tUD.`f_clan_name` = BINARY  tDefs.`f_clan_name` " +
//                        "   ) LEFT JOIN %s AS tEpitome ON tEpitome.`f_clan_name` = tUD.`f_clan_name` AND BINARY tUD.`f_clan_name` = BINARY tEpitome.`f_clan_name` " +
//                        " ) LEFT JOIN %s AS tAffixes ON tAffixes.`f_stub_name` = tUD.`en_root` " +
//                        ") %%s ",
//                this.alchemist().user().fragment().tabRootsNS(), szClassId, szUserCondition,
//                this.alchemist().mutual().frag().tabCDefsNS(),
//                this.alchemist().mutual().frag().tabHomologuesNS(),
//                this.alchemist().mutual().frag().tabFragsNS()
//        );
//
//
//        String szKeyWord = this.$_GSC().optString( "en_root" );
//        if( !StringUtils.isEmpty( szKeyWord ) ){
//            sqlWordListCondition = " AND tUD.`en_root` LIKE '" + szKeyWord + "'";
//        }
//
//        int nPageLimit = this.coach().model().adjustablePaginationPreTreat( this, String.format (
//                "SELECT %%s FROM %s AS tUD WHERE tUD.`classid` = '%s' %%s", this.alchemist().user().fragment().tabRootsNS(), szClassId ), sqlWordListCondition
//        );
//
//
//        String szOutSortSQL = "" ;
//        String sqlIndexSort = " ORDER BY tUD.`d_sort_id` ";
//        int nSortType = $_GSC().hasOwnProperty( "sort_type" ) ? $_GSC().optInt("sort_type" ) : -1;
//        switch ( nSortType ){
//            case 0:{
//                sqlIndexSort = " ORDER BY RAND() ";
//                break;
//            }
//            case 1:{
//                sqlIndexSort = " ORDER BY tUD.`en_root` ";
//                break;
//            }
//            case 2:{
//                sqlIndexSort = " ORDER BY CHAR_LENGTH( TRIM( tUD.`en_root` ) ), tUD.`en_root`  ";
//                break;
//            }
//            case 3:{
//                sqlIndexSort  = "";
//                szOutSortSQL  = " ORDER BY IF( tFreq.`coca_rank` IS NULL OR tFreq.`coca_rank` = 0, 99999999, tFreq.`coca_rank` ),tUD.`id`  ";
//                break;
//            }
//            case 4:{
//                sqlIndexSort = " ORDER BY tUD.`id` ";
//                break;
//            }
//            default:{
//                break;
//            }
//        }
//
//        sqlWordListCondition += sqlIndexSort;
//
//        this.mPageData.put( "bReadonly",bIsOwned );
//
//        this.mPageData.put( "GlossaryRootList",this.mysql().fetch( String.format( sqlRootList,
//                sqlWordListCondition + " " + PaginateHelper.formatLimitSentence(
//                        this.mPageData.optLong( this.paginateProperty().getVarBeginNum() ), nPageLimit
//                ), szOutSortSQL )+" GROUP BY `en_root`")
//        );
//    }

}