package Saurye.Elements.User.Fragment.FragmentFetcher;

import Pinecone.Framework.System.util.StringUtils;
import Pinecone.Framework.Util.Summer.prototype.Pagesion;
import Saurye.Elements.EpitomeElement;
import Saurye.Elements.User.CoachShardedLayer;
import Saurye.Elements.User.Fragment.Fragment;
import Saurye.Peripheral.Skill.Util.PaginateHelper;
import Saurye.System.PredatorArchWizardum;

import java.sql.SQLException;
import java.util.Vector;

public class BasicRootList extends CoachShardedLayer implements EpitomeElement {
    public enum Mode {
        M_OWNED, M_SHARED
    }

    private String  msqlInnerIndex        = "" ;
    private String  msqlInnerCondition    = "" ;
    private String  msqlOuterCondition    = "" ;
    private Mode    mMode                 = Mode.M_OWNED;
    private String  msqlTypeCondition     =" AND `ph_type` = 'fragment' ";

    public BasicRootList ( Fragment stereotype ){
        super( stereotype );
    }

    @Override
    public String elementName() {
        return this.getClass().getSimpleName();
    }

    @Override
    public Fragment stereotype() {
        return (Fragment) this.mStereotype;
    }

    public BasicRootList apply ( String sqlInnerIndex ){
        this.msqlInnerIndex = sqlInnerIndex;
        return this;
    }

    public BasicRootList apply ( String sqlInnerIndex, String sqlOuterCondition ) {
        this.msqlInnerIndex     = sqlInnerIndex;
        this.msqlOuterCondition = sqlOuterCondition;
        return this;
    }

