package Saurye.System;

import Pinecone.Framework.Util.JSON.JSONObject;
import Pinecone.Framework.Util.Summer.*;

import javax.servlet.ServletException;
import java.io.IOException;

public class PredatorDispatcher extends ArchConnectDispatcher {
    protected JSONObject              mGlobalSafePublicContainer    =  null  ;
    protected JSONObject              mGlobalSafeGETContainer       =  null  ;
    protected JSONObject              mGlobalSafePOSTContainer      =  null  ;


    public PredatorDispatcher( ArchHostSystem system, RouterType routerType ){
        super( system, routerType );
    }

    public Predator predator(){
        return (Predator) this.mArchHostSystem;
    }


    public JSONObject $_GSC() {
        return this.getHttpEntityParser().requestMapJsonify( this.mConnection.$_REQUEST( true ), true );
    }

    public JSONObject $_GET  ( boolean bSafe ) {
        if( !bSafe ){
            return this.mConnection.$_GET();
        }
        return this.getHttpEntityParser().parseQueryString( this.mConnection.$_REQUEST().getQueryString(), true );
    }

    public JSONObject $_POST ( boolean bSafe ) {
        if( !bSafe ){
            return this.mConnection.$_POST();
        }
        return this.getHttpEntityParser().parseFormData( this.mConnection.$_REQUEST( true ), true );
    }




    @Override
    public void echoIndexPage() throws IOException, ServletException {
        this.mWizardSummoner.summonAndExecute( "PredatorIndex" );
    }

    @Override
    public void summonByQueryString() throws ServletException, IOException {
        switch ( this.mszWizardCommand ){
            case "index": {
                this.echoIndexPage();
                break;
            }
            default:{
                super.summonByQueryString();
                break;
            }
        }
    }

}
