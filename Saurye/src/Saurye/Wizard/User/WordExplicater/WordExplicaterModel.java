package Saurye.Wizard.User.WordExplicater;

import Pinecone.Framework.Debug.Debug;
import Pinecone.Framework.System.Functions.*;
import Pinecone.Framework.System.util.StringTraits;
import Pinecone.Framework.System.util.StringUtils;
import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.http.HttpURLParser;
import Pinecone.Framework.Util.Summer.prototype.Pagesion;
import Pinecone.Framework.Util.Summer.prototype.ModelEnchanter;
import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.Elements.Mutual.Word.HistoryTellerCrystals.LSMEvaluator;
import Saurye.Peripheral.Skill.Util.AlgHelper;
import Saurye.System.Prototype.JasperModifier;

import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.TreeMap;
import java.util.regex.Pattern;

@JasperModifier
public class WordExplicaterModel extends WordExplicater implements Pagesion {
    public WordExplicaterModel( ArchConnection connection ){
        super(connection);
    }

    protected String mszEnWord;

    @Override
    public void beforeGenieInvoke() throws IOException {
        this.mszEnWord                = this.$_GSC().optString( "query" );
        if( StringUtils.isEmpty( this.mszEnWord ) ){
            this.redirect( this.spawnActionQuerySpell() + "&query=undefined" );
            this.stop();
        }
        boolean bIsCnLike = Pattern.compile( "[\\u4E00-\\u9FA5]+" ).matcher( this.mszEnWord ).find();
        boolean bIsPhrase = Pattern.compile( "[a-zA-Z0-9]\\s[a-zA-Z0-9]" ).matcher( this.mszEnWord ).find();
        boolean bIsFuzzy  = this.mszEnWord.indexOf( '%' ) >= 0;
        if( bIsCnLike || bIsFuzzy ) {
            this.redirect( this.querySpell().geniusExplorerSpell( null ) + "&kw=" + HttpURLParser.encode( this.mszEnWord, this.system().getServerCharset() ) );
            this.stop();
        }
        if( bIsPhrase ) {
            this.redirect( this.querySpell().geniusTranslatorSpell() + "&query=" + HttpURLParser.encode( this.mszEnWord, this.system().getServerCharset() ) );
            this.stop();
        }
    }

    @Override
    public void defaultGenie() throws Exception {
        super.defaultGenie();
        this.wordProfile();
    }

    public void wordProfile() throws SQLException {
        JSONObject hWordExplication = new JSONObject();

        hWordExplication.put (
                "basicInfo", this.alchemist().mutual().word().fetchBasicInfo( this.mszEnWord )
        );

        hWordExplication.put (
                "gradeLevel", this.mysql().fetch(
                        String.format( "SELECT tL.`w_level` FROM %s AS tL WHERE tL.`en_word` = '%s'",
                                this.alchemist().mutual().word().tabUSAGradeLevelNS(), this.mszEnWord
                        )
                )
        );

        hWordExplication.put (
                "cnDefs", this.alchemist().mutual().dict().dictEn2Cn().fetchCnDefine( this.mszEnWord )
        );

        hWordExplication.put (
                "cnDictDefs", this.alchemist().mutual().dict().dictEn2Cn().fetchCnIndexDef( this.mszEnWord )
        );

        hWordExplication.put (
                "frequency", this.alchemist().mutual().word().fetchBaseFreq( this.mszEnWord )
        );

        hWordExplication.put (
                "global_union_frequency", this.alchemist().mutual().word().fetchUnionFreqRank( this.mszEnWord )
        );

        hWordExplication.put (
                "band_frequency", this.alchemist().mutual().word().fetchBandFreq( this.mszEnWord )
        );

        hWordExplication.put (
                "enDefs", this.mysql().fetch(
                        String.format("SELECT tEnD.`d_property`, tEnD.`w_definition`, tEnD.`classid` FROM %s AS tEnD WHERE tEnD.`en_word` = '%s'",
                                this.alchemist().mutual().dict().tabEn2EnNS(),this.mszEnWord
                        )
                )
        );

        hWordExplication.put (
                "enDefsEgSentences", this.mysql().fetch(
                        String.format("SELECT  tEnD.`classid`, tSent.`d_sentence`  FROM " +
                                        "( ( SELECT tEnD.`classid` FROM %s AS tEnD WHERE tEnD.`en_word` = '%s' ) AS tEnD LEFT JOIN " +
                                        " %s AS tSent ON tEnD.`classid` = tSent.`indexof`)",
                                this.alchemist().mutual().dict().tabEn2EnNS(),this.mszEnWord,
                                this.alchemist().mutual().sentence().tabEnDefEgNS()
                        )
                )
        );

        hWordExplication.put (
                "tradeDict", this.mysql().fetch(
                        String.format("SELECT  tProD.`w_field`, tProD.`w_property`,tProD.`cn_means`, tField.`cn_field` FROM " +
                                        "( ( SELECT tProD.`w_field`, tProD.`w_property`,tProD.`cn_means` FROM %s AS tProD WHERE tProD.`en_word` = '%s' ) AS tProD LEFT JOIN " +
                                        " %s AS tField ON tProD.`w_field` = tField.`en_field`)",
                                this.alchemist().mutual().dict().tabProEn2CnNS(),this.mszEnWord,
                                this.alchemist().mutual().dict().tabProFieldNS()
                        )
                )
        );

        this.mPageData.put( "WordExplication", hWordExplication );
    }

