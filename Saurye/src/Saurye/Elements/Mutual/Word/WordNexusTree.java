package Saurye.Elements.Mutual.Word;

import Pinecone.Framework.Debug.Debug;
import Pinecone.Framework.System.util.StringTraits;
import Pinecone.Framework.System.util.StringUtils;
import Pinecone.Framework.Util.JSON.JSONArray;
import Pinecone.Framework.Util.JSON.JSONObject;
import Pinecone.Framework.Util.Math.Vectorizer;
import Saurye.Elements.Mutual.Word.HistoryTellerCrystals.LSMEvaluator;
import Saurye.Elements.Prototype.EpitomeCrystal;
import Saurye.Peripheral.Skill.Util.AlgHelper;
import Saurye.Peripheral.Skill.Util.MathHelper;

import java.sql.SQLException;
import java.util.*;

public class WordNexusTree extends AbstractWordTree implements EpitomeCrystal {
    public WordNexusTree( Word stereotype ){
        super( stereotype );
    }

    @Override
    public String elementName() {
        return this.getClass().getSimpleName();
    }

    @Override
    public Word stereotype() {
        return (Word) this.mStereotype;
    }


    private String  mszEnWord;
    private String  mszRootId;

    public WordNexusTree apply( String szEnWord ){
        this.mszEnWord = szEnWord;
        return this;
    }


    private void eval_etym_each( JSONArray that, String szUpperId ) throws SQLException {
        JSONArray jRelevantRaw = this.owned().etym().fetchRelevantBasic( this.mszEnWord );
        int       nRawRelLen   = jRelevantRaw.length();
        if( nRawRelLen == 0 ){
            return;
        }

        JSONObject jWeights = new JSONObject();

        double nMax         = 0.0;
        double nMin         = 1;
        double nSum         = 0.0;
        int[]  idxMap       = new int[10];
        double nCenter      = 0.0;
        double nVani        = 0.0;
        for ( int i = 0; i < nRawRelLen; i++ ) {
            JSONObject row = jRelevantRaw.optJSONObject( i );

            double nThisWeight  = row.optDouble("en_weight");
            String szId         = this.idMaker( szUpperId, i );
            JSONArray jPart     = new JSONArray();
            jPart.put( this.spawnKVNode( this.idMaker( szId, 0 ), "权重", nThisWeight ) );
            jPart.put( this.spawnKVNode( this.idMaker( szId, 1 ), "频度", String.format( "%.2f%%", row.optDouble("e_direct_frequency") / 5e4 * 100 )  )  );
            that.put(  this.spawnNode( szId, row.optString("ety_relevant"), jPart ) );

            nMax = Math.max( nMax, nThisWeight );
            nMin = Math.min( nMin, nThisWeight );
            nSum+= nThisWeight;
            idxMap[ (int)( nThisWeight * 10 ) - 1 ]++;

            double nSigma      = nThisWeight - 0.55;  // Using center
            nCenter           += Math.pow( nSigma, 3 );
            nVani             += Math.pow( nSigma, 2 );
        }

        double nAvg      = nSum / nRawRelLen;
        double nDevi     = Math.sqrt( nVani / nRawRelLen );
        double nSkewness = nCenter / nDevi;

        JSONArray jPart     = new JSONArray();
        String szPartId     = this.idMaker( szUpperId, nRawRelLen );
        jPart.put(  this.spawnKVNode( this.idMaker( szPartId, 0 ), "偏度", String.format( "%.4f",nSkewness ) ) );
        jPart.put(  this.spawnKVNode( this.idMaker( szPartId, 1 ), "平均", String.format( "%.4f",nAvg ) ) );
        JSONObject jWNode   = this.spawnNode( szPartId, "总权", jPart );
        that.put(  jWNode );

        jWeights.put( "w_e_num" , nRawRelLen ) ;
        jWeights.put( "w_e_max" , nMax       ) ;
        jWeights.put( "w_e_min" , nMin       ) ;
        jWeights.put( "w_e_avg" , nAvg       ) ;
        jWeights.put( "w_e_devi", nDevi      ) ;
        jWeights.put( "w_e_skew", nSkewness  ) ;
        jWeights.put( "w_e_i_map", new JSONArray( idxMap ) ) ;

        jWNode.put( "pine_raw_w", jWeights );

    }

