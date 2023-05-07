package Saurye.Elements.Mutual.Word;

import Pinecone.Framework.Util.JSON.JSONArray;
import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.Elements.StereotypicalElement;
import Saurye.Elements.Mutual.MutualAlchemist;
import Saurye.Elements.Mutual.OwnedElement;

import java.sql.SQLException;

public class Word extends OwnedElement implements StereotypicalElement {
    protected String mTabWord                  = "";
    protected String mTabFrequency             = "";
    protected String mTabFreqRank              = "";
    protected String mTabBandFreq              = "";
    protected String mTabInflections           = "";
    protected String mTabSemanticAssoc         = "";
    protected String mTabFrequencyYear         = "";
    protected String mTabFQYearConsult         = "";
    protected String mTabIsomers               = "";
    protected String mTabFIsomers              = "";
    protected String mTabMutants               = "";
    protected String mTabAllotropys            = "";
    protected String mTabFAllotropys           = "";
    protected String mTabMarkovTrans1_1G       = "";
    protected String mTabMarkovTrans1G         = "";
    protected String mTabWeightEtymFrag        = "";
    protected String mTabWeightProfForm        = "";
    protected String mTabWeightDynamic         = "";
    protected String mTabWeightUnionBase       = "";
    protected String mTabUSAGradeLevel         = "";

    public Word ( MutualAlchemist alchemist ){
        super( alchemist );
        this.tableJavaify( this, this.mTableProto );
    }

    @Override
    public String elementName() {
        return this.getClass().getSimpleName();
    }

    public String tabWord              (){
        return this.mTabWord;
    }
    public String tabFrequency         (){
        return this.mTabFrequency ;
    }
    public String tabFreqRank          (){
        return this.mTabFreqRank ;
    }
    public String tabBandFreq          (){
        return this.mTabBandFreq ;
    }
    public String tabInflections       (){
        return this.mTabInflections ;
    }
    public String tabSemanticAssoc     (){
        return this.mTabSemanticAssoc ;
    }
    public String tabFrequencyYear     (){
        return this.mTabFrequencyYear ;
    }
    public String tabFQYearConsult     (){
        return this.mTabFQYearConsult ;
    }
    public String tabIsomers           (){
        return this.mTabIsomers ;
    }
    public String tabFIsomers          (){
        return this.mTabFIsomers ;
    }
    public String tabMutants           (){
        return this.mTabMutants ;
    }
    public String tabAllotropys        (){
        return this.mTabAllotropys ;
    }
    public String tabFAllotropys       (){
        return this.mTabFAllotropys ;
    }
    public String tabMarkovTrans1_1G   (){
        return this.mTabMarkovTrans1_1G ;
    }
    public String tabMarkovTrans1G     (){
        return this.mTabMarkovTrans1G;
    }
    public String tabWeightEtymFrag    (){
        return this.mTabWeightEtymFrag ;
    }
    public String tabWeightProfForm    (){
        return this.mTabWeightProfForm ;
    }
    public String tabWeightDynamic     (){
        return this.mTabWeightDynamic;
    }
    public String tabWeightUnionBase   (){
        return this.mTabWeightUnionBase;
    }
    public String tabUSAGradeLevel     (){
        return this.mTabUSAGradeLevel;
    }


    public String tabWordNS            (){
        return this.tableName( this.mTabWord );
    }
    public String tabFrequencyNS       (){
        return this.tableName( this.mTabFrequency );
    }
    public String tabFreqRankNS        (){
        return this.tableName( this.mTabFreqRank );
    }
    public String tabBandFreqNS        (){
        return this.tableName( this.mTabBandFreq );
    }
    public String tabInflectionsNS     (){
        return this.tableName( this.mTabInflections );
    }
    public String tabSemanticAssocNS   (){
        return this.tableName( this.mTabSemanticAssoc );
    }
    public String tabFrequencyYearNS   (){
        return this.tableName( this.mTabFrequencyYear );
    }
    public String tabFQYearConsultNS   (){
        return this.tableName( this.mTabFQYearConsult );
    }
    public String tabIsomersNS         (){
        return this.tableName( this.mTabIsomers );
    }
    public String tabFIsomersNS        (){
        return this.tableName( this.mTabFIsomers );
    }
    public String tabMutantsNS         (){
        return this.tableName( this.mTabMutants );
    }
    public String tabAllotropysNS      (){
        return this.tableName( this.mTabAllotropys );
    }
    public String tabFAllotropysNS     (){
        return this.tableName( this.mTabFAllotropys );
    }
    public String tabMarkovTrans1_1GNS (){
        return this.tableName( this.mTabMarkovTrans1_1G );
    }
    public String tabMarkovTrans1GNS   (){
        return this.tableName( this.mTabMarkovTrans1G );
    }
    public String tabWeightEtymFragNS  (){
        return this.tableName( this.mTabWeightEtymFrag );
    }
    public String tabWeightProfFormNS  (){
        return this.tableName( this.mTabWeightProfForm );
    }
    public String tabWeightDynamicNS   (){
        return this.tableName( this.mTabWeightDynamic );
    }
    public String tabWeightUnionBaseNS (){
        return this.tableName( this.mTabWeightUnionBase );
    }
    public String tabUSAGradeLevelNS   (){
        return this.tableName( this.mTabUSAGradeLevel );
    }





