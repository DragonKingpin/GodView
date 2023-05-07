package Saurye.Peripheral.Skill.Util;

import Jama.Matrix;
import Pinecone.Framework.Util.Math.Vectorizer;

import java.util.*;

public class MathHelper {

    public static double polynomialEval ( Matrix para, double x ) {
        int nPolyPara = para.getArray().length;

        double y = 0.0;
        for ( int i = 0; i < nPolyPara; i++ ) {
            y += para.getArray()[i][0] * Math.pow( x, i );
        }

        return y;
    }

    public static double getCosineSimilarity( Vector<Double > x, Vector<Double > y ) {
        double vectorMulSum = 0, vectorAMulSqrt = 0, vectorBMulSqrt = 0;

        if( x.size() != y.size() ){
            throw new IllegalArgumentException("ERROR: Sizeof vectorA is unmatched with vectorB !");
        }

        for( int i = 0; i < x.size(); i++ ){
            vectorMulSum   += x.get(i) * y.get(i);
            vectorAMulSqrt += Math.pow( x.get(i), 2.0 );
            vectorBMulSqrt += Math.pow( y.get(i), 2.0 );
        }
        vectorAMulSqrt = Math.sqrt( vectorAMulSqrt );
        vectorBMulSqrt = Math.sqrt( vectorBMulSqrt );

        return vectorMulSum / ( vectorAMulSqrt * vectorBMulSqrt );
    }

    public static double getCosineSimilarity( String x, String y ) {
        Vectorizer<Character > vectorizer = new Vectorizer<>( AlgHelper.vectorify( x.toCharArray() ), AlgHelper.vectorify( y.toCharArray() ) );
        return MathHelper.getCosineSimilarity( vectorizer.getResult().get(0), vectorizer.getResult().get(1) );
    }

    // M = n * n-1 * n - 2 * ... * 1 / n! chain
    public static Vector<Vector<Double >> evalCosSimilarityChain( Vector<Vector<Double >> vectors ) {
        Vector<Vector<Double >> chain = new Vector<>();

        for ( int i = vectors.size() - 1, id = 0; i >= 0 ; --i ) {
            chain.add( new Vector<>() );
            for ( int j = 0; j <= i; ++j ) {
                chain.get( id ).add( MathHelper.getCosineSimilarity( vectors.get(i), vectors.get(j) ) );
            }
            ++id;
        }

        return chain;
    }

    // Chain Matrix Transitive Similarity
    public static double getUnionCosSimilarityByChain( Vector<Vector<Double > > chain, boolean bAvgMode, double nZeroFactor ) {
        double nP = bAvgMode ? 0.0 : 1.0 ;
        int nSum  = 0;
        for ( int i = chain.size() - 1, id = 0; i >= 0 ; --i ) {
            for ( int j = 0; j <= i; ++j ) {
                if( bAvgMode ){
                    nP += chain.get( id ).get(j);
                }
                else {
                    double nEleP = chain.get( id ).get( j );
                    nEleP = nEleP == 0 ? nZeroFactor : nEleP;
                    nP *= nEleP;
                }

                ++nSum;
            }
            ++id;
        }

        return bAvgMode? nP / nSum : nP;
    }

    public static double getUnionCosSimilarityByChain( Vector<Vector<Double > > chain, boolean bAvgMode ) {
        return MathHelper.getUnionCosSimilarityByChain( chain, bAvgMode, 0.1 );
    }

    public static double getUnionCosSimilarity( Vector<Vector<Double > > vectors, boolean bAvgMode, double nZeroFactor ) {
        return MathHelper.getUnionCosSimilarityByChain( MathHelper.evalCosSimilarityChain( vectors ), bAvgMode, nZeroFactor );
    }

    public static double getUnionCosSimilarity( Vector<Vector<Double > > vectors, boolean bAvgMode ) {
        return MathHelper.getUnionCosSimilarityByChain( MathHelper.evalCosSimilarityChain( vectors ), bAvgMode );
    }

    public static double getUnionCosVarianceByChain( Vector<Vector<Double > > chain ) {
        double nAvg  = MathHelper.getUnionCosSimilarityByChain( chain, true );
        double nVari = 0.0;
        for ( int i = chain.size() - 1, id = 0; i >= 0 ; --i ) {
            for ( int j = 0; j <= i; ++j ) {
                nVari += Math.pow( chain.get( id ).get( j ) - nAvg, 2.0 );
            }
            ++id;
        }

        return nVari / nAvg;
    }

    public static double getUnionCosVariance ( Vector<Vector<Double > > vectors ) {
        return MathHelper.getUnionCosVarianceByChain( MathHelper.evalCosSimilarityChain( vectors ) );
    }