    private void eval_etym( JSONArray that ) throws SQLException {
        String szId      = this.mszRootId + "_etym";

        JSONArray jChildren = new JSONArray();
        this.eval_etym_each( jChildren, szId );

        JSONObject jTree = this.spawnNode( szId, "词源", jChildren );
        that.put( jTree );
    }


    private void eval_freq_base( JSONArray that, String szUpperId ) throws SQLException {
        JSONArray  jaBFreqRaw = this.stereotype().fetchBaseFreqRankSum( this.mszEnWord );
        if( jaBFreqRaw!= null && !jaBFreqRaw.isEmpty() ){
            JSONObject jBFreqRaw  = jaBFreqRaw.optJSONObject(0);
            if( jaBFreqRaw.isEmpty() ){
                return;
            }

            that.put(  this.spawnKVNode( this.idMaker( szUpperId, 0 ), "排位", String.format( "%.2f%%", jBFreqRaw.optDouble("total") / 6e4 * 100 )  ) );
            that.put(  this.spawnKVNode( this.idMaker( szUpperId, 1 ), "交流", String.format( "%.2f%%", jBFreqRaw.optDouble("spoken") / 6e4 * 100 )  ) );
            that.put(  this.spawnKVNode( this.idMaker( szUpperId, 2 ), "文学", String.format( "%.2f%%", jBFreqRaw.optDouble("fiction") / 6e4 * 100 )  ) );
            that.put(  this.spawnKVNode( this.idMaker( szUpperId, 3 ), "杂志", String.format( "%.2f%%", jBFreqRaw.optDouble("magazine") / 6e4 * 100 )  ) );
            that.put(  this.spawnKVNode( this.idMaker( szUpperId, 4 ), "新闻", String.format( "%.2f%%", jBFreqRaw.optDouble("newspaper") / 6e4 * 100 )  ) );
            that.put(  this.spawnKVNode( this.idMaker( szUpperId, 5 ), "学术", String.format( "%.2f%%", jBFreqRaw.optDouble("academic") / 6e4 * 100 )  ) );
        }
    }

    private void eval_freq_band( JSONArray that, String szUpperId ) throws SQLException {
        JSONArray  jBandFreqRaw = this.stereotype().fetchBandFreq( this.mszEnWord );

        for ( int i = 0; i < jBandFreqRaw.length(); i++ ) {
            JSONObject row = jBandFreqRaw.optJSONObject( i );

            that.put(  this.spawnKVNode( this.idMaker( szUpperId, i ), row.optString( "e_type" ), String.format( "%.2f%%", row.optDouble("f_rank") / 7.5e3 * 100 )  ) );
        }
    }

    private void eval_freq( JSONArray that ) throws SQLException {
        String szId      = this.mszRootId + "_freq";

        JSONArray jChildren = new JSONArray();

        JSONArray jBaseFreq = new JSONArray();
        String    szBFId    = this.idMaker(szId, 0);
        this.eval_freq_base( jBaseFreq, szBFId );
        jChildren.put( this.spawnNode( szBFId, "基准", jBaseFreq ) );

        JSONArray jBandFreq   = new JSONArray();
        String    szBandFId   = this.idMaker(szId, 1);
        this.eval_freq_band( jBandFreq, szBandFId );
        jChildren.put( this.spawnNode( szBandFId, "考试", jBandFreq ) );

        JSONObject jTree = this.spawnNode( szId, "词频", jChildren );

        that.put( jTree );
    }


    private void eval_band_each( JSONArray that, String szUpperId ) throws SQLException {
        JSONArray jBand = this.stereotype().fetchBandList( this.mszEnWord );
        for ( int i = 0; i < jBand.length(); i++ ) {
            String szBand = jBand.optString(i);

            String szId      = this.idMaker( szUpperId, i );
            that.put(  this.spawnNode( szId, szBand, new JSONArray() ) );
        }
    }