    public JSONArray fetchBasicInfo ( String szWord ) throws SQLException {
        return this.mysql().fetch(
                String.format(  "SELECT tMutual.*, tBand.`w_level_cache` AS `w_level` FROM ( " +
                                "  ( " +
                                "    ( SELECT * FROM %s AS tMutual WHERE tMutual.`en_word` = '%s' ) AS tMutual " +
                                "    LEFT JOIN %s AS tBand ON tMutual.`en_word` = tBand.`en_word` AND BINARY tMutual.`en_word` = BINARY tBand.`en_word`  " +
                                "  )" +
                                ")",
                        this.tabWordNS(), szWord,
                        this.mAlchemist.getMaster().mutual().glossary().tabBandNS()
                )
        );
    }

    public JSONArray fetchBandList  ( String szWord ) throws SQLException {
        JSONArray jBandRaw = this.mysql().fetch(
                String.format(  "SELECT tBand.`w_level_cache` AS `w_level` FROM %s AS tBand WHERE tBand.`en_word` = '%s' ",
                        this.mAlchemist.getMaster().mutual().glossary().tabBandNS(),
                        szWord
                )
        );
        JSONArray jBand;
        if( !jBandRaw.isEmpty() ){
            String szJsonBand = jBandRaw.optJSONObject(0).optString( "w_level" );
            jBand = new JSONArray( szJsonBand );
        }
        else {
            jBand = new JSONArray();
        }
        return jBand;
    }

    public JSONArray fetchBaseFreq  ( String szWord ) throws SQLException {
       return this.mysql().fetch(
                String.format( "SELECT " +
                                "tFreq.`w_pos`, tFreq.`f_total`, tFreq.`f_spoken`, tFreq.`f_fiction`,tFreq.`f_magazine`, tFreq.`f_newspaper`," +
                                "tFreq.`f_academic`, tFreq.`coca_rank`, tFreq.`f_band_level`, tFreq.`band_rank` " +
                                "FROM %s AS tFreq WHERE tFreq.`en_word` = '%s' ORDER BY tFreq.`f_total` DESC",
                        this.tabFrequencyNS(), szWord
                )
        );
    }

    public JSONArray fetchBaseFreqSum  ( String szWord ) throws SQLException {
        return this.mysql().fetch(
                String.format( "SELECT " +
                                "SUM( tFreq.`f_total` ) AS `total`,  SUM( tFreq.`f_spoken` ) AS `spoken`, SUM( tFreq.`f_fiction` ) AS `fiction`," +
                                "SUM( tFreq.`f_magazine` ) AS `magazine`, SUM( tFreq.`f_newspaper` ) AS `newspaper`," +
                                "SUM( tFreq.`f_academic` ) AS `academic`, MIN( tFreq.`coca_rank` )   AS `coca_rank`, " +
                                "MAX( tFreq.`f_band_level` ) AS `band_level`, MAX( tFreq.`band_rank` ) AS `band_rank` " +
                                "FROM %s AS tFreq WHERE tFreq.`en_word` = '%s'",
                        this.tabFrequencyNS(), szWord
                )
        );
    }

    public JSONArray fetchUnionFreqRank  ( String szWord ) throws SQLException {
        return this.mysql().fetch(
                String.format( "SELECT " +
                                "tUnion.`en_word`, tUnion.`w_freq_base` " +
                                "FROM %s AS tUnion WHERE tUnion.`en_word` = '%s'",
                        this.tabWeightUnionBaseNS(), szWord
                )
        );
    }