    /** Information theory **/
    public static double sigmaify ( Vector<Double > elementVec ) {
        double nSigma = 0.0;
        for ( int i = 0; i < elementVec.size(); i++ ) {
            nSigma += elementVec.get( i );
        }
        return nSigma;
    }

    // To < 0 -> all
    public static double mutualIndexMatrixSumify(  Vector<Vector<Double >> mutualIndexMatrix, int nFrom, int nTo ) {
        double nSum = 0.0;
        nTo = nTo < 0 ? mutualIndexMatrix.size() : nTo;
        for ( int i = nFrom; i < nTo; i++ ) {
            Vector<Double > elementX = mutualIndexMatrix.get( i );
            double nSigma = MathHelper.sigmaify( elementX );
            nSum+= nSigma;
        }
        return nSum;
    }

    public static double mutualIndexMatrixSumify(  Vector<Vector<Double >> mutualIndexMatrix ) {
        return MathHelper.mutualIndexMatrixSumify( mutualIndexMatrix, 0, -1 );
    }

    public static double probably1xMulify( Vector<Double > mutualP1x, int nFrom, int nTo ) {
        double nMul = 1.0;
        nTo = nTo < 0 ? mutualP1x.size() : nTo;
        for ( int i = nFrom; i < nTo; i++ ) {
            double pX = mutualP1x.get( i );
            nMul*= pX;
        }
        return nMul;
    }

    public static double probably1xMulify(  Vector<Double > mutualP1x ) {
        return MathHelper.probably1xMulify( mutualP1x, 0, -1 );
    }

    public static double probably1xEntropify( Vector<Double > mutualP1x, int nFrom, int nTo ) {
        double nEntropy = 0.0;
        nTo = nTo < 0 ? mutualP1x.size() : nTo;
        for ( int i = nFrom; i < nTo; i++ ) {
            double nP    =  mutualP1x.get( i );
            nEntropy+= nP * Math.log( nP );
        }
        return - nEntropy;
    }

    public static double probably1xEntropify(  Vector<Double > mutualP1x ) {
        return MathHelper.probably1xEntropify( mutualP1x, 0, -1 );
    }

    public static Vector<Double > prob_1x_each_ele_mode (  Vector<Vector<Double >> mutualIndexMatrix ) {
        Vector<Double > probablyDistribute = new Vector<>();
        double nSum = 0.0;
        for ( int i = 0; i < mutualIndexMatrix.size(); i++ ) {
            Vector<Double > elementX = mutualIndexMatrix.get( i );
            for ( int j = 0; j < elementX.size(); j++ ) {
                double nEle = elementX.get( j );
                nSum += nEle;
            }
        }

        for ( int i = 0; i < mutualIndexMatrix.size(); i++ ) {
            Vector<Double > elementX = mutualIndexMatrix.get( i );
            for ( int j = 0; j < elementX.size(); j++ ) {
                double nEle = elementX.get( j );
                if( nEle > 0 ){
                    probablyDistribute.add( nEle / nSum );
                }
            }
        }

        return probablyDistribute;
    }

    public static Vector<Double > probabilitify_1x (  Vector<Vector<Double >> mutualIndexMatrix ) {
        Vector<Double > probablyDistribute = new Vector<>();
        double nSum = MathHelper.mutualIndexMatrixSumify( mutualIndexMatrix );

        for ( int i = 0; i < mutualIndexMatrix.size(); i++ ) {
            Vector<Double > elementX = mutualIndexMatrix.get( i );
            double nSigma = MathHelper.sigmaify( elementX );
            probablyDistribute.add( nSigma / nSum );
        }

        return probablyDistribute;
    }

    public static Vector<Vector<Double >> evalMutualProbablyChain( Vector<Vector<Double >> mutualIndexMatrix ) {
        Vector<Vector<Double >> chain = new Vector<>();
        double nSum = MathHelper.mutualIndexMatrixSumify( mutualIndexMatrix );
        //Vector<Double > p1xs = MathHelper.probabilitify_1x( mutualIndexMatrix );

        for ( int i = mutualIndexMatrix.size() - 1, id = 0; i >= 0 ; --i ) {
            chain.add( new Vector<>() );
            for ( int j = 0; j <= i; ++j ) {
                //double nMutualP = MathHelper.probably1xMulify( p1xs, j , i + 1 );
                double nMutualP = MathHelper.mutualIndexMatrixSumify( mutualIndexMatrix, j, i + 1) / nSum;
                chain.get( id ).add( nMutualP );
            }
            ++id;
        }

        return chain;
    }



}
