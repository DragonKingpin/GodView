package Saurye.System;

import Pinecone.Framework.System.IO.Console;
import Pinecone.Framework.Debug.Debug;
import Pinecone.Framework.System.Prototype.Prototype;
import Pinecone.Framework.System.util.StringUtils;
import Pinecone.Framework.Util.Summer.http.HttpURLParser;
import Pinecone.Framework.Util.JSON.JSONArray;
import Pinecone.Framework.Util.JSON.JSONObject;
import Pinecone.Framework.Util.Summer.*;
import Pinecone.Framework.Util.Summer.MultipartFile.MultipartFile;
import Pinecone.Framework.Util.Summer.http.HttpMethod;
import Pinecone.Framework.Util.Summer.prototype.Pagesion;
import Pinecone.Framework.Util.Summer.prototype.Wizard;
import Pinecone.Framework.Util.RDB.MySQL.MySQLExecutor;
import Pinecone.Pinecone;
import Saurye.Elements.AlchemistMaster;
import Saurye.Peripheral.Equipment.EquipmentPeddler;
import Saurye.Peripheral.Equipment.UIEquipmentPeddler;
import Saurye.System.Auxiliary.QuerySpell;
import Saurye.System.Infrastructure.JasperFrame;
import Saurye.System.Properties.Paginate;
import Saurye.System.Properties.Properties;
import Saurye.System.Prototype.JasperModifier;
import Saurye.System.Prototype.JasperTraitExpresser;
import Saurye.Peripheral.Skill.CoreCoach;
import Saurye.System.Authority.UserCertifier;

import javax.servlet.ServletException;
import java.io.IOException;
import java.lang.annotation.Annotation;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.Map;

/**
 * Like Javascript it is prototype chain.
 * system Mirror Class. (All frequently-used method and function can be clone. )
 * Extending this class will allow you invoke such $_GET, $_GPC, $_POST anywhere like PHP.
 */

public abstract class PredatorArchWizardum extends PredatorArchWizard implements JasperTraitExpresser {
    protected enum Occupation {
        W_FREE, W_FORCE_FREE, W_ENCHANTER, W_JSP_MODIFIER
    }

    protected JasperFrame             mJasperFrame                  =  null  ;
    protected EquipmentPeddler        mUIEquipmentPeddler           =  null  ;
    protected WizardGeniesInvoker     mWizardGeniesInvoker          =  null  ;
    protected boolean                 mbGlobalJSPDominant           =  false ;
    private UserCertifier             mUserCertifier                =  null  ;
    private QuerySpell                mQuerySpell                   =  null  ;



    /** Base **/
    @Override
    protected void appendDefaultPageDate(){
        super.appendDefaultPageDate();
        this.$_REQUEST().setAttribute( "Prototype", this );
    }

    public PredatorArchWizardum( ArchConnection session ) {
        super( session );
        if( this instanceof Pagesion ){
            this.mbGlobalJSPDominant = this.isDefaultJSPModifier();
        }
        this.mJasperFrame          = new JasperFrame( this );
        this.mUIEquipmentPeddler   = new UIEquipmentPeddler( this );
        this.mWizardGeniesInvoker  = new WizardGeniesInvoker( this, this.system() );
        this.mUserCertifier        = new UserCertifier( this );
    }

    public void summoning() throws ServletException, IOException {
        if( this.currentUser().privilegeQualified() != UserCertifier.DisqualifiedType.DT_MATCHED ){
            try {
                String szQueryString = this.$_REQUEST().getQueryString();
                String szReferHref   = StringUtils.isEmpty(szQueryString) ? "" : "&referHref=" + HttpURLParser.encode( "?" + szQueryString );
                this.redirect( this.querySpell().gotoLogin() + szReferHref );
                return;
            }
            catch ( Exception e ) {
                this.handleException( e );
            }
        }

        super.summoning();
    }



    @Override
    public PredatorDispatcher getSystemDispatcher() {
        return (PredatorDispatcher) this.mDispatcher;
    }

    public JSONObject $_GSC() {
        return this.getSystemDispatcher().$_GSC();
    }

    public JSONObject $_GET  ( boolean bSafe ) {
        return this.getSystemDispatcher().$_GET( bSafe );
    }

    public JSONObject $_POST ( boolean bSafe ) {
        return this.getSystemDispatcher().$_POST( bSafe );
    }

    public HttpMethod currentHttpMethod(){
        return this.getConnection().currentHttpMethod();
    }

    public Map<String, MultipartFile> $_FILES() {
        return this.getConnection().$_FILES();
    }

    public boolean isDebugMode() {
        return this.system().getHostSystemConfig().optBoolean( "DebugMode" );
    }



