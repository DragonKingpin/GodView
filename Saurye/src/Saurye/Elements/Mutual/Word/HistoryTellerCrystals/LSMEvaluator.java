package Saurye.Elements.Mutual.Word.HistoryTellerCrystals;

import Jama.Matrix;
import Saurye.Elements.Mutual.EpitomeSharded;
import Saurye.Elements.Mutual.Word.HistoryTeller;
import Saurye.Elements.Mutual.Word.Word;
import Saurye.Elements.Prototype.EpitomeCrystal;
import Saurye.Peripheral.Skill.Util.MathHelper;

public class LSMEvaluator extends EpitomeSharded implements EpitomeCrystal {
    protected LSMEvaluator(Word stereotype ){
        super( stereotype );
    }

    @Override
    public String elementName() {
        return this.getClass().getSimpleName();
    }

    @Override
    public Word stereotype() {
        return ( Word ) this.mStereotype;
    }

    HistoryTeller  mHistoryTeller;

    public LSMEvaluator( Word stereotype, HistoryTeller historyTeller ) {
        super( stereotype );
        this.mHistoryTeller = historyTeller;
    }

    public LSMEvaluator( Word stereotype, HistoryTeller historyTeller, HistoryTeller.RateResult rateResult  ) {
        this( stereotype, historyTeller );
        this.apply( rateResult );
    }

    public LSMEvaluator( Word stereotype, HistoryTeller historyTeller, HistoryTeller.RateResult rateResult, int nPolyPara  ) {
        this( stereotype, historyTeller );
        this.apply( rateResult, nPolyPara );
    }

    // f(x) = a0 + a1x + a2x^2 + a3x^3 +... anx^n
    // [ [X0] , [X1], [X2], [X3], ..., [Xn] ] [ [A0] , [A1], [A2], [A3], ..., [An] ] = [ [Y0] , [Y1], [Y2], [Y3], ..., [Yn] ]

    private Matrix     mParameters ; // [ [A0], [A1], [A2], [A3], ..., [An] ]

    private Matrix     mYearRates  ; // f(year) = a0 + a1 rate + a2 rate^2 + a3 rate^3 + ... an rate^n

    private int        mnPolyPara  ;

    private double     mnFirstYear ;

    private HistoryTeller.RateResult  mRateResult;

    public LSMEvaluator apply( HistoryTeller.RateResult rateResult, int nPolyPara ) {
        this.mRateResult = rateResult;
        this.mYearRates  = this.mRateResult.yearRateMatrix();
        this.mnPolyPara  = nPolyPara;
        this.mnFirstYear = this.mYearRates.get(0,0);

        return this;
    }

    public LSMEvaluator apply( HistoryTeller.RateResult rateResult ) {
        return this.apply( rateResult, 4 );
    }

    private int elementSize () {
        return this.mYearRates.getArray()[0].length;
    }

    private int eval_to( int nTo ){
        return nTo == 0 ? this.elementSize() : nTo;
    }

    // Σ x^k  nTo = 0 -> all
    private double eval_polynomial_x ( int nCoefficient, int nTo ){
        nTo = this.eval_to( nTo );

        double sum = 0.0;
        for ( int i = 0; i < nTo; i++ ) {
            double alp = this.mYearRates.get(0,i ) - this.mnFirstYear;
            if( nCoefficient == 1 ){
                sum += alp;
            }
            else {
                sum += Math.pow( alp, nCoefficient );
            }
        }

        return sum;
    }

    // Σ y^k  nTo = 0 -> all
    private double eval_polynomial_y ( int nCoefficient, int nTo ){
        nTo = this.eval_to( nTo );

        double sum = 0.0;
        for ( int i = 0; i < nTo; i++ ) {
            double alp = this.mYearRates.get(1,i );
            if( nCoefficient == 1 ){
                sum += alp;
            }
            else {
                sum += Math.pow( alp, nCoefficient );
            }
        }

        return sum;
    }

    // Σ x^k * y nTo = 0 -> all
    private double eval_polynomial_xk_y ( int nCoefficient, int nTo ){
        nTo = this.eval_to( nTo );

        double sum = 0.0;
        for ( int i = 0; i < nTo; i++ ) {
            double alp_x = this.mYearRates.get(0,i ) - this.mnFirstYear;
            double alp_y = this.mYearRates.get(1,i );
            if( nCoefficient == 1 ){
                sum += alp_x * alp_y;
            }
            else {
                sum += Math.pow( alp_x, nCoefficient ) * alp_y;
            }
        }

        return sum;
    }

