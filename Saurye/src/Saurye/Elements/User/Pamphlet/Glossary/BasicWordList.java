package Saurye.Elements.User.Pamphlet.Glossary;

import Pinecone.Framework.System.util.StringUtils;
import Pinecone.Framework.Util.Summer.prototype.Pagesion;
import Saurye.Elements.EpitomeElement;
import Saurye.Elements.User.CoachShardedLayer;
import Saurye.Peripheral.Skill.Util.PaginateHelper;
import Saurye.System.PredatorArchWizardum;

import java.sql.SQLException;

public class BasicWordList extends CoachShardedLayer implements EpitomeElement {
    public enum Mode {
        M_OWNED, M_SHARED, M_HISTORY
    }

    private String  msqlInnerIndex        = "" ;
    private String  msqlInnerCondition    = "" ;
    private String  msqlOuterCondition    = "" ;
    private Mode    mMode                 = Mode.M_OWNED;

    public BasicWordList ( Glossary stereotype ){
        super( stereotype );
    }

    @Override
    public String elementName() {
        return this.getClass().getSimpleName();
    }

    @Override
    public Glossary stereotype() {
        return (Glossary) this.mStereotype;
    }

    public BasicWordList apply ( String sqlInnerIndex ){
        this.msqlInnerIndex = sqlInnerIndex;
        return this;
    }

    public BasicWordList apply ( String sqlInnerIndex, String sqlOuterCondition ) {
        this.msqlInnerIndex     = sqlInnerIndex;
        this.msqlOuterCondition = sqlOuterCondition;
        return this;
    }

    public BasicWordList apply ( String sqlInnerIndex, String sqlInnerCondition, String sqlOuterCondition ) {
        this.msqlInnerCondition = sqlInnerCondition;
        this.msqlOuterCondition = sqlOuterCondition;
        this.msqlInnerIndex     = String.format( sqlInnerIndex, this.msqlInnerCondition );
        return this;
    }

    public String getInnerIndex() {
        return this.msqlInnerIndex;
    }

    public String getInnerCondition() {
        return this.msqlInnerCondition;
    }

    public String getOuterCondition() {
        return this.msqlOuterCondition;
    }

    public String getInfoSQLProto ( int nSortType ) {
        String szBaseColumn    = "";
        String szBaseWeightSQL = "";
        if( nSortType >= 6 ){
            switch ( nSortType ){
                case 6:{
                    szBaseColumn    = " , tUBase.`w_over_base`, tUBase.`w_fq_spoken_base`, tUBase.`w_fq_newspaper_base`, tUBase.`w_fq_magazine_base` ";
                    break;
                }
                case 7:{
                    szBaseColumn    = " , tUBase.`w_over_base`, tUBase.`w_fq_fiction_base`, tUBase.`w_fq_newspaper_base`, tUBase.`w_fq_magazine_base` ";
                    break;
                }
                case 8:{
                    szBaseColumn    = " , tUBase.`w_over_base`, tUBase.`w_fq_acad_base` ";
                    break;
                }
                case 9:{
                    szBaseColumn    = " , tUBase.`w_his_base`, tUBase.`w_prevail_base` ";
                    break;
                }
                case 10:{
                    szBaseColumn    = " , tUBase.`w_e_base` ";
                    break;
                }
                case 11:{
                    szBaseColumn    = " , tUBase.`w_f_base` ";
                    break;
                }
                case 12:{

                    break;
                }
                case 13:{

                    break;
                }
                case 14:{
                    szBaseColumn    = " , tUBase.`w_over_base` ";
                    break;
                }
                case 15:
                case 16: {
                    szBaseColumn    = " , tUBase.`w_form_base`, tUBase.`w_f_def_base` ";
                    break;
                }
                default:{
                    break;
                }
            }

            szBaseWeightSQL = String.format(
                    " ) LEFT JOIN %s AS tUBase ON tUBase.`en_word` = tUIdx.`en_word` ",
                    this.master().mutual().word().tabWeightUnionBaseNS()
            );
        }

        return String.format(
                "SELECT tUIdx.*, " +
                        "       tDictEn2Cn.`cn_means`, tDictEn2Cn.`m_property`, tBand.`w_level_cache` AS `w_level`, tFreq.`w_freq_base` " + szBaseColumn +
                        "FROM ( " +
                        " ( " + (  nSortType < 6 ? "" : " ( "  ) +
                        "   ( " +
                        "       ( %s ) AS tUIdx " +
                        "       LEFT JOIN %s AS tDictEn2Cn ON tDictEn2Cn.`en_word` = tUIdx.`en_word` AND BINARY tUIdx.`en_word` = BINARY tDictEn2Cn.`en_word` " +
                        "   ) LEFT JOIN %s AS tBand ON tBand.`en_word` = tUIdx.`en_word` AND BINARY tUIdx.`en_word` = BINARY tBand.`en_word` " +
                        " ) LEFT JOIN %s AS tFreq ON tFreq.`en_word` = tUIdx.`en_word` %s " +
                        ") %%s ",
                this.msqlInnerIndex,
                this.master().mutual().dict().tabEn2CnNS(),
                this.master().mutual().glossary().tabBandNS(),
                this.master().mutual().word().tabWeightUnionBaseNS(),
                szBaseWeightSQL
        );
    }




    public class UGWBasicSort {
        private String msqlOuterSQL  = "" ;
        private String msqlIndexSort = " ORDER BY tUIdx.`d_sort_id` ";

        public UGWBasicSort ( int nSortType ) {
            this.assemble( nSortType );
        }

        public UGWBasicSort ( int nSortType, String sqlDefaultIndexSort ){
            this.msqlIndexSort = sqlDefaultIndexSort;
            this.assemble( nSortType );
        }

        private void assemble ( int nSortType ){
            if( nSortType < 6 ){
                switch ( nSortType ){
                    case 0:{
                        this.msqlIndexSort = " ORDER BY RAND() ";
                        break;
                    }
                    case 1:{
                        this.msqlIndexSort = " ORDER BY tUIdx.`en_word` ";
                        break;
                    }
                    case 2:{
                        this.msqlIndexSort = " ORDER BY CHAR_LENGTH( TRIM( tUIdx.`en_word` ) ), tUIdx.`en_word`  ";
                        break;
                    }
                    case 3:{
                        this.msqlIndexSort  = "";
                        this.msqlOuterSQL   = " ORDER BY IF( tFreq.`w_freq_base` IS NULL OR tFreq.`w_freq_base` = 0, 99999999, tFreq.`w_freq_base` ),tUIdx.`id`  ";
                        break;
                    }
                    case 4:{
                        this.msqlIndexSort = " ORDER BY tUIdx.`id` ";
                        break;
                    }
                    case 5:{
                        this.msqlIndexSort = " ORDER BY tUIdx.`id` DESC, tUIdx.`" + getDateColumnName() + "` DESC";
                        break;
                    }
                    default:{
                        break;
                    }
                }
            }
            if( nSortType >= 6 ){
                switch ( nSortType ){
                    case 6:{
                        this.msqlIndexSort  = "";
                        this.msqlOuterSQL   =  " ORDER BY ( tUBase.`w_over_base` * 0.25 + ( " +
                                "( tUBase.`w_fq_spoken_base` + tUBase.`w_fq_newspaper_base` + tUBase.`w_fq_magazine_base` ) / 3 ) * 0.75 )  ASC ";
                        break;
                    }
                    case 7:{
                        this.msqlIndexSort  = "";
                        this.msqlOuterSQL   =  " ORDER BY ( tUBase.`w_over_base` * 0.25 + ( " +
                                "( tUBase.`w_fq_fiction_base` + tUBase.`w_fq_newspaper_base` + tUBase.`w_fq_magazine_base` ) / 3 ) * 0.75 )  ASC ";
                        break;
                    }
                    case 8:{
                        this.msqlIndexSort  = "";
                        this.msqlOuterSQL   =  " ORDER BY ( tUBase.`w_over_base` * 0.25 + tUBase.`w_fq_acad_base` * 0.75 )  ASC ";
                        break;
                    }
                    case 9:{
                        this.msqlIndexSort  = "";
                        this.msqlOuterSQL   =  " ORDER BY ( tUBase.`w_his_base` * 0.75 + tUBase.`w_prevail_base` * 0.25 )  ASC ";
                        break;
                    }
                    case 10:{
                        this.msqlIndexSort  = "";
                        this.msqlOuterSQL   =  " ORDER BY tUBase.`w_e_base` ASC ";
                        break;
                    }
                    case 11:{
                        this.msqlIndexSort  =  "";
                        this.msqlOuterSQL   =  " ORDER BY tUBase.`w_f_base` ASC ";
                        break;
                    }
                    case 12:{

                        break;
                    }
                    case 13:{

                        break;
                    }
                    case 14:{
                        this.msqlIndexSort  =  "";
                        this.msqlOuterSQL   =  " ORDER BY tUBase.`w_over_base` ASC ";
                        break;
                    }
                    case 15: {
                        this.msqlIndexSort  = "";
                        this.msqlOuterSQL   =  " ORDER BY ( tUBase.`w_form_base` * 0.5 + tUBase.`w_f_def_base` * 0.5 )  ASC ";
                        break;
                    }
                    case 16: {
                        this.msqlIndexSort  = "";
                        this.msqlOuterSQL   =  " ORDER BY ( tUBase.`w_form_base` * 0.5 + tUBase.`w_f_def_base` * 0.5 )  DESC ";
                        break;
                    }
                    default:{
                        break;
                    }
                }
            }
        }