    private void eval_band( JSONArray that ) throws SQLException {
        String szId      = this.mszRootId + "_band";

        JSONArray jChildren = new JSONArray();
        this.eval_band_each( jChildren, szId );

        JSONObject jTree = this.spawnNode( szId, "考试", jChildren );
        that.put( jTree );
    }


    private void eval_frag_each( JSONObject jSuper, JSONArray that, String szUpperId ) throws SQLException {
        JSONArray jCriticalNexusRaw = this.owned().frag().fetchCriticalNexus( this.mszEnWord );
        int       nRawFragLen       = jCriticalNexusRaw.length();
        if( nRawFragLen == 0 ){
            return;
        }

        JSONObject jWeights = new JSONObject();

        int nBandMax        = 0;
        int nBandMin        = 4;
        int nBandSum        = 0;
        double nMax         = 0.0;
        double nMin         = 1;
        double nSum         = 0.0;
        for ( int i = 0; i < nRawFragLen; i++ ) {
            JSONObject row  = jCriticalNexusRaw.optJSONObject(i);

            JSONArray jPart     = new JSONArray();
            String    szPartRId = this.idMaker( szUpperId, i );

            jPart.put( this.spawnKVNode( this.idMaker( szPartRId, 0 ), "类型", row.optString( "c_form_kin" ) ) );
            String szEty = row.optString( "ety_relevant" );
            if( !StringUtils.isEmpty(szEty) ){
                String szEtyRank = this.owned().etym().getLinguaeInfo( szEty ).optString( "en_weight" );
                if( !StringUtils.isEmpty(szEtyRank) ){
                    String szEtyId = this.idMaker( szPartRId, 1 );
                    jPart.put( this.spawnKVNode( szEtyId, "根源",
                            ( (new JSONArray()).put( this.spawnKVNode( this.idMaker( szEtyId, 0 ), szEty ,szEtyRank ) ) )
                    ) );
                }
                double nThisWeight = Double.valueOf( szEtyRank );
                nMax = Math.max( nMax, nThisWeight );
                nMin = Math.min( nMin, nThisWeight );
                nSum+= nThisWeight;
            }

            String szBand = row.optString( "f_rank" );
            if( !StringUtils.isEmpty(szBand) ){
                jPart.put( this.spawnKVNode( this.idMaker( szPartRId, 2 ), "等级", szBand ) );
            }
            int nThisWeight = WordWeightTree.fragmentBandWeightify( szBand );
            nBandMax = Math.max( nBandMax, nThisWeight );
            nBandMin = Math.min( nBandMin, nThisWeight );
            nBandSum+= nThisWeight;

            that.put( this.spawnNode( szPartRId, row.optString( "f_clan_name" ), jPart ) );
        }

        jWeights.put( "w_f_num"      , jCriticalNexusRaw.length()   ) ;
        jWeights.put( "w_f_ety_max"  , nMax                         ) ;
        jWeights.put( "w_f_ety_min"  , nMin                         ) ;
        jWeights.put( "w_f_ety_avg"  , nSum / nRawFragLen           ) ;
        jWeights.put( "w_f_band_max" , nBandMax                     ) ;
        jWeights.put( "w_f_band_min" , nBandMin                     ) ;
        jWeights.put( "w_f_band_avg" , nBandSum  / nRawFragLen      ) ;

        jSuper.put( "pine_raw_w", jWeights );
    }

    private void eval_frag( JSONArray that ) throws SQLException {
        String szId      = this.mszRootId + "_frag";

        JSONArray jChildren = new JSONArray();
        JSONObject jTree = this.spawnNode( szId, "词根", jChildren );
        this.eval_frag_each( jTree, jChildren, szId );
        that.put( jTree );
    }