    public BasicRootList apply ( String sqlInnerIndex, String sqlInnerCondition, String sqlOuterCondition ) {
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

    public String getInfoSQLProto () {
        return  String.format(
                "SELECT tUD.*, " +
                        "       tDefs.`cn_def` AS 'cn_means', tEpitome.`w_epitome`, tAffixes.`en_fragment` " +
                        "FROM ( " +
                        " ( " +
                        "   ( " +
                        "       ( %s ) AS tUD " +
                        "       LEFT JOIN %s AS tDefs ON  tDefs.`f_clan_name` = tUD.`f_clan_name` AND BINARY tUD.`f_clan_name` = BINARY  tDefs.`f_clan_name` " +
                        "   ) LEFT JOIN %s AS tEpitome ON tEpitome.`f_clan_name` = tUD.`f_clan_name` AND BINARY tUD.`f_clan_name` = BINARY tEpitome.`f_clan_name` " +
                        " ) LEFT JOIN %s AS tAffixes ON tAffixes.`f_stub_name` = tUD.`en_root` " +
                        ")",
                this.msqlInnerIndex,
                this.master().mutual().frag().tabCDefsNS(),
                this.master().mutual().frag().tabHomologuesNS(),
                this.master().mutual().frag().tabFragsNS()
        );
    }




    public class UGWBasicSort {
        private String msqlOuterSQL  = "" ;
        private String msqlIndexSort = " ORDER BY tUD.`d_sort_id` ";

        public UGWBasicSort ( int nSortType ) {
            this.assemble( nSortType );
        }

        public UGWBasicSort ( int nSortType, String sqlDefaultIndexSort ){
            this.msqlIndexSort = sqlDefaultIndexSort;
            this.assemble( nSortType );
        }

        private void assemble ( int nSortType ){
            if( nSortType < 5 ){
                switch ( nSortType ){
                    case 0:{
                        msqlIndexSort = " ORDER BY RAND() ";
                        break;
                    }
                    case 1:{
                        msqlIndexSort = " ORDER BY tUD.`en_root` ";
                        break;
                    }
                    case 2:{
                        msqlIndexSort = " ORDER BY CHAR_LENGTH( TRIM( tUD.`en_root` ) ), tUD.`en_root`  ";
                        break;
                    }
                    case 3:{
                        msqlIndexSort  = "";
                        msqlOuterSQL  = " ORDER BY IF( tFreq.`coca_rank` IS NULL OR tFreq.`coca_rank` = 0, 99999999, tFreq.`coca_rank` ),tUD.`id`  ";
                        break;
                    }
                    case 4:{
                        msqlIndexSort = " ORDER BY tUD.`id` ";
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

    public BasicRootList.UGWBasicSort spawnUGBasicSort( int nSortType ){
        return new BasicRootList.UGWBasicSort( nSortType );
    }

    public BasicRootList.UGWBasicSort spawnUGBasicSort(int nSortType, String sqlDefaultIndexSort ){
        return new BasicRootList.UGWBasicSort( nSortType, sqlDefaultIndexSort );
    }




    private String                     mszCurrentUser ;
    private String                     mszClassId     ;
    private PredatorArchWizardum mSoul          ;

    public BasicRootList prepare ( String szCurrentUser, String szClassId, Mode mode ) {
        this.mszCurrentUser = szCurrentUser;
        this.mszClassId     = szClassId;
        this.mMode          = mode;
        return this;
    }

    private boolean isGlossaryMode() {
        return this.mMode == Mode.M_OWNED || this.mMode == Mode.M_SHARED;
    }

    private String spliceIndexSQL() {
        String szIndexSQL = "";
        if( this.isGlossaryMode() ){
            szIndexSQL =  String.format( "SELECT %%s FROM %s AS tUD WHERE tUD.`classid` = '%s' %%s",
                    this.master().user().fragment().tabRootsNS(), this.mszClassId
            );
        }

        String szBandType = this.mSoul.$_GSC().optString( "band_type" );
        if( !StringUtils.isEmpty( szBandType ) ){
            String szMainSQL = "";

            String szBandSQL = String.format (
                    "( SELECT `en_root` FROM %s AS tGWord WHERE tGWord.`g_name` = '%s' " +
                            ") AS tGWord " +
                            "WHERE tUD.`en_word` = tGWord.`m_word` ",
                    this.master().mutual().glossary().tabBookNS(), szBandType
            );

            if( this.isGlossaryMode() ){
                szMainSQL = String.format(
                        "SELECT * FROM %s AS tUD, %s AND tUD.`classid` = '%s' %%s ",
                        this.master().user().fragment().tabRootsNS(), szBandSQL, this.mszClassId
                );
            }

            szIndexSQL = "SELECT %s FROM ( " + szMainSQL + " ) AS tUD " ;
        }

        return szIndexSQL;
    }

    private void applyMode( String szIndexSQL ){
        if( this.isGlossaryMode() ){
            this.apply( String.format( szIndexSQL, "tUD.*", "%s" ) );
        }
    }

    public BasicRootList apply ( PredatorArchWizardum soul ) throws SQLException {
        this.mSoul = soul;

        String szIndexSQL = this.spliceIndexSQL();
        this.applyMode( szIndexSQL );

        String sqlIdxInnerCondition  = (this.mMode == Mode.M_OWNED ? " AND username = '" + this.mszCurrentUser + "' " : "");

        String sqlRawWordList = this.getInfoSQLProto();

        Vector<String> conditionVector = new Vector<String>();
        conditionVector.add( "en_root" );
        sqlIdxInnerCondition = filter( sqlIdxInnerCondition,conditionVector );

        int nPageLimit = this.coach().model().adjustablePaginationPreTreat( (Pagesion) soul,
                String.format( szIndexSQL, "%s", "%s" ), sqlIdxInnerCondition
        );

        String sqlOuterSQL  = "" ;
        String sqlIndexSort = " ORDER BY tUD.`d_sort_id` ";
        int nSortType = soul.$_GSC().hasOwnProperty( "sort_type" ) ? soul.$_GSC().optInt("sort_type" ) : -1;
        if( nSortType < 5 ){
            UGWBasicSort basicSort;
            basicSort  = this.spawnUGBasicSort( nSortType );
            sqlIndexSort = basicSort.getSqlIndexSort();
            sqlOuterSQL  = basicSort.getSqlOuterSQL();
        }

        sqlIdxInnerCondition += sqlIndexSort;

        soul.getPageData().put( "GlossaryRootList",this.mysql().fetch( String.format( sqlRawWordList,
                sqlIdxInnerCondition + " " + PaginateHelper.formatLimitSentence(
                        soul.getPageData().optLong( this.master().host().properties().paginate().getVarBeginNum() ), nPageLimit
                ))+" GROUP BY `en_root`" + sqlIndexSort));


        //Debug.trace( this.mysql().getLastSQLSentence() );

        return this;
    }

    public String filter (String szCondition, Vector<String> conditionVector){
        if(!conditionVector.isEmpty()) {
            for(String szKey:conditionVector ){
                if(!StringUtils.isEmpty( this.mSoul.$_GSC().optString( szKey ) )){
                    if( szCondition.isEmpty() ){
                        szCondition+=" WHERE ";
                    }
                    szCondition += String.format(" AND `%s` LIKE '%s' ",szKey,this.mSoul.$_GSC().optString( szKey ));
                }
            }
        }

        return szCondition;
    }

}