package Pinecone.Framework.Util.Summer.prototype;

import Pinecone.Framework.Util.JSON.JSONObject;
import Pinecone.Framework.Util.Summer.RouterType;

import javax.servlet.ServletException;

public interface HostSystem {
    JSONObject getGlobalConfig() ;

    JSONObject getSystemConfig() ;

    JSONObject getPublicWizardConfig();

    String getControlParameter() ;

    String getWizardParameter()  ;

    String getModelParameter()   ;

    void init() throws ServletException;

    String getSystemPath();

    String getRootClassPath();



    String getWizardSummonerConfig();

    String getWizardPackageName();

    String getModelClassSuffix();

    String getControlClassSuffix();


    ConnectDispatcher handleByDispatcher(RouterType routerType );

    default ConnectDispatcher handleByDispatcher() {
        return this.handleByDispatcher( RouterType.QueryString );
    }

    RouterDispatcher getPrimeRouterDispatcher();
}