    private void eval_dyna_history_overall( JSONArray that, String szUpperId, HistoryTeller historyTeller, int nLastYear, JSONObject jWeights ) throws SQLException {
        LSMEvaluator lsmEvaluator = historyTeller.lsmEvaluator(100,9 );

        try{
            double avgD = lsmEvaluator.smoothGradient( 1980, nLastYear ) * 1000;
            that.put( this.spawnKVNode(
                    this.idMaker( szUpperId, 3 ), "变化率", ( avgD > 0 ? "增长" : "衰退" ) + String.format( "%.4f", avgD )
            ) );

            double nAvg8Year = lsmEvaluator.smoothGradient( nLastYear - 6, nLastYear + 1 ) * 1000;  // 8 years

            that.put( this.spawnKVNode( this.idMaker( szUpperId, 4 ), "预测变化率", String.format( "%.4f", nAvg8Year ) ) );

            that.put( this.spawnKVNode( this.idMaker( szUpperId, 5 ), "预趋势", ( nAvg8Year > 0 ? "增长" : "衰退" ) ) );

            jWeights.put( "w_his_predict", nAvg8Year );
        }
        catch ( RuntimeException e ){
            Debug.cerr("Notice: [EvalDyna::RuntimeException]: " + e.getMessage() + "\n" );
        }
    }

    private void eval_dyna_history_rate( JSONArray that, String szUpperId, HistoryTeller.RateResult rateResult, JSONObject jWeights ) throws SQLException {
        HistoryTeller.SmoothInterval interval = rateResult.getSmoothIntervalGradient(20);

        for ( int i = 0; i < interval.mYearInterval.size(); i++ ) {
            JSONArray jRate = new JSONArray();
            String    szR  = this.idMaker( szUpperId, i );
            jRate.put( this.spawnKVNode( this.idMaker( szR, 0 ), "斜率", String.format( "%.4f", interval.mRateInterval.get(i) * 100 ) ) );
            jRate.put( this.spawnKVNode( this.idMaker( szR, 1 ), "变化", interval.mRateInterval.get(i) > 0 ? "增长" : "递减" ) );
            that.put( this.spawnNode( szR, "["+interval.mYearInterval.get(i).toString() + "]", jRate ) );
        }

        jWeights.put( "w_his_near_ratio", interval.mRateInterval.lastElement() * 100 );

    }

    private void eval_dyna_history( JSONArray that, String szUpperId, JSONObject jWeights ) throws SQLException {
        JSONObject jHistoryDatePin = this.stereotype().historyTeller().apply( this.mszEnWord, 0 ).getHistoryDatePin();
        if ( jHistoryDatePin == null || jHistoryDatePin.isEmpty() ){
            return;
        }

        HistoryTeller historyTeller = this.owned().word().historyTeller().apply(
                this.mszEnWord, 1889
        );

        HistoryTeller.RateResult historyRateResult = historyTeller.getHistoryRateObj(-1);

        JSONArray jDate  = new JSONArray();
        String    szRId  = this.idMaker( szUpperId,0 );
        int       nDMin  = jHistoryDatePin.optInt("date_min" );
        double    nVari  = historyRateResult.intervalVariance();
        jDate.put( this.spawnKVNode( this.idMaker( szRId, 0 ), "最早",nDMin ) );
        jDate.put( this.spawnKVNode( this.idMaker( szRId, 1 ), "方差", String.format( "%.4f", nVari ) ) );
        jWeights.put( "w_history_min",  nDMin );
        jWeights.put( "w_his_variance", nVari );


        JSONArray jRate    = new JSONArray();
        String    szRateId = this.idMaker( szRId, 2 );
        this.eval_dyna_history_rate( jRate, szRateId, historyRateResult, jWeights );
        jDate.put( this.spawnNode( szRateId, "变化", jRate ) );


        JSONArray jAll     = new JSONArray();
        String    szOAId   = this.idMaker( szRId, 3 );
        this.eval_dyna_history_overall( jAll, szOAId, historyTeller, jHistoryDatePin.optInt("date_max"), jWeights );
        jDate.put( this.spawnNode( szOAId, "全局", jAll ) );


        //Debug.trace( jHistoryDatePin );

        that.put( this.spawnNode( szRId, "历史", jDate ) );
    }

