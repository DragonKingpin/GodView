package Pinecone.Framework.Util.Summer;

import Pinecone.Framework.Util.Summer.prototype.JSONBasedControl;
import Pinecone.Framework.Util.Summer.prototype.Pagesion;
import Pinecone.Framework.Util.Summer.prototype.Wizard;
import Pinecone.Framework.Util.Summer.prototype.Wizardum;

import javax.servlet.ServletException;
import java.io.IOException;

public abstract class ArchWizard implements Wizard {
    protected ArchConnection         mConnection         =  null  ;
    protected ArchHostSystem         mParentSystem    =  null  ;
    protected ArchConnectDispatcher  mDispatcher      =  null  ;
    private Pagesion                 mYokedModel      =  null  ;
    private JSONBasedControl         mYokedControl    =  null  ;


    public ArchWizard ( ArchConnection session ) {
        this.mConnection = session;
        this.mDispatcher = this.mConnection.getDispatcher();
        this.mParentSystem = this.mDispatcher.getHostSystem();
    }

    @Override
    public ArchConnection getConnection() {
        return this.mConnection;
    }

    @Override
    public ArchHostSystem getHostSystem() {
        return this.mParentSystem;
    }

    @Override
    public ArchConnectDispatcher getDispatcher(){
        return this.mDispatcher;
    }



    public void soulBound(Pagesion model, JSONBasedControl control ){
        this.mYokedModel   = model;
        this.mYokedControl = control;
    }

    public Pagesion revealYokedModel(){
        return this.mYokedModel;
    }

    public JSONBasedControl revealYokedControl(){
        return this.mYokedControl;
    }



    public void beforeSummon() {
    }

    public void summoning() throws ServletException, IOException {
        try{
            if( this.mYokedControl != null ){
                this.mYokedControl.beforeDispatch();
                this.mYokedControl.dispatch();
                this.mYokedControl.afterDispatch();
            }

            if( this.mYokedModel != null ){
                this.mYokedModel.beforeDispatch();
                this.mYokedModel.dispatch();
                this.mYokedModel.render();
                this.mYokedModel.afterDispatch();
            }

        }
        catch ( TerminateSessionException e ){
            System.out.println( "Wizard: One of caught session or sequence has been terminated." );
        }
    }

    public void afterSummon() {}
}
