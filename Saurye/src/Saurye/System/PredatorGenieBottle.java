package Saurye.System;

import Pinecone.Framework.System.Functions.FunctionTraits;
import Pinecone.Framework.System.Prototype.Prototype;
import Pinecone.Framework.Util.Summer.*;
import Pinecone.Framework.Util.Summer.prototype.GenieBottle;
import Pinecone.Framework.Util.Summer.prototype.JSONBasedControl;
import Pinecone.Framework.Util.Summer.prototype.Pagesion;
import Pinecone.Framework.Util.Summer.prototype.ModelEnchanter;
import Saurye.System.Prototype.JasperModifier;

import javax.servlet.ServletException;
import java.io.IOException;
import java.lang.annotation.Annotation;
import java.lang.reflect.Method;

public abstract class PredatorGenieBottle extends PredatorArchWizardum implements GenieBottle {
    protected Method mfnCurrentModelGenie = null;

    public PredatorGenieBottle ( ArchConnection session ) {
        super( session );
    }

    @Override
    public void dispatch() throws IOException, ServletException {
        try {
            this.beforeGenieInvoke();
        }
        catch ( TerminateSessionException e1 ){
            throw e1;
        }
        catch ( Exception allExp ){
            this.handleException( allExp );
        }

        try{
            if( this instanceof Pagesion){
                String szModelCommand = this.getModelCommand();
                this.summonNormalGenieByCallHisName( szModelCommand );
                this.setRenderum( Prototype.getMethod( this, szModelCommand ) );
            }
            else if( this instanceof JSONBasedControl){
                this.summonNormalGenieByCallHisName( this.getControlCommand() );
            }
        }
        catch ( NaughtyGenieInvokedException e ){
            if( e.getType() == NaughtyGenieInvokedException.NaughtyGenieType.N_HETEROGENEOUS ){
                if( e.getCause() != null && e.getCause().getCause() != null ){
                    this.handleException( (Exception)e.getCause().getCause() );
                    this.stop();
                }
            }


            try{
                this.defaultGenie();
                this.setRenderum( Prototype.getMethod( this, "defaultGenie" ) );
            }
            catch ( TerminateSessionException e1 ){
                throw e1;
            }
            catch ( Exception allExp ){
                this.handleException( allExp );
            }

        }

        try {
            this.afterGenieInvoked();
        }
        catch ( TerminateSessionException e1 ){
            throw e1;
        }
        catch ( Exception allExp ){
            this.handleException( allExp );
        }
    }

    @Override
    public void defaultGenie() throws Exception {

    }

    @Override
    public void beforeGenieInvoke() throws Exception {

    }

    @Override
    public void afterGenieInvoked() throws Exception {

    }



    /** JasperTraitExpresser **/
    protected Occupation prospectGlobalOccupation() {
        if( this.mbGlobalEnchanter && !this.mbGlobalJSPDominant ){
            return Occupation.W_ENCHANTER;
        }
        else if( this.mbGlobalJSPDominant ){
            return Occupation.W_JSP_MODIFIER;
        }
        return Occupation.W_FREE;
    }

    private Occupation prospectGenieOccupation( String szGenieName ) {
        Occupation wizardOccupation = Occupation.W_FREE;

        if( szGenieName != null && !szGenieName.isEmpty() ){
            try {
                Method method = this.getClass().getMethod(szGenieName);
                wizardOccupation = this.prospectGenieOccupation( method );
            }
            catch ( NoSuchMethodException e ){
                e.printStackTrace();
                this.stop();
            }
        }

        return wizardOccupation;
    }

    private Occupation prospectGenieOccupation( Method fnGenie ) {
        Occupation wizardOccupation = Occupation.W_FREE;

        if( fnGenie != null ){
            Annotation[] annotations = fnGenie.getAnnotations();
            boolean bFertilizerValue = false;
            boolean bEnchanterValue  = false;
            boolean bFertilizerFound = false;
            boolean bEnchanterFound  = false;
            for( Annotation a : annotations ){
                if( a instanceof JasperModifier){
                    bFertilizerFound = true;
                    bFertilizerValue = ((JasperModifier)a).value();
                }
                else if( a instanceof ModelEnchanter){
                    bEnchanterFound  = true;
                    bEnchanterValue  = ((ModelEnchanter)a).value();
                }
            }

            if( bFertilizerValue ){
                wizardOccupation = Occupation.W_JSP_MODIFIER;
            }
            else if( bEnchanterValue ){
                wizardOccupation = Occupation.W_ENCHANTER;
            }

            if ( wizardOccupation == Occupation.W_FREE && (bEnchanterFound || bFertilizerFound) ){
                wizardOccupation = Occupation.W_FORCE_FREE;
            }
        }

        return wizardOccupation;
    }

    @Override
    public void setRenderum( Method fnRenderum ) {
        this.mfnCurrentModelGenie = fnRenderum;
    }

    @Override
    public void render() throws ServletException, IOException {
        if( this instanceof Pagesion ){
            Occupation finalOccupation = this.prospectGenieOccupation( this.mfnCurrentModelGenie );
            if( finalOccupation == Occupation.W_FREE ){
                finalOccupation = this.prospectGlobalOccupation();
            }
            switch ( finalOccupation ){
                case W_ENCHANTER:{
                    this.writer().print( ((Pagesion)this).toJSONString() );
                    break;
                }
                case W_JSP_MODIFIER:{
                    this.fertilizedHF();
                    break;
                }
                case W_FORCE_FREE:
                default:{
                    break;
                }
            }

            this.mfnCurrentModelGenie = null;
        }
    }

    public boolean isThisGenie() {
       return this.getSystemDispatcher().getModelCommand().equals( FunctionTraits.thatName(3) );
    }
}