    private JSONArray fetchSlangBasicNexus ( String szWord ) throws SQLException {
        return this.mysql().fetch(
                String.format( " SELECT MAX( tDef.`c_date` ) AS `date_max`, MIN( tDef.`c_date` ) AS `date_min` FROM " +
                                "%s AS tDef WHERE tDef.`en_slang` = '%s'",
                        this.owned().slang().tabDefsNS(), szWord
                )
        );
    }

    private void eval_dyna_slang( JSONArray that, String szUpperId, JSONObject jWeights ) throws SQLException {
        JSONObject jSlangRaw = this.fetchSlangBasicNexus( this.mszEnWord ).optJSONObject(0);
        if( jSlangRaw.isEmpty() ){
            return;
        }

        JSONArray jSlang = new JSONArray();
        String    szRId  = this.idMaker( szUpperId,1 );
        jSlang.put( this.spawnKVNode( this.idMaker( szRId, 0 ), "最早", jSlangRaw.optString("date_min") ) );
        jSlang.put( this.spawnKVNode( this.idMaker( szRId, 1 ), "最近", jSlangRaw.optString("date_max") ) );

        that.put( this.spawnNode( szRId, "流行", jSlang ) );
        jWeights.put( "w_prevail_min", jSlangRaw.optString("date_min") );
        jWeights.put( "w_prevail_max", jSlangRaw.optString("date_max") );
    }

    private void eval_dyna( JSONArray that ) throws SQLException {
        String szId         = this.mszRootId + "_dyna";

        JSONObject jWeights = new JSONObject();

        JSONArray jChildren = new JSONArray();
        this.eval_dyna_history( jChildren, szId, jWeights );
        this.eval_dyna_slang  ( jChildren, szId, jWeights );
        JSONObject jTree = this.spawnNode( szId, "动态", jChildren );
        that.put( jTree );

        jTree.put( "pine_raw_w", jWeights );
    }



    public JSONArray fetchTradeDictNexus( String szWord ) throws SQLException {
        return this.mysql().fetch(
                String.format("SELECT COUNT(tProD.`w_field`) AS nFields, tProD.`w_field`, tField.`cn_field` FROM " +
                                "( ( SELECT tProD.`w_field` FROM %s AS tProD WHERE tProD.`en_word` = '%s' ) AS tProD LEFT JOIN " +
                                " %s AS tField ON tProD.`w_field` = tField.`en_field`) GROUP BY tProD.`w_field` ",
                        this.owned().dict().tabProEn2CnNS(), szWord,
                        this.owned().dict().tabProFieldNS()
                )
        );
    }

    private void eval_prof_each( JSONArray that, String szUpperId, JSONObject jWeights ) throws SQLException {
        JSONArray jTradeDict = this.fetchTradeDictNexus( this.mszEnWord );

        JSONArray jPart     = new JSONArray();
        String    szPartRId = this.idMaker( szUpperId, 0 );
        int       nDefSum   = 0;
        for ( int i = 0; i < jTradeDict.length(); i++ ) {
            JSONObject row = jTradeDict.optJSONObject(i);

            String    szFieldId = this.idMaker( szPartRId, i );
            int       nDefNum   = row.optInt("nFields");
            jPart.put( this.spawnKVNode( szFieldId, row.optString("cn_field"),
                    ( (new JSONArray()).put( this.spawnKVNode( this.idMaker( szFieldId, 0 ), "定义数" , nDefNum ) ) )
            ) );
            nDefSum += nDefNum;

            //Debug.trace( row );
        }
        that.put( this.spawnNode( szPartRId, "关系", jPart ) );
        that.put( this.spawnKVNode( this.idMaker( szUpperId, 1 ), "关系数", jTradeDict.length() ) );

        jWeights.put( "w_prof_num", jTradeDict.length() );
        jWeights.put( "w_p_def_num", nDefSum );
    }

    private void eval_prof( JSONArray that ) throws SQLException {
        String szId      = this.mszRootId + "_prof";

        JSONObject jWeights = new JSONObject();

        JSONArray jChildren = new JSONArray();
        this.eval_prof_each( jChildren, szId, jWeights );
        JSONObject jTree = this.spawnNode( szId, "专业", jChildren );
        that.put( jTree );

        jTree.put( "pine_raw_w", jWeights );
    }