    @ModelEnchanter
    public void getPhrasesList() throws SQLException  {
        this.getPhrasesList( null );
    }

    public void getPhrasesList( JSONObject hWordExplication ) throws SQLException {
        String szFetchAllSQL = " AND ( tPhr.`ph_type` = 'phrasalVerbs' OR tPhr.`ph_type` = 'general' )";

        if( hWordExplication == null ){
            hWordExplication = new JSONObject();
            szFetchAllSQL    = "";
        }

        hWordExplication.put (
                "phrasesList", this.alchemist().mutual().phrase().fetchDefAndEgSentencesByWord( this.mszEnWord, szFetchAllSQL )
        );

        if( szFetchAllSQL.isEmpty() ){
            this.mPageData.put( "WordExplication", hWordExplication );
        }
    }

    private void conjugatedWordsBasic() throws SQLException {

        JSONObject hWordExplication = new JSONObject();

        hWordExplication.put (
                "inflections", this.mysql().fetch(
                        String.format("SELECT  tInf.`w_inflection`, tInf.`i_type`  FROM %s AS tInf WHERE tInf.`w_prototype` = '%s' AND tInf.`i_type` != 'Self'",
                                this.alchemist().mutual().word().tabInflectionsNS(),this.mszEnWord
                        )
                )
        );

        hWordExplication.put (
                "w_s_assoc", this.mysql().fetch(
                        String.format( "SELECT %s FROM %s AS tAssoc WHERE tAssoc.`en_word` = '%s' AND ( `s_association` = 'Synonym' OR `s_association` = 'Antonym' )",
                                StringUtils.sequencify( new String[]{ "`en_word`","`en_pair`","`s_association`","`s_property`","`cn_annotate`","`en_annotate`" } , ",", "tAssoc." ),
                                this.alchemist().mutual().word().tabSemanticAssocNS()
                                ,this.mszEnWord
                        )
                )
        );

        hWordExplication.put (
                "synonAnalysis", this.mysql().fetch(
                        String.format( "SELECT tDisc.`en_clan_name`, tDisc.`c_basic_def`, tDisc.`w_epitome`, tDisc.`detail_def`, tCnD.`m_property`, tCnD.`cn_means`  FROM " +
                                        "( " +
                                        "  ( SELECT tClans.`en_clan_name`, tClans.`c_basic_def`, tDefs.`w_epitome`, tDefs.`detail_def` FROM " +
                                        "      ( " +
                                        "         ( SELECT tArch.`classid` FROM %s AS tArch WHERE tArch.`w_epitome` = '%s' ) AS tArch " +
                                        "         LEFT JOIN %s AS tClans ON tClans.`classid` = tArch.`classid`" +
                                        "      ) LEFT JOIN %s AS tDefs ON tClans.`classid` = tDefs.`classid`" +
                                        "  ) AS tDisc LEFT JOIN %s AS tCnD ON tCnD.`en_word` = tDisc.`w_epitome`  "+
                                        ") " +
                                        "GROUP BY tDisc.`w_epitome` ",
                                this.alchemist().mutual().extend().tabSynDiscrEpitomesNS(),
                                this.mszEnWord,
                                this.alchemist().mutual().extend().tabSynDiscrClansNS(),
                                this.alchemist().mutual().extend().tabSynDiscrClanDefsNS(),
                                this.alchemist().mutual().dict().tabEn2CnNS()
                        )
                )
        );

        this.getPhrasesList( hWordExplication );
        this.mPageData.put( "WordExplication", hWordExplication );
    }