    /** Template **/
    public JasperFrame getJasperFrame(){
        return this.mJasperFrame;
    }

    public EquipmentPeddler equipmentPeddler(){
        return this.mUIEquipmentPeddler;
    }

    public CoreCoach coach() {
        return this.system().coach();
    }

    public AlchemistMaster alchemist() {
        return this.system().alchemist();
    }

    public UserCertifier currentUser() {
        return this.mUserCertifier;
    }



    /** RDB & System Basic Getter **/
    protected MySQLExecutor mysql(){
        return this.system().mysql();
    }

    protected String tableName( String szShortTableName ) {
        return this.mysql().tableName( szShortTableName );
    }

    protected String assembleSimpleStackInfo ( StackTraceElement[] stackTraceElements, boolean bOnlySite ){
        StringBuilder s = new StringBuilder();
        String szSiteName = this.system().getSitesConfig().optString("name");
        for ( StackTraceElement ele: stackTraceElements ) {
            String szClassName = ele.getClassName();
            if( (!bOnlySite && szClassName.contains( "Pinecone" )) || szClassName.contains( szSiteName ) ){
                s.append("   ").append(szClassName).append(".").append(ele.getMethodName()).append("(").append(ele.getFileName()).append(":").append(ele.getLineNumber()).append(") \n");
            }
        }
        return s.toString();
    }

    public    void handleSQLException( SQLException e ) {
        try {
            this.mDispatcher.traceSystem500Error(
                    String.format(
                            "<h3>Caught SQLException During Runtime: </h3>" +
                            "<h3>What: %s</h3>"+
                            "<p>Contact: %s</p>",
                            this.isDebugMode() ? e.getMessage() : "Query Compromised.", Pinecone.CONTACT_INFO
                    )
            );
            System.err.println(
                    String.format(
                            "****************** SQLException Caught ******************\n" +
                                    "ERROR SQL: %s\n" +
                                    "     What: %s\n" +
                                    "SQL State: (%s , %d)\n"+
                                    "       At: %s\n" +
                            "*********************************************************\n",
                            this.mysql().getLastSQLSentence(),
                            e.getMessage(),
                            e.getSQLState(), e.getErrorCode(),
                            this.assembleSimpleStackInfo( e.getStackTrace(), false )
                    )
            );
        }
        catch (ServletException|IOException e1){
            e1.printStackTrace();
        }
    }

    public    void handleException( Exception e ) {
        if( e instanceof TerminateSessionException ){
            throw (TerminateSessionException) e;
        }
        else if( e instanceof SQLException ){
            this.handleSQLException( (SQLException)e );
            return;
        }

        try{
            this.mDispatcher.traceSystem500Error( Prototype.prototypeName(e) + ":" + e.getMessage() );
            e.printStackTrace();
        }
        catch (ServletException|IOException e1){
            e1.printStackTrace();
        }
    }

    public    void rethrowStopSignal( Exception e ) {
        if( e instanceof TerminateSessionException ){
            throw (TerminateSessionException) e;
        }
        else if( e.getCause() instanceof TerminateSessionException ){
            throw (TerminateSessionException) e.getCause();
        }
        throw new IllegalStateException( "Reinterpret throw new instance to terminate it in an unusual way.", e );
    }

    public    Properties properties() {
        return this.system().properties();
    }

    public    Paginate   paginateProperty() {
        return this.properties().paginate();
    }


    public void appendDefaultAttribute(String key, Object value){
        this.$_REQUEST().setAttribute( key,value );
    }



    /** Render **/
    public String fertilizedHF() throws ServletException, IOException {
        this.appendDefaultAttribute( "StaticHead", this.mJasperFrame.includeStaticHead( (Wizard) this ) );
        this.appendDefaultAttribute( "StaticFooter", this.mJasperFrame.includeFooter() );
        this.appendDefaultAttribute( "szPageData",this.mPageData.toString() );
        this.appendDefaultAttribute( "StaticPageEnd","</body></html>" );
        return this.jspTPLRender(this.prototypeName());
    }

    public String jspTPLRender() throws ServletException, IOException {
        return this.jspTPLRender(this.prototypeName());
    }

    public String jspTPLRender( String szJSPSimpleName ) throws ServletException, IOException {
        String szJSPFileName = ( (Wizard) this).getModularRole() + "/" + szJSPSimpleName + ".jsp";
        this.mDispatcher.jspTPLRenderPage( szJSPFileName );
        return szJSPFileName;
    }



    /** Redirect And Helper **/
    protected void smartRedirectWithModelParameter( String szWizardName, String szFunModelName ) throws IOException {
        String szParameter = this.system().getModelParameter() + "=" + szFunModelName;
        this.smartRedirect( szWizardName, szParameter );
    }

    protected void smartRedirect( String szWizardName, String szParameter ) throws IOException {
        String szRealURL = "?" + this.system().getWizardParameter() + "=" + szWizardName;
        if( szParameter != null && !szParameter.isEmpty() ){
            szRealURL += "&" + szParameter;
        }
        this.redirect( szRealURL );
    }

    protected void smartRedirect( String szWizardName ) throws IOException {
        this.smartRedirect( szWizardName, null );
    }

    public    void alert( String szTitle, int nState, Object url ) throws IOException {
        this.redirect(
                String.format( "?%s=%s&title=%s&state=%d&url=%s",
                        this.system().getWizardParameter(),
                        this.system().getHostSystemConfig().getString("AlertPage"),
                        URLEncoder.encode( szTitle, this.system().getServerCharset() ), nState,
                        URLEncoder.encode( url.toString(), this.system().getServerCharset() )
                )
        );
        this.stop();
    }

    public    void checkResult( boolean bResult, String szTitle, Object url ) throws IOException {
        JSONObject proto = this.getWizardProto(this.system().getHostSystemConfig().getString("AlertPage"));

        if( bResult ){
            if( szTitle == null ) {
                szTitle = proto.optString("defaultSuccessTitle");
            }
            this.alert( szTitle, 1 , url );
        }
        else {
            if( szTitle == null ) {
                szTitle = proto.optString("defaultFailTitle");
            }
            this.alert( szTitle, 0, url );
        }
    }

    public    void checkResult( boolean bResult, String szTitle ) throws IOException {
        this.checkResult( bResult, szTitle, -1 );
    }

    public    void checkResult( boolean bResult ) throws IOException {
        this.checkResult( bResult, null, -1 );
    }

    protected String assertString( String s ) throws IOException, ServletException {
        if( StringUtils.isEmpty( s )  ){
            this.getSystemDispatcher().traceSystem500Error(
                    "<h3>Wizard was summoned with unexpected state.</h3>" +
                            "<h3>Please contact administrator[" + Pinecone.CONTACT_INFO + "] for more information.</h3>"
            );
            this.stop();
        }
        return s;
    }

    protected JSONArray assertSelectResult( JSONArray object ) throws IOException, ServletException {
        if( object == null || object.isEmpty() ){
            this.getSystemDispatcher().traceSystem500Error(
                    "<h3>Wizard was summoned with unexpected state.</h3>" +
                            "<h3>Please contact administrator[" + Pinecone.CONTACT_INFO + "] for more information.</h3>"
            );
            this.stop();
        }
        return object;
    }



    /** QuerySpell **/
    public String spawnWizardActionSpell ( String szPrototype, String szActionFnName ){
        String szQueryString = "?" + this.system().getWizardParameter() + "=" + szPrototype;
        if( szActionFnName != null && !szActionFnName.isEmpty() ){
            return szQueryString + "&" + this.system().getModelParameter() + "=" + szActionFnName;
        }
        return szQueryString;
    }

    public String spawnWizardControlSpell ( String szPrototype, String szControlFnName ){
        String szQueryString = "?" + this.system().getWizardParameter() + "=" + szPrototype;
        if( szControlFnName != null && !szControlFnName.isEmpty() ){
            return szQueryString + "&" + this.system().getControlParameter() + "=" + szControlFnName;
        }
        return szQueryString;
    }

    public String spawnActionQuerySpell(){
        return this.spawnActionQuerySpell( null );
    }

    public String spawnControlQuerySpell(){
        return this.spawnControlQuerySpell( null );
    }

    public QuerySpell querySpell(){
        if( this.mQuerySpell == null ){
            this.mQuerySpell = new QuerySpell( this );
        }
        return this.mQuerySpell;
    }



    /** JasperTraitExpresser **/
    public Object summonNormalGenieByCallHisName( String szGenieName ) throws NaughtyGenieInvokedException {
        return this.mWizardGeniesInvoker.invokeNormalGenieByCallHisName( szGenieName );
    }

    public void setPhenotypicTrait( boolean bDominant ) {
        this.mbGlobalJSPDominant = bDominant;
    }

    public boolean isJasperDominant() {
        return this.mbGlobalJSPDominant;
    }

    public boolean isDefaultJSPModifier() {
        Annotation[] annotations = this.getClass().getAnnotations();
        for( Annotation annotation : annotations ){
            if( annotation instanceof JasperModifier){
                return ((JasperModifier) annotation).value();
            }
        }
        return false;
    }



    /** Trace **/
    protected Console console = Debug.console();

    public Console trace( Object data, Object ...more ) {
        return Debug.trace( data, more );
    }
}