    public JSONArray fetchBaseFreqRankSum  ( String szWord ) throws SQLException {
        return this.mysql().fetch(
                String.format( "SELECT " +
                                "MIN( tFreq.`r_total` ) AS `total`,  MIN( tFreq.`r_spoken` ) AS `spoken`, MIN( tFreq.`r_fiction` ) AS `fiction`," +
                                "MIN( tFreq.`r_magazine` ) AS `magazine`, MIN( tFreq.`r_newspaper` ) AS `newspaper`," +
                                "MIN( tFreq.`r_academic` ) AS `academic` " +
                                "FROM %s AS tFreq WHERE tFreq.`en_word` = '%s' ORDER BY tFreq.`en_word`",
                        this.tabFreqRankNS(), szWord
                )
        );
    }

    public JSONArray fetchBandFreq  ( String szWord ) throws SQLException {
        return this.mysql().fetch(
                String.format("SELECT " +
                                "tFreq.`en_word`, tFreq.`e_type`, tFreq.`e_frequency`, tFreq.`f_rank` " +
                                "FROM %s AS tFreq WHERE tFreq.`en_word` = '%s'",
                        this.tabBandFreqNS(), szWord
                )
        );
    }

    public boolean hasSuchWord ( String szWord ) throws SQLException {
        return this.mysql().countFromTable(  String.format ( "SELECT COUNT(*) FROM %S WHERE en_word = '%s'  ",
                this.tabWordNS(), szWord )
        ) > 0;
    }

    public JSONObject fetchIsomerInfo( String szWord ) throws SQLException {
        JSONArray isomers = this.mysql().fetch( String.format(
                "SELECT tIso.`en_word`, tIso.`en_isomer`, tDict.`m_property`, tDict.`cn_means` FROM " +
                        "(" +
                        "  SELECT tIso.`en_word`, tIso.`en_isomer` FROM %s AS tIso WHERE tIso.`en_word` = '%s'" +
                        ") AS tIso LEFT JOIN %s AS tDict ON tDict.`en_word` = tIso.`en_isomer` ",
                this.tabIsomersNS(), szWord, this.owned().dict().tabEn2CnNS()
        ) );

        JSONObject eachMeans = new JSONObject();

        for ( int i = 0; i < isomers.length(); i++ ) {
            JSONObject row = isomers.optJSONObject( i );

            if( !eachMeans.hasOwnProperty( row.optString( "en_isomer" ) ) ){
                eachMeans.put( row.optString( "en_isomer" ), new JSONObject() );
            }

            eachMeans.getJSONObject( row.optString( "en_isomer" ) ).put( row.optString("m_property"), row );
        }

        return eachMeans;
    }

    public JSONArray  fetchMutants( String szWord, String szExp, String szType ) throws SQLException {
        return this.mysql().fetch( String.format(
                "SELECT tMut.`en_word`, tMut.`en_mutant`,tMut.`mut_exponent`, tMut.`mut_type`  FROM %s AS tMut WHERE " +
                        "tMut.`en_word` = '%s' AND tMut.`mut_exponent` = '%s' AND tMut.`mut_type` = '%s'",
                this.tabMutantsNS(), szWord, szExp, szType
        ) );
    }

    public JSONArray  fetchMutants( String szWord ) throws SQLException {
        return this.mysql().fetch( String.format(
                "SELECT tMut.`en_word`, tMut.`en_mutant`,tMut.`mut_exponent`, tMut.`mut_type`  FROM %s AS tMut WHERE " +
                        "tMut.`en_word` = '%s'",
                this.tabMutantsNS(), szWord
        ) );
    }


    private HistoryTeller  mHistoryTeller;

    public HistoryTeller   historyTeller          () {
        if( this.mHistoryTeller == null ){
            this.mHistoryTeller = new HistoryTeller( this );
        }
        return this.mHistoryTeller;
    }

    public WordNexusTree   wordNexusTree          () {
        return new WordNexusTree( this );
    }

    public WordSynonymTree wordSynonymTree        () { return new WordSynonymTree( this ); }

    public WordWeightTree  wordWeightTree         () { return new WordWeightTree( this ); }

}