        public String getSqlIndexSort() {
            return this.msqlIndexSort;
        }

        public String getSqlOuterSQL() {
            return this.msqlOuterSQL;
        }

    }

    public BasicWordList.UGWBasicSort spawnUGBasicSort( int nSortType ){
        return new BasicWordList.UGWBasicSort( nSortType );
    }

    public BasicWordList.UGWBasicSort spawnUGBasicSort( int nSortType, String sqlDefaultIndexSort ){
        return new BasicWordList.UGWBasicSort( nSortType, sqlDefaultIndexSort );
    }




    private String                     mszCurrentUser ;
    private String                     mszClassId     ;
    private PredatorArchWizardum mSoul          ;

    public BasicWordList prepare ( String szCurrentUser, String szClassId, Mode mode ) {
        this.mszCurrentUser = szCurrentUser;
        this.mszClassId     = szClassId;
        this.mMode          = mode;
        return this;
    }

    private boolean isGlossaryMode() {
       return this.mMode == Mode.M_OWNED || this.mMode == Mode.M_SHARED;
    }

    private boolean isHistoryMode()  { return this.mMode == Mode.M_HISTORY; }

    private String getDateColumnName() {
        if( this.isGlossaryMode() ){
            return  "d_add_date";
        }
        else if( this.isHistoryMode() ){
            return  "w_add_time";
        }

        return  "d_add_date";
    }

    private String spliceDateRange() {
        String szStartTime = this.mSoul.$_GSC().optString( "startTime" );
        String szEndTime   = this.mSoul.$_GSC().optString( "endTime"   );

        String sqlRange   = "";
        boolean bHasStart = !StringUtils.isEmpty( szStartTime ), bHasEnd = !StringUtils.isEmpty( szEndTime );
        String szDateCol  = this.getDateColumnName();

        if( bHasStart && bHasEnd ){
            sqlRange = String.format( " AND tUIdx.`%s` >= '%s' AND tUIdx.`%s` <= '%s'", szDateCol, szStartTime, szDateCol, szEndTime );
        }
        else if( bHasStart ){
            sqlRange = String.format( " AND tUIdx.`%s` >= '%s'", szDateCol, szStartTime );
        }
        else if( bHasEnd ){
            sqlRange = String.format( " AND tUIdx.`%s` <= '%s'", szDateCol, szEndTime );
        }

        return sqlRange;
    }