    private void conjugatedWordsPloy() throws SQLException {
        JSONObject hWordExplication = new JSONObject();

        Map<Character,Integer > moleculeMap = new TreeMap<>();
        String szUpperWord                  = this.mszEnWord.toUpperCase();
        AlgHelper.moleculify( szUpperWord.toCharArray(), moleculeMap );


        hWordExplication.put (
                "en_isomers", this.mysql().fetch( String.format(
                        "SELECT tIso.`m_formula`, tIso.`en_isomer` FROM %s AS tIso WHERE tIso.`m_formula` = '%s'",
                        this.alchemist().mutual().word().tabFIsomersNS(), AlgHelper.toAtomSeries( moleculeMap )
                ) )
        );

        hWordExplication.put (
                "en_allotropys", this.mysql().fetch( String.format(
                        "SELECT tAllo.`m_formula`, tAllo.`en_allotropy` FROM %s AS tAllo WHERE tAllo.`m_formula` = '%s'",
                        this.alchemist().mutual().word().tabFAllotropysNS(), AlgHelper.toAtomSequence( moleculeMap )
                ) )
        );

        hWordExplication.put (
                "en_serial_mutants", this.mysql().fetch( String.format(
                        "SELECT tMut.`en_word`, tMut.`en_mutant`,tMut.`mut_exponent`, tMut.`mut_type`  FROM %s AS tMut WHERE " +
                                "tMut.`en_word` = '%s' AND ( tMut.`mut_type` = 'SerialPointReplace' || tMut.`mut_type` = 'SerialPointInsert' )",
                        this.alchemist().mutual().word().tabMutantsNS(), this.mszEnWord
                ) )
        );

        hWordExplication.put (
                "en_heter_mutants", this.mysql().fetch( String.format(
                        "SELECT tMut.`en_word`, tMut.`en_mutant`,tMut.`mut_exponent`, tMut.`mut_type`  FROM %s AS tMut WHERE " +
                                "tMut.`en_word` = '%s' AND ( tMut.`mut_type` = 'HeterPointReplace' || tMut.`mut_type` = 'HeterPointInsert' )",
                        this.alchemist().mutual().word().tabMutantsNS(), this.mszEnWord
                ) )
        );


        JSONObject jBasicFormTrait          = new JSONObject();
        jBasicFormTrait.put( "wordSet"          , moleculeMap.keySet() );
        jBasicFormTrait.put( "wordSetSize"      , moleculeMap.size() );
        jBasicFormTrait.put( "molecularFormula" , AlgHelper.molecularFormulaify( moleculeMap ) );

        String szMirrorTrait = "普通";
        if( StringTraits.isChiralString( szUpperWord, false ) ){ // Has already toUpper.
            szMirrorTrait     = "手性/回文";
        }
        else if( StringTraits.isHomoString( szUpperWord, false ) ){
            szMirrorTrait     = "同型/逆手性";
        }
        else if( StringTraits.isHeterString( szUpperWord, false ) ){
            szMirrorTrait     = "异构";
        }
        jBasicFormTrait.put( "mirrorTrait" , szMirrorTrait );

        hWordExplication.put ( "basic_form_trait", jBasicFormTrait );

        this.mPageData.put( "WordExplication", hWordExplication );
    }

    public void conjugatedWords() throws SQLException {
        String szNodeName = this.$_GSC().optString( "cwNode" );
        szNodeName = StringUtils.isEmpty( szNodeName ) ? "cw_basic" : szNodeName;
        WordExplicaterModel self = this;

        try {
            ( new ChosenDispatcher(new HashMap<String, Executable>(){
                {
                    put( "cw_basic",   (Executor)()->{
                        self.conjugatedWordsBasic();
                    } );
                    put( "cw_poly", (Executor)()->{
                        self.conjugatedWordsPloy();
                    } );
                }
            } )).dispatch( szNodeName );
        }
        catch ( SQLException e ){
            throw e;
        }
        catch ( Exception e1 ){
            Debug.cerr( "Notice: " + e1.getMessage() );
        }
    }

    @ModelEnchanter
    public void getHistoryRate() throws SQLException {
        this.mPageData.put (
                "historyRate", this.alchemist().mutual().word().historyTeller().apply(
                        this.mszEnWord, 1800
                ).getHistoryRate( 100 )
        );
    }

    public void etymologyRoots() throws SQLException {
        JSONObject hWordExplication = new JSONObject();

        hWordExplication.put (
                "relevantSimple", this.alchemist().mutual().etym().fetchRelevantBasic( this.mszEnWord )
        );

        hWordExplication.put (
                "etymologyDefs", this.mysql().fetch(
                        String.format(  " SELECT tDef.`com_def`, tCnP.`def_id` AS `cn_did`, tCnP.`m_property` AS `cn_pos`, tCnP.`property_attach`, tEnP.`def_id`, tEnP.`m_property` AS `en_pos`, tEnP.`property_attach` FROM " +
                                        " ( " +
                                        "   ( SELECT * FROM %s AS tDef WHERE tDef.`en_word` = '%s' ) AS tDef" +
                                        "   LEFT JOIN %s AS tCnP ON tCnP.`def_id` = tDef.`def_id` " +
                                        " ) LEFT JOIN %s AS tEnP ON tEnP.`def_id` = tDef.`def_id` ",
                                this.alchemist().mutual().etym().tabDefsNS(),this.mszEnWord,
                                this.alchemist().mutual().etym().tabCnPoSNS(), this.alchemist().mutual().etym().tabEnPoSNS()
                        )
                )
        );


        String szTabEpitomes = this.alchemist().mutual().frag().tabHomologuesNS();
        hWordExplication.put(
                "fragmentInfos", this.mysql().fetch(
                        String.format(  "SELECT tArchS.`w_epitome`, tArchS.`cn_infer`, tArchS.`c_def_id`," +
                                        "       tArch.`c_form_kin`, tArch.`cn_def`, tArch.`f_clan_name`, " +
                                        "       tArch.`en_fragment`, tArch.`ety_relevant`, tArch.`f_rank`, tArch.`cn_rank_def`," +
                                        "       tCnDict.`m_property`, tCnDict.`cn_means`" +
                                        "FROM " +
                                        "    (" +
                                        "      ( " +
                                        "       SELECT  tArch.`w_epitome`, tArch.`cn_infer`, tArch.`c_def_id`," +
                                        "               tClan.`c_form_kin`, tCDef.`cn_def`, tCDef.`f_clan_name`, tCDef.`f_def_id`, tCDef.`id` AS `cd_id`," +
                                        "               tFrags.`en_fragment`, tCEtyD.`ety_relevant`, tBand.`f_rank`, tBand.`cn_rank_def` " +
                                        "       FROM " +
                                        "           (" +
                                        "            (" +
                                        "             (" +
                                        "              (" +
                                        "                (" +
                                        "                  ( " +
                                        "                    ( SELECT * FROM %s AS tArch WHERE tArch.`w_epitome` = '%s' ) AS tArch " +
                                        "                    LEFT JOIN %s AS tCDef ON tCDef.`f_clan_name` = tArch.`f_clan_name`" +
                                        "                  ) LEFT JOIN %s AS tClan ON tClan.`en_clan_name` = tArch.`f_clan_name` " +
                                        "                ) LEFT JOIN %s AS tFrags ON tFrags.`f_clan_name` = tArch.`f_clan_name` " +
                                        "              ) LEFT JOIN %s AS tFEtyD ON tFEtyD.`en_fragment` = tFrags.`f_stub_name`" +
                                        "             ) LEFT JOIN %s AS tCEtyD ON tCEtyD.`en_clan_name` = tFEtyD.`f_clan_name`" +
                                        "            ) LEFT JOIN %s AS tBand ON tBand.`f_stub_name` = tFrags.`f_stub_name`" +
                                        "           )  GROUP BY tCDef.`f_def_id`" +
                                        "      ) AS tArch LEFT JOIN %s AS tArchS ON tArchS.`c_def_id` = tArch.`f_def_id`" +
                                        "    ) LEFT JOIN ( " +
                                        "                  SELECT tCnDict.* FROM " +
                                        "                  ( " +
                                        "                     ( ( SELECT * FROM %s AS tArch WHERE tArch.`w_epitome` = '%s' ) AS tArch" +
                                        "                        LEFT JOIN %s AS tAS ON tArch.`f_clan_name` = tAS.`f_clan_name` " +
                                        "                     ) LEFT JOIN %s AS tCnDict ON tCnDict.`en_word` = tAS.`w_epitome`  " +
                                        "                  ) GROUP BY tCnDict.`en_word`" +
                                        " ) AS tCnDict ON tCnDict.`en_word` = tArchS.`w_epitome` ORDER BY tArch.`cd_id` ",
                                szTabEpitomes,this.mszEnWord,

                                this.alchemist().mutual().frag().tabCDefsNS(),
                                this.alchemist().mutual().frag().tabClansNS(),
                                this.alchemist().mutual().frag().tabFragsNS(),
                                this.alchemist().mutual().etym().tabFFragNS(),
                                this.alchemist().mutual().etym().tabFClansNS(),
                                this.alchemist().mutual().frag().tabBandNS(),
                                szTabEpitomes,

                                szTabEpitomes,this.mszEnWord, szTabEpitomes,
                                this.alchemist().mutual().dict().tabEn2CnNS()
                        )
                )
        );

        this.mPageData.put( "WordExplication", hWordExplication );
    }

    public void exampleSentence() throws SQLException {
        JSONObject hWordExplication = new JSONObject();

        hWordExplication.put (
                "generalEgSentences", this.mysql().fetch(
                        String.format("SELECT  tEg.`en_sentence`, tEg.`cn_mean`, tEg.`e_from`, tEg.`e_type` FROM %s AS tEg WHERE tEg.`en_word` = '%s'",
                                this.alchemist().mutual().sentence().tabWordEnEgNS(),this.mszEnWord
                        )
                )
        );

        hWordExplication.put (
                "bandEgSentences", this.mysql().fetch(
                        String.format("SELECT  tEg.`en_sentence`, tEg.`cn_mean`, tEg.`e_from`, tEg.`e_from`, tEg.`e_type` FROM %s AS tEg WHERE tEg.`en_word` = '%s'",
                                this.alchemist().mutual().sentence().tabEnBandNS(),this.mszEnWord
                        )
                )
        );

        this.mPageData.put( "WordExplication", hWordExplication );
    }

    public void advanceDefine() throws SQLException {
        JSONObject hWordExplication = new JSONObject();

        hWordExplication.put (
                "slangDefs", this.alchemist().mutual().slang().fetchSlangDefs( this.mszEnWord )
        );

        hWordExplication.put (
                "slangDefEgSentences", this.alchemist().mutual().slang().fetchSlangDefEgSentences( this.mszEnWord )
        );

        this.mPageData.put( "WordExplication", hWordExplication );
    }

    @ModelEnchanter
    public void getWordNexusTree() throws SQLException {
        this.mPageData.put (
                "weightNexusTree", this.alchemist().mutual().word().wordNexusTree().apply(
                        this.mszEnWord
                ).eval()
        );
    }

    @ModelEnchanter
    public void getWordSynonymTree() throws SQLException {
        this.mPageData.put (
                "synonymTree", this.alchemist().mutual().word().wordSynonymTree().apply(
                        this.mszEnWord
                ).eval()
        );
    }

    @ModelEnchanter
    public void getWordMarkovChain1g() throws SQLException {
        int   nLimit   = this.$_GSC().optInt( "limit" );
        String szPoS   = this.$_GSC().optString( "pos" );
        String szWhere = "";
        if( !StringUtils.isEmpty( szPoS ) ){
            szWhere = " AND tM1g.`mk_pos` = '" + szPoS + "'";
        }

        this.mPageData.put( "nextWords", mysql().fetch( String.format(
                "SELECT tM1g.`en_word`, tM1g.`mk_pos`, tM1g.`next_word` FROM %s AS tM1g " +
                        "WHERE tM1g.`en_word` = '%s' %s ORDER BY tM1g.`next_count` DESC LIMIT %s ",
                alchemist().mutual().word().tabMarkovTrans1GNS(), this.mszEnWord, szWhere,  nLimit
        ) ) );
        this.mPageData.put( "frontWords", mysql().fetch( String.format(
                "SELECT tM1g.`en_word`, tM1g.`mk_pos`, tM1g.`next_word` FROM %s AS tM1g " +
                        "WHERE tM1g.`next_word` = '%s' %s ORDER BY tM1g.`next_count` DESC LIMIT %s ",
                alchemist().mutual().word().tabMarkovTrans1GNS(), this.mszEnWord, szWhere,  nLimit
        ) ) );
    }

    public void magicReport() throws SQLException {
        String szNodeName = this.$_GSC().optString( "mrNode" );
        szNodeName = StringUtils.isEmpty( szNodeName ) ? "mr_weight" : szNodeName;

        try {
            ( new ChosenDispatcher(new HashMap<String, Executable>(){
                {
                    put( "mr_weight",   (Executor)()->{
                        mPageData.put( "UserFocus", currentUser().user().getUserFocus() );
                        mPageData.put( "wordBasicWeight", mysql().fetch( String.format(
                                "SELECT `w_over_base` FROM %s WHERE `en_word` = '%s'",
                                alchemist().mutual().word().tabWeightUnionBaseNS(), mszEnWord
                        ) ) );

                        int nFirstYear = 1949;
                        LSMEvaluator lsmEvaluator9x = alchemist().mutual().word().historyTeller().apply(
                                mszEnWord, nFirstYear - 1 ).lsmEvaluator(100,9
                        );
                        mPageData.put( "historyEvaluatorLinePara9x", lsmEvaluator9x.eval_parameters(0).getArray() );
                        mPageData.put( "historyEvaluatorLineDeri9x", lsmEvaluator9x.eval_parameter_derivative(0).getArray() );

                        LSMEvaluator lsmEvaluator6x = alchemist().mutual().word().historyTeller().apply(
                                mszEnWord, nFirstYear - 1 ).lsmEvaluator(100,6
                        );
                        mPageData.put( "historyEvaluatorLinePara6x", lsmEvaluator6x.eval_parameters(0).getArray() );
                        mPageData.put( "historyEvaluatorLineDeri6x", lsmEvaluator6x.eval_parameter_derivative(0).getArray() );

                        mPageData.put( "historyEvaluatorFirstYear", nFirstYear );
                        mPageData.put( "nLastYear", alchemist().mutual().word().historyTeller().getHistoryDatePin().optInt( "date_max" ) );
                    } );
                    put( "mr_relation", (Executor)()->{
                        mPageData.put( "lol", "jesus fucking christ." );
                    } );
                }
            } )).dispatch( szNodeName );
        }
        catch ( SQLException e ){
            throw e;
        }
        catch ( Exception e1 ){
            Debug.cerr( "Notice: " + e1.getMessage() );
        }
    }

}