    public Matrix eval_x_deviate_matrix( int nTo ){
        nTo = this.eval_to( nTo );
        Matrix poly_x = new Matrix( this.mnPolyPara, this.mnPolyPara );

        for ( int i = 0; i < this.mnPolyPara; i++ ) {
            for ( int y = 0; y < this.mnPolyPara; y++ ) {
                int k = y + i;
                poly_x.set( i, y, this.eval_polynomial_x( k, nTo ) );
            }
        }

        poly_x.set( 0,0, this.elementSize() ); // [ N xi xi^2... ]

        return poly_x;
    }

    public Matrix eval_y_deviate_matrix( int nTo ){
        nTo = this.eval_to( nTo );
        Matrix poly_y = new Matrix( this.mnPolyPara, 1 );

        double nX0Y = this.eval_polynomial_y( 1, nTo );
        poly_y.set( 0,0, nX0Y );
        for ( int i = 1; i < this.mnPolyPara; i++ ) {
            poly_y.set( i,0, this.eval_polynomial_xk_y( i, nTo ) );
        }

        return poly_y;
    }

    public Matrix eval_parameters( int nTo ) {
        this.mParameters = this.eval_x_deviate_matrix( nTo ).solve( this.eval_y_deviate_matrix( nTo ) );
        return this.mParameters;
    }

    public Matrix eval_parameters_mut( int nTo, int nMut ) {
        this.mParameters = this.eval_parameters( nTo );
        for ( int i = 0; i < this.mParameters.getArray().length; i++ ) {
            for ( int j = 0; j < this.mParameters.getArray()[i].length; j++ ) {
                this.mParameters.set( i, j, this.mParameters.get( i, j ) * nMut  );
            }
        }
        return this.mParameters;
    }

    public Matrix eval_parameter_derivative( int nTo ){
        Matrix parameter = this.eval_parameters( nTo );

        Matrix derivative = new Matrix( parameter.getArray().length - 1, 1 );

        for ( int i = 1; i < parameter.getArray().length; i++ ) {
            derivative.set( i - 1, 0, parameter.get( i, 0 ) * i );
        }

        return derivative;
    }


    // f(x2) - f(x1) / x2 - x1 : Average rate of change
    public double smoothGradient( Matrix para, int nYearFrom, int nTo ) {
        double nF = nYearFrom - this.mnFirstYear;
        double nT = nTo - this.mnFirstYear;

        //Debug.trace( MathHelper.polynomialEval( para,  nT ) );
        //Debug.trace( MathHelper.polynomialEval( para,  nF ) );

        double nDet = MathHelper.polynomialEval( para,  nT ) - MathHelper.polynomialEval( para,  nF );
        return nDet /  ( nT - nF );
    }

    public double smoothGradient( int nYearFrom, int nTo ) {
        Matrix para = this.eval_parameters( 0 );
        return this.smoothGradient( para, nYearFrom, nTo );
    }

    public double maxGradient( Matrix deri ) {
        double nMax = MathHelper.polynomialEval( deri,  0 );

        for ( int i = 1; i < deri.getArray().length; i++ ) {
            nMax = Math.max( nMax, MathHelper.polynomialEval( deri,  i ) );
        }

        return nMax;
    }

    public double maxGradient( int nTo ) {
        return this.maxGradient( this.eval_parameter_derivative( nTo ) );
    }

    public double minGradient( Matrix deri ) {
        double nMin = MathHelper.polynomialEval( deri,  0 );

        for ( int i = 1; i < deri.getArray().length; i++ ) {
            nMin = Math.min( nMin, MathHelper.polynomialEval( deri,  i ) );
        }

        return nMin;
    }

    public double minGradient( int nTo ) {
        return this.minGradient( this.eval_parameter_derivative( nTo ) );
    }



    public double predict_at ( Matrix para, int year ) {
        return MathHelper.polynomialEval( para,  year );
    }

    public double predict_at ( int year ) {
        return this.predict_at( this.eval_parameters( 0 ), year );
    }

    public double predict_grad_at ( Matrix deri, int year ) {
        return MathHelper.polynomialEval( deri,  year );
    }

    public double predict_grad_at ( int year ) {
        return this.predict_grad_at( this.eval_parameter_derivative( 0 ), year );
    }

}