    private void eval_form_alp(  JSONArray that, String szUpperId, JSONObject jWeights  ) throws SQLException {
        String    szRId  = this.idMaker( szUpperId,0 );

        JSONArray jChildren = new JSONArray();
        jChildren.put(  this.spawnKVNode( this.idMaker( szRId, 0 ), "字母数",  this.mszEnWord.length() ) );

        Map<Character, Integer > countMap = new TreeMap<>();
        double nEntropy  = AlgHelper.entropify( this.mszEnWord.toCharArray(),  countMap );
        Set charOnly     = countMap.keySet();
        double nAlpRatio = (double) charOnly.size() / (double)this.mszEnWord.length();
        jChildren.put(  this.spawnKVNode( this.idMaker( szRId, 1 ), "字母集", charOnly ) );
        jChildren.put(  this.spawnKVNode( this.idMaker( szRId, 2 ), "字集长", charOnly.size() ) );
        jChildren.put(  this.spawnKVNode( this.idMaker( szRId, 3 ), "比例", String.format( "%.3f%%", nAlpRatio  ) ) );
        jChildren.put(  this.spawnKVNode( this.idMaker( szRId, 4 ), "信息熵", String.format( "%.3f",  nEntropy ) ) );
        JSONObject jTree = this.spawnNode( szRId, "字母", jChildren );
        that.put( jTree );

        jWeights.put( "w_form_length", this.mszEnWord.length() );
        jWeights.put( "w_f_alp_ratio", nAlpRatio );
        jWeights.put( "w_f_entropy"  , nEntropy );
    }

    private void eval_form_sub_str_isomer(  JSONArray that, String szUpperId  ) throws SQLException {
        JSONObject jIsomers = this.owned().word().fetchIsomerInfo( this.mszEnWord );

        int i = 0;
        for ( Object obj : jIsomers.entrySet() ){
            Map.Entry  row         = (Map.Entry) obj;
            JSONObject isomerDefs  = (JSONObject) row.getValue();
            String     szIsoId     = this.idMaker( szUpperId, i++ );
            JSONArray  jIsoDefTree = new JSONArray();

            int j = 0;
            for ( Object idObj : isomerDefs.entrySet() ) {
                Map.Entry  isomerDefKV  = (Map.Entry) idObj;
                JSONObject isomerDef    = (JSONObject) isomerDefKV.getValue();

                String szCnDef = isomerDef.optString( "cn_means" );
                jIsoDefTree.put( this.spawnKVNode( this.idMaker( szIsoId, j++ ), (String) isomerDefKV.getKey(),
                         isomerDef.optString( "cn_means" ).substring( 0, szCnDef.length() > 5 ? 5 : szCnDef.length() ) + "..."
                ) );
            }

            that.put( this.spawnKVNode( szIsoId, (String) row.getKey(), jIsoDefTree ) );
        }
    }

    private double[] eval_strings_chain_cos_v_avg  ( ArrayList<String > strings, String szUpperId, JSONArray jChildren ){
        Vectorizer<Character >  vectorizer = new Vectorizer<>( AlgHelper.vectorifyArrays( strings ) );
        Vector<Vector<Double >> chain      = MathHelper.evalCosSimilarityChain( vectorizer.getResult() );
        String szSimId     = this.idMaker( szUpperId, strings.size() );
        double[] results   = new double[]{
                Math.sqrt( MathHelper.getUnionCosVarianceByChain( chain ) ),
                MathHelper.getUnionCosSimilarityByChain( chain, strings.size() > 2 )
        };

        jChildren.put( this.spawnKVNode( this.idMaker( szSimId, 0 ), "标准差", results[0] )  );
        jChildren.put( this.spawnKVNode( this.idMaker( szSimId, 1 ), "链式值", results[1] )  );

        return results;
    }

    private double[] put_strings_chain_cos_v_avg   ( ArrayList<String > strings, String szUpperId, JSONArray jChildren ) {
        for ( int i = 0; i < strings.size(); i++ ) {
            jChildren.put( this.spawnKVNode( this.idMaker( szUpperId, i ), strings.get( i ), new JSONArray() ) );
        }

        String szRootId     = this.idMaker( szUpperId, strings.size() );
        JSONArray jRoots    = new JSONArray();
        double[] results    = this.eval_strings_chain_cos_v_avg( strings, szRootId, jRoots );
        jChildren.put( this.spawnKVNode( szRootId, "相似度", jRoots ) );

        return results;
    }

    private void eval_form_sub_str (  JSONArray that, String szUpperId, JSONObject jWeights  ) throws SQLException {
        String    szRId  = this.idMaker( szUpperId,1 );

        JSONArray jChildren = new JSONArray();
        
        JSONArray jMirror = new JSONArray();
        String    szMirrorId  = this.idMaker( szRId, 0 );

        String    szLowerWord = this.mszEnWord.toLowerCase();
        String[]  debris      = AlgHelper.mirroifyString( szLowerWord );
        String    szLeftSeq   = debris[0];
        String    szMidSeq    = debris[1];
        String    szRightSeq  = debris[2];

        jMirror.put(  this.spawnKVNode( this.idMaker( szMirrorId, 0 ), "左", szLeftSeq ) );
        jMirror.put(  this.spawnKVNode( this.idMaker( szMirrorId, 1 ), "轴", szMidSeq ) );
        jMirror.put(  this.spawnKVNode( this.idMaker( szMirrorId, 2 ), "右", szRightSeq ) );
        double nMirrorSim = MathHelper.getCosineSimilarity( debris[0], debris[2] );
        String szType  = "普通";
        int nMirrTrait = 0;
        if( StringTraits.isChiralString( szLowerWord, false ) ){ // Has already toLower.
            szType     = "手性/回文";
            nMirrTrait = 3;
        }
        else if( StringTraits.isHomoString( szLowerWord, false ) ){
            szType     = "同型/逆手性";
            nMirrTrait = 2;
        }
        else if( nMirrorSim > 0.999 ){
            szType     = "异构";
            nMirrTrait = 1;
        }
        if( ( (Double) nMirrorSim ).isNaN() ){
            nMirrorSim = 0.0;
        }
        jMirror.put(  this.spawnKVNode( this.idMaker( szMirrorId, 3 ), "特征", szType ) );
        jMirror.put(  this.spawnKVNode( this.idMaker( szMirrorId, 4 ), "相似度", nMirrorSim ) );

        jChildren.put( this.spawnKVNode( szMirrorId, "镜像", jMirror ) );

        jWeights.put( "w_f_mirr_trait", nMirrTrait );
        jWeights.put( "w_f_mirr_sim", nMirrorSim   );


        JSONArray jChunk     = new JSONArray();
        String    szChunkId  = this.idMaker( szRId, 1 );
        ArrayList<String > chunks = AlgHelper.chunkify( this.mszEnWord, 4, 7 );

        double[] hChunkRes   = this.put_strings_chain_cos_v_avg( chunks, szChunkId, jChunk );

        jChildren.put( this.spawnKVNode( szChunkId, "组块", jChunk ) );


        JSONArray jGold    = new JSONArray();
        String    szGolId  = this.idMaker( szRId, 2 );
        String[]  szGolds  = AlgHelper.goldify( this.mszEnWord );

        jGold.put( this.spawnKVNode( this.idMaker( szGolId, 0 ), "左", szGolds[0] ) );
        jGold.put( this.spawnKVNode( this.idMaker( szGolId, 1 ), "右", szGolds[1]) );

        jChildren.put( this.spawnKVNode( szGolId, "黄金", jGold ) );


        JSONArray jAtomic  = new JSONArray();
        String    szDepId  = this.idMaker( szRId, 3 );
        ArrayList<String > minAtomicWords = AlgHelper.atomify( this.mszEnWord );

        double[] hAtomRes  = this.put_strings_chain_cos_v_avg( minAtomicWords, szDepId, jAtomic );

        jChildren.put( this.spawnKVNode( szDepId, "原子化", jAtomic ) );
        jWeights.put( "w_f_atom_sim", hChunkRes[1] * hAtomRes[1]  );


        JSONArray jIsomers  = new JSONArray();
        String    szIsoId   = this.idMaker( szRId, 4 );
        this.eval_form_sub_str_isomer( jIsomers, szIsoId );
        jChildren.put( this.spawnKVNode( szIsoId, "同分异构", jIsomers ) );
        jWeights.put( "w_f_iso_num", jIsomers.length()  );


        JSONObject jTree = this.spawnNode( szRId, "子串", jChildren );
        that.put( jTree );
    }

    private void eval_form_bm_def  (  JSONArray that, String szUpperId, JSONObject jWeights  ) throws SQLException {
        String    szRId  = this.idMaker( szUpperId,2 );

        JSONArray jChildren = new JSONArray();

        JSONObject jCnDef = this.owned().dict().dictEn2Cn().fetchCnIndexMap( this.mszEnWord );
        if( jCnDef.isEmpty() ){
            return;
        }

        JSONArray jEachMeanTree = new JSONArray();
        String    szDefId = this.idMaker( szRId, 0 );
        int i = 0;
        ArrayList<String > cnDefs  = new ArrayList<>();
        for ( Object obj : jCnDef.entrySet() ) {
            Map.Entry row = (Map.Entry)obj;
            JSONArray eachMeans = ( JSONArray ) row.getValue();
            String szEsId  = this.idMaker( szDefId, i );

            JSONArray realEachMeans = new JSONArray();
            for ( int j = 0; j < eachMeans.length(); j++ ) {
                String szEachMean = eachMeans.optString( j );
                String szEId  = this.idMaker( szEsId, j );

                realEachMeans.put( this.spawnKVNode( szEId, szEachMean, new JSONArray() ) );
                cnDefs.add( szEachMean );
            }

            jEachMeanTree.put( this.spawnKVNode( szEsId, (String) row.getKey(), realEachMeans ) );
            i++;
        }
        jChildren.put( this.spawnKVNode( szDefId, "定义", jEachMeanTree ) );


        JSONArray jSiTree = new JSONArray();
        String    szSiId  = this.idMaker( szRId, 1 );
        double[]  defRets = this.eval_strings_chain_cos_v_avg( cnDefs, szSiId, jSiTree );

        jChildren.put( this.spawnKVNode( szSiId, "相似度", jSiTree ) );

        Vectorizer<Character >  vectorizer = new Vectorizer<>( AlgHelper.vectorifyArrays( cnDefs ) );
        double nEntropy  = MathHelper.probably1xEntropify( MathHelper.prob_1x_each_ele_mode( vectorizer.getResult() ) );
        jChildren.put( this.spawnKVNode( this.idMaker( szRId, 2 ), "信息熵", nEntropy ) );

        jWeights .put( "w_f_def_entropy", nEntropy );


        JSONObject jTree = this.spawnNode( szRId, "词义", jChildren );
        that.put( jTree );
    }

    private void eval_form(  JSONArray that  ) throws SQLException {
        String szId      = this.mszRootId + "_form";

        JSONObject jWeights = new JSONObject();

        JSONArray jChildren = new JSONArray();
        this.eval_form_alp     ( jChildren, szId, jWeights );
        this.eval_form_sub_str ( jChildren, szId, jWeights );
        this.eval_form_bm_def  ( jChildren, szId, jWeights );
        JSONObject jTree = this.spawnNode( szId, "形式", jChildren );
        that .put( jTree );
        jTree.put( "pine_raw_w", jWeights );
    }

    public JSONObject eval()  throws SQLException {
        JSONObject jTree = new JSONObject();
        this.mszRootId = this.mszEnWord + "_root";
        jTree.put( "id", this.mszRootId );
        jTree.put( "name", this.mszEnWord );
        JSONArray jChildren = new JSONArray();

        this.eval_etym( jChildren );
        this.eval_freq( jChildren );
        this.eval_band( jChildren );
        this.eval_frag( jChildren );
        this.eval_dyna( jChildren );
        this.eval_prof( jChildren );
        this.eval_form( jChildren );

        jTree.put( "children", jChildren );

        return jTree;
    }

}