    private String spliceIndexSQL() {
        String szIndexSQL = "", sqlDateRange = this.spliceDateRange();
        if( this.isGlossaryMode() ){
            szIndexSQL =  String.format( "SELECT %%s FROM %s AS tUIdx WHERE tUIdx.`classid` = '%s' %s %%s",
                    this.master().user().glossary().tabWordsNS(), this.mszClassId, sqlDateRange
            );
        }
        else if( this.isHistoryMode() ){
            szIndexSQL =  String.format( "SELECT %%s FROM %s AS tUIdx WHERE tUIdx.`username` = '%s' %s %%s ",
                    this.master().user().word().tabRecordNS(), this.mszCurrentUser, sqlDateRange
            );
        }

        String szBandType = this.mSoul.$_GSC().optString( "band_type" );
        if( !StringUtils.isEmpty( szBandType ) ){
            String szMainSQL = "";

            String szBandSQL = String.format (
                    "( SELECT `en_word` AS `m_word` FROM %s AS tGWord WHERE tGWord.`g_name` = '%s' ) AS tGWord " +
                            "WHERE tUIdx.`en_word` = tGWord.`m_word` ",
                    this.master().mutual().glossary().tabBookNS(), szBandType
            );

            if( this.isGlossaryMode() ){
                szMainSQL = String.format(
                        "SELECT * FROM %s AS tUIdx, %s AND tUIdx.`classid` = '%s' %s %%s ",
                        this.master().user().glossary().tabWordsNS(), szBandSQL, this.mszClassId, sqlDateRange
                );
            }
            else if( this.isHistoryMode() ){
                szMainSQL = String.format(
                        "SELECT * FROM %s AS tUIdx, %s AND tUIdx.`username` = '%s' %s %%s ",
                        this.master().user().word().tabRecordNS(), szBandSQL, this.mszCurrentUser, sqlDateRange
                );
            }

            szIndexSQL = "SELECT %s FROM ( " + szMainSQL + " ) AS tUIdx " ;
        }

        return szIndexSQL;
    }

    private void applyMode( String szIndexSQL ){
        if( this.isGlossaryMode() ){
            this.apply( String.format( szIndexSQL, "tUIdx.*", "%s" ) );
        }
        else if( this.isHistoryMode() ){
            this.apply (
                    String.format (
                            szIndexSQL, " tUIdx.`id`, tUIdx.`username`,tUIdx.`en_word`, LEFT( tUIdx.`w_add_time`, 10 ) AS `d_add_date` ", "%s"
                    )
            );
        }
    }

    public BasicWordList apply ( PredatorArchWizardum soul ) throws SQLException {
        this.mSoul = soul;

        String szIndexSQL = this.spliceIndexSQL();
        this.applyMode( szIndexSQL );

        String sqlIdxInnerCondition  = this.mMode == Mode.M_OWNED ? " AND username = '" + this.mszCurrentUser + "' " : "";

        int nSortType = soul.$_GSC().hasOwnProperty( "sort_type" ) ? soul.$_GSC().optInt("sort_type" ) : -1;
        String sqlRawWordList = this.getInfoSQLProto( nSortType );

        String szKeyWord = soul.$_GSC().optString( "en_word" );
        if( !StringUtils.isEmpty( szKeyWord ) ){
            sqlIdxInnerCondition = " AND tUIdx.`en_word` LIKE '" + szKeyWord + "'";
        }

        int nPageLimit = this.coach().model().adjustablePaginationPreTreat( (Pagesion) soul,
                String.format( szIndexSQL, "%s", "%s" ), sqlIdxInnerCondition
        );

        String sqlOuterSQL  = "" ;
        String sqlIndexSort = this.mMode == Mode.M_HISTORY ? " ORDER BY tUIdx.`id` " : " ORDER BY tUIdx.`d_sort_id` ";

        if( nSortType >= 0 ){
            UGWBasicSort basicSort;
            if( this.isHistoryMode() ){
                basicSort  = this.spawnUGBasicSort( nSortType, sqlOuterSQL );
            }
            else {
                basicSort  = this.spawnUGBasicSort( nSortType );
            }
            sqlIndexSort = basicSort.getSqlIndexSort();
            sqlOuterSQL  = basicSort.getSqlOuterSQL();
        }

        sqlIdxInnerCondition += sqlIndexSort;


        String sz = "";

        soul.getPageData().put( "WordList",this.mysql().fetch( sz = String.format( sqlRawWordList,
                sqlIdxInnerCondition + " " + PaginateHelper.formatLimitSentence(
                        soul.getPageData().optLong( this.master().host().properties().paginate().getVarBeginNum() ), nPageLimit
                ), sqlOuterSQL ) )
        );


        //Debug.trace( this.mysql().getLastSQLSentence() );

        return this;
    }

}