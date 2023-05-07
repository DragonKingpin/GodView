package Saurye.Elements.User.Pamphlet.Sentence;

import Pinecone.Framework.System.util.StringUtils;
import Pinecone.Framework.Util.Summer.prototype.Pagesion;
import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.Elements.EpitomeElement;
import Saurye.Elements.User.CoachShardedLayer;
import Saurye.Elements.User.Pamphlet.Glossary.Glossary;
import Saurye.Elements.User.Pamphlet.Pamphlet;
import Saurye.Peripheral.Skill.Util.PaginateHelper;
import Saurye.System.PredatorArchWizardum;

import java.sql.SQLException;

public class BasicSentenceList extends CoachShardedLayer implements EpitomeElement {
    public enum Mode {
        M_OWNED, M_SHARED, M_MEGA_ALL
    }

    private String  msqlInnerIndex        = "" ;
    private String  msqlInnerCondition    = "" ;
    private String  msqlOuterCondition    = "" ;
    private Mode mMode                    = BasicSentenceList.Mode.M_OWNED;

    public BasicSentenceList ( Pamphlet stereotype ){
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

    public BasicSentenceList apply ( String sqlInnerIndex ){
        this.msqlInnerIndex = sqlInnerIndex;
        return this;
    }

    public BasicSentenceList apply ( String sqlInnerIndex, String sqlOuterCondition ) {
        this.msqlInnerIndex     = sqlInnerIndex;
        this.msqlOuterCondition = sqlOuterCondition;
        return this;
    }

    public BasicSentenceList apply ( String sqlInnerIndex, String sqlInnerCondition, String sqlOuterCondition ) {
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

    public String getInfoSQLSentProto () {
        return "";
    }




    public class USenWBasicSort {
        private String msqlOuterSQL  = "" ;
        private String msqlIndexSort = " ORDER BY tUIdx.`d_sort_id` ";

        public USenWBasicSort ( int nSortType ) {
            this.assemble( nSortType );
        }

        public USenWBasicSort ( int nSortType, String sqlDefaultIndexSort ){
            this.msqlIndexSort = sqlDefaultIndexSort;
            this.assemble( nSortType );
        }

        private void assemble ( int nSortType ){
            if( nSortType < 5 ){
                switch ( nSortType ){
                    case 0:{
                        this.msqlIndexSort = " ORDER BY RAND() ";
                        break;
                    }
                    case 1:{
                        this.msqlIndexSort = " ORDER BY tSen.`id` ";
                        break;
                    }
                    case 2:{
                        this.msqlIndexSort = " ORDER BY tSen.`id` DESC, tSen.`" + getDateColumnName() + "` DESC";
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

    public BasicSentenceList.USenWBasicSort spawnUSenBasicSort( int nSortType ){
        return new BasicSentenceList.USenWBasicSort( nSortType );
    }

    public BasicSentenceList.USenWBasicSort spawnUSenBasicSort(int nSortType, String sqlDefaultIndexSort ){
        return new BasicSentenceList.USenWBasicSort( nSortType, sqlDefaultIndexSort );
    }




    private String                     mszCurrentUser ;
    private String                     mszClassId     ;
    private PredatorArchWizardum mSoul          ;

    public BasicSentenceList prepare ( String szCurrentUser, String szClassId, BasicSentenceList.Mode mode ) {
        this.mszCurrentUser = szCurrentUser;
        this.mszClassId     = szClassId;
        this.mMode          = mode;
        return this;
    }

    private String getDateColumnName() {
        return  "s_add_date";
    }

    private String spliceDateRange() {
        String szStartTime = this.mSoul.$_GSC().optString( "startTime" );
        String szEndTime   = this.mSoul.$_GSC().optString( "endTime"   );

        String sqlRange    = "";
        boolean bHasStart  = !StringUtils.isEmpty( szStartTime ), bHasEnd = !StringUtils.isEmpty( szEndTime );

        if( bHasStart && bHasEnd ){
            sqlRange = String.format( " AND tSen.`s_add_date` >= '%s' AND tSen.`s_add_date` <= '%s'", szStartTime, szEndTime );
        }
        else if( bHasStart ){
            sqlRange = String.format( " AND tSen.`s_add_date` >= '%s'", szStartTime );
        }
        else if( bHasEnd ){
            sqlRange = String.format( " AND tSen.`s_add_date` <= '%s'", szEndTime );
        }

        return sqlRange;
    }

    public BasicSentenceList apply ( PredatorArchWizardum soul ) throws SQLException {
        this.mSoul = soul;

        JSONObject $_SGET          = this.mSoul.$_GET( true );
        String     szLinkedWord    = $_SGET.optString( "linkedWord" );
        String     szKeyWord       = $_SGET.optString( "keyWord" );

        int nSortType = soul.$_GSC().hasOwnProperty( "sort_type" ) ? soul.$_GSC().optInt("sort_type" ) : -1;
        String sqlDateRange = this.spliceDateRange();
        String sqlIdxInnerCondition;
        String szIndexSQL ;
        String sqlSentencesRaw;
        String sqlSiftPamphlet = " TRUE ";
        if( StringUtils.isEmpty( szLinkedWord ) ) {
            if( this.mMode != BasicSentenceList.Mode.M_MEGA_ALL ){
                sqlSiftPamphlet = "tSen.`index_of` = '" + this.mszClassId + "'";
            }

            szIndexSQL = String.format( "SELECT %%s FROM %s AS tSen WHERE %s %%s",
                    this.master().user().pamphlet().sentence().tabEnSentencesNS(), sqlSiftPamphlet
            );
            this.apply( String.format( szIndexSQL, "tSen.*", "%s" ) );

            sqlIdxInnerCondition = this.mMode == BasicSentenceList.Mode.M_OWNED ? " AND tSen.username = '" + this.mszCurrentUser + "' " : "";
            sqlIdxInnerCondition += sqlDateRange ;
            sqlSentencesRaw = String.format(
                    "SELECT tSen.`id`, tSen.`mega_id`, tSen.`index_of`, tSen.`username`, tSen.`s_sentence`, tSen.`s_cn_def`, tSen.`s_add_date`, " +
                            "tWord.`en_word`, tWord.`s_sent_id` FROM " +
                            "( " +
                            "   ( %s ) AS tSen " +
                            "   LEFT JOIN %s AS tWord ON tWord.`s_sent_id` = tSen.`mega_id` " +
                            ") ",
                    this.msqlInnerIndex,
                    this.master().user().pamphlet().sentence().tabEnSentWordsNS()
            );
        }
        else {
            if( this.mMode != BasicSentenceList.Mode.M_MEGA_ALL ){
                sqlSiftPamphlet = "tWord.`ph_id` = '" + this.mszClassId + "'";
            }

            szIndexSQL = String.format( "SELECT %%s FROM %s AS tWord WHERE %s %%s",
                    this.master().user().pamphlet().sentence().tabEnSentWordsNS(), sqlSiftPamphlet
            );
            this.apply( String.format( szIndexSQL, "tWord.*", "%s" ) );

            sqlIdxInnerCondition = this.mMode == BasicSentenceList.Mode.M_OWNED ? " AND tWord.username = '" + this.mszCurrentUser + "' " : "";
            sqlIdxInnerCondition += " AND tWord.`en_word` LIKE '" + szLinkedWord + "' ";

            sqlSentencesRaw = String.format(
                    "SELECT tSen.`id`, tSen.`mega_id`, tSen.`index_of`, tSen.`username`, tSen.`s_sentence`, tSen.`s_cn_def`, tSen.`s_add_date`, " +
                            "tWord.`en_word`, tWord.`s_sent_id` FROM " +
                            "( " +
                            "   ( %s ) AS tWord " +
                            "   LEFT JOIN %s AS tSen ON tWord.`s_sent_id` = tSen.`mega_id` " + sqlDateRange +
                            ") ",
                    this.msqlInnerIndex,
                    this.master().user().pamphlet().sentence().tabEnSentencesNS()
            );
        }

        if( !StringUtils.isEmpty( szKeyWord ) ) {
            sqlIdxInnerCondition += " AND tSen.`s_sentence` LIKE '%" + szKeyWord + "%' ";
        }


        int nPageLimit = this.coach().model().adjustablePaginationPreTreat( (Pagesion) soul,
                String.format( szIndexSQL, "%s", "%s" ), sqlIdxInnerCondition
        );



        String sqlIndexSort = " ORDER BY tSen.`s_sort_id` ";
        if( nSortType >= 0 ){
            USenWBasicSort basicSort = this.spawnUSenBasicSort( nSortType );

            if( StringUtils.isEmpty( szLinkedWord ) ) {
                sqlIndexSort = basicSort.getSqlIndexSort();
                sqlIdxInnerCondition += sqlIndexSort;
            }
            else {
                sqlSentencesRaw += sqlIndexSort;
            }
        }


        soul.getPageData().put( "SentenceList",this.mysql().fetch( String.format(
                sqlSentencesRaw,
                sqlIdxInnerCondition + " " + PaginateHelper.formatLimitSentence(
                        soul.getPageData().optLong( this.master().host().properties().paginate().getVarBeginNum() ), nPageLimit
                )
        )) );


        //Debug.trace( this.mysql().getLastSQLSentence() );

        return this;
    }

}