package Saurye.Elements.Mutual.Word;

import Jama.Matrix;
import Pinecone.Framework.System.Functions.Function;
import Pinecone.Framework.Util.JSON.JSONArray;
import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.Elements.Mutual.EpitomeSharded;
import Saurye.Elements.Mutual.Word.HistoryTellerCrystals.LSMEvaluator;
import Saurye.Elements.Prototype.EpitomeCrystal;

import java.sql.SQLException;
import java.util.Map;
import java.util.Vector;

public class HistoryTeller extends EpitomeSharded implements EpitomeCrystal {
    public HistoryTeller ( Word stereotype ){
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




    private String mszEnWord        ;
    private String mszPoS     = null;
    private int    mnYearFrom = 0   ;
    private int    mnYearTo   = 0   ;

    public HistoryTeller apply( String szEnWord, String szPoS, int nYearFrom, int nYearTo ) {
        this.mszEnWord  = szEnWord;
        this.mszPoS     = szPoS;
        this.mnYearFrom = nYearFrom;
        this.mnYearTo   = nYearTo;
        return this;
    }

    public HistoryTeller apply( String szEnWord, int nYearFrom, int nYearTo ) {
        this.mszEnWord  = szEnWord;
        this.mszPoS     = null;
        this.mnYearFrom = nYearFrom;
        this.mnYearTo   = nYearTo;
        return this;
    }

    public HistoryTeller apply( String szEnWord, int nYearFrom ) {
        this.mszEnWord  = szEnWord;
        this.mszPoS     = null;
        this.mnYearFrom = nYearFrom;
        this.mnYearTo   = 0;
        return this;
    }

    private void beforeFetch() {
        if( this.mnYearFrom == 0 ){
            this.mnYearFrom = 1505;
        }
        if( this.mnYearTo == 0 ){
            this.mnYearTo   = 2021;
        }
    }

    public JSONArray getHistoryUsage() throws SQLException {
        this.beforeFetch();
        String szCondition = "";
        if( this.mszPoS != null ){
            szCondition = " AND tHis.`f_pos` = '" + this.mszPoS + "'";
        }
        return this.mysql().fetch(
                String.format(  " SELECT SUM( tHis.`f_count` ) AS `f_count`, tHis.`f_year` FROM %s AS tHis" +
                                " WHERE tHis.`f_year` > %s AND tHis.`f_year` < %s AND tHis.`en_word` = '%s' %s GROUP BY tHis.`en_word`, tHis.`f_year`",
                        this.stereotype().tabFrequencyYearNS(),
                        this.mnYearFrom, this.mnYearTo,
                        this.mszEnWord, szCondition
                )
        );
    }

    public JSONArray getHistoryUsageConsult() throws SQLException {
        this.beforeFetch();
        String szCondition = "";
        if( this.mszPoS != null ){
            szCondition = " AND tHis.`f_pos` = '" + this.mszPoS + "'";
        }
        return this.mysql().fetch( String.format( " SELECT SUM( tHis.`f_count_sum` ) AS `f_count_sum`, tHis.`f_year` FROM %s AS tHis" +
                        " WHERE tHis.`f_year` > %s AND tHis.`f_year` < %s %s  GROUP BY tHis.`f_year`",
                this.stereotype().tabFQYearConsultNS(),
                this.mnYearFrom, this.mnYearTo, szCondition
        ));
    }

    public JSONObject getHistoryRate( Function fn ) throws SQLException {
        JSONArray  jUsage    = this.getHistoryUsage();
        JSONArray  jConsult  = this.getHistoryUsageConsult();

        JSONObject jCYearMap = new JSONObject();
        for ( int i = 0; i < jConsult.length(); i++ ) {
            JSONObject jEach = jConsult.optJSONObject(i);
            jCYearMap.put( jEach.optString("f_year"), jEach.optLong("f_count_sum") );
        }

        JSONObject jResult   = new JSONObject();
        if( !jUsage.isEmpty() && !jConsult.isEmpty() ){
            for ( int i = 0; i < jUsage.length(); i++ ) {
                JSONObject jEach = jUsage.optJSONObject(i);
                try {
                    jResult.put(
                            jEach.optString("f_year"),
                            fn.invoke( jEach.optDouble("f_count" ), jCYearMap.optDouble( jEach.optString("f_year") ) )
                    );
                }
                catch ( Exception e ) {
                    continue;
                }
            }
        }

        return jResult;
    }

    public JSONObject getHistoryRate( int nMut ) throws SQLException {
        return this.getHistoryRate( ( Object... obj )->{
            double x1 = (double) obj[0], x2 = (double) obj[1];
            double nRatio = x1 / x2 * nMut;
            if( nRatio < 1e-7 ){
                nRatio *= nMut;
            }
            return nRatio;
        } );
    }

    public JSONObject getHistoryRateLog() throws SQLException {
        return this.getHistoryRate( ( Object... obj )->{
            double x1 = (double) obj[0], x2 = (double) obj[1];
            return Math.log( x1 / x2 );
        } );
    }

    public JSONObject getHistoryDatePin() throws SQLException {
        String szCondition = "";
        if( this.mszPoS != null ){
            szCondition = " AND tHis.`f_pos` = '" + this.mszPoS + "'";
        }
        return this.mysql().fetch(
                String.format(  " SELECT MAX( tHis.`f_year` ) AS `date_max`, MIN( tHis.`f_year` ) AS `date_min` FROM %s AS tHis" +
                                " WHERE tHis.`en_word` = '%s' %s GROUP BY tHis.`en_word` ",
                        this.stereotype().tabFrequencyYearNS(),
                        this.mszEnWord, szCondition
                )
        ).optJSONObject(0);
    }


    /** nMut < 0 -> using log **/
    public RateResult getHistoryRateObj( int nMut ) throws SQLException {
        JSONObject jResult = nMut < 0 ? this.getHistoryRateLog() : this.getHistoryRate( nMut );
        RateResult rateResult = new RateResult();
        rateResult.mnYearFrom = this.mnYearFrom;
        rateResult.mnYearTo   = this.mnYearTo;
        rateResult.mszEnWord  = this.mszEnWord;
        rateResult.mszPoS     = this.mszPoS;
        rateResult.mResult    = jResult;
        return rateResult;
    }


    public class YearPair {
        public String yearFrom;
        public String yearTo;

        public String toString() {
            return this.yearFrom + "-" + this.yearTo ;
        }
    }

    public class SmoothInterval {
        public Vector<YearPair > mYearInterval = new Vector<>();
        public Vector<Double   > mRateInterval = new Vector<>();
        public int               mnSmoothMut;
    }

    public class RateResult {
        public JSONObject mResult;
        public String     mszEnWord        ;
        public String     mszPoS     = null;
        public int        mnYearFrom = 0   ;
        public int        mnYearTo   = 0   ;

        public int effectiveYears() {
            return this.mResult.size();
        }

        public double intervalSum(){
            double nSum = 0.0;
            for ( Object obj : this.mResult.entrySet() ) {
                Map.Entry row = (Map.Entry) obj;

                nSum += Math.abs( (double)row.getValue() );
            }

            return nSum;
        }

        public double intervalAvg(){
            return this.intervalSum() / this.effectiveYears();
        }

        public double intervalVariance() {
            double nAvg      = this.intervalAvg();
            double nVariance = 0.0;
            for ( Object obj : this.mResult.entrySet() ) {
                Map.Entry row = (Map.Entry) obj;

                nVariance += Math.pow( ( Math.abs( (double)row.getValue() ) - nAvg ), 2 );
            }

            return nVariance / this.effectiveYears();
        }

        public Matrix yearRateMatrix() {
            Matrix matrix = new Matrix( 2, this.effectiveYears() );

            int i = 0;
            for ( Object obj : this.mResult.entrySet() ) {
                Map.Entry row = (Map.Entry) obj;

                matrix.set( 0, i, Double.valueOf( row.getKey().toString() ) );
                matrix.set( 1, i, (double)row.getValue() );

                i++;
            }

            return matrix;
        }

        public SmoothInterval getSmoothIntervalGradient ( int nSmoothInterval ) {
            Matrix matrix           = this.yearRateMatrix();
            SmoothInterval interval = new SmoothInterval();
            interval.mnSmoothMut    = nSmoothInterval;

            int nYears = this.effectiveYears();
            Vector<Double > dets = new Vector<>();
            for ( int i = 0; i < nYears; i++ ) {
                double nDt = 0;

                if( i > 0 ){
                    nDt = matrix.get(1, i ) - matrix.get(1, i - 1 );
                    dets.add( nDt );
                }
            }

            //Debug.trace( dets );
            int  sigm = 0;
            int  nYearLength = matrix.getArray()[0].length;
            int  nMod = ( nYearLength / nSmoothInterval ) * nSmoothInterval;

            for ( int i = 0; i < nMod; i++ ) {
                if( i % nSmoothInterval == 0 ){
                    interval.mYearInterval.add( new YearPair() );
                    interval.mYearInterval.get( sigm ).yearFrom = String.format( "%.0f", matrix.get(0, sigm * nSmoothInterval )  );
                    interval.mYearInterval.get( sigm ).yearTo   = String.format( "%.0f",matrix.get(0, sigm * nSmoothInterval + nSmoothInterval - 1 ) );
                    sigm++;
                }
            }
            if( nYearLength - nMod != 0 ){
                interval.mYearInterval.add( new YearPair() );
                interval.mYearInterval.get( sigm ).yearTo   = String.format( "%.0f", matrix.get(0, nYearLength - 1 ) );
                interval.mYearInterval.get( sigm ).yearFrom = String.format( "%.0f", matrix.get(0, nMod ) );
            }

            double sum  = 0;
            int nDtSmooth = nSmoothInterval - 1;
            int nDtMod = ( dets.size() / nDtSmooth ) * nDtSmooth;
            for ( int i = 0; i < nDtMod; i++ ) {
                if( i %  nDtSmooth == 0 && i != 0 || i == nDtMod - 1 ){
                    if( i == nMod - 1 ) {
                        sum+= dets.get( i + 1 );
                    }
                    interval.mRateInterval.add( sum /  nDtSmooth );
                    sum = 0;
                }
                sum+= dets.get( i );
            }
            if( dets.size() - nDtMod != 0 ){
                sum = 0;
                for ( int i = nDtMod; i < dets.size(); i++ ) {
                    sum+= dets.get( i );
                }

                if( interval.mYearInterval.size() == interval.mRateInterval.size() ){
                    int nLastCount = dets.size() - nDtMod;
                    interval.mRateInterval.set(
                            interval.mRateInterval.size() -1 ,
                            ( interval.mRateInterval.lastElement() * nDtSmooth + sum ) /  ( nDtSmooth + nLastCount )
                    );
                }
                else {
                    interval.mRateInterval.add( sum /  ( dets.size() - nDtMod ) );
                }
            }


//            Debug.trace( interval.mYearInterval );
//            Debug.trace( interval.mRateInterval );

            return interval;
        }
    }

    public LSMEvaluator lsmEvaluator() {
        return new LSMEvaluator( this.stereotype(), this );
    }

    public LSMEvaluator lsmEvaluator( int nMut ) throws SQLException {
        return new LSMEvaluator( this.stereotype(), this, this.getHistoryRateObj(nMut) );
    }

    public LSMEvaluator lsmEvaluator( int nMut, int nPolyPara ) throws SQLException {
        return new LSMEvaluator( this.stereotype(), this, this.getHistoryRateObj(nMut), nPolyPara );
    }

}
