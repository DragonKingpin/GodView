package Saurye.Elements.User.Pamphlet;

import Pinecone.Framework.Debug.Debug;
import Pinecone.Framework.System.util.StringUtils;
import Pinecone.Framework.Util.Summer.prototype.Pagesion;
import Pinecone.Framework.Util.JSON.JSONArray;
import Pinecone.Framework.Util.JSON.JSONException;
import Pinecone.Framework.Util.JSON.JSONObject;
import Pinecone.Framework.Util.Random.SeniorRandom;
import Saurye.Elements.EpitomeElement;
import Saurye.Elements.User.EpitomeSharded;
import Saurye.Peripheral.Skill.Util.DateHelper;
import Saurye.Peripheral.Skill.Util.FileHelper;
import Saurye.Peripheral.Skill.Util.PaginateHelper;
import Saurye.System.PredatorArchWizardum;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Map;
import java.util.TreeMap;

public class PamphletStudio extends EpitomeSharded implements EpitomeElement {
    public PamphletStudio( Pamphlet stereotype ) { super(stereotype); }

    @Override
    public String elementName() {
        return this.getClass().getSimpleName();
    }

    @Override
    public Pamphlet stereotype() {
        return (Pamphlet) this.mStereotype;
    }


    private PredatorArchWizardum mSoul              ;

    private Pamphlet                 mPamphletPrototype ;

    private String                   mszCarnationType   ;

    protected String                 mszCurrentUser = "";

    private   String                 mszSingleImgUploaderName = "SingleImgUploader";

    public PamphletStudio apply ( PamphletIncarnation soul ) throws ClassCastException {
        this.mSoul              = (PredatorArchWizardum) soul;
        this.mPamphletPrototype = soul.protoIncarnated();
        this.mszCurrentUser     = this.mSoul.currentUser().username();
        this.mszCarnationType   = PamphletStudio.parseIncarnatedType( this.mPamphletPrototype );
        return this;
    }

    public JSONObject $_GSC() {
        return this.mSoul.$_GSC();
    }

    public JSONObject $_POST( boolean bSafe ) {
        return this.mSoul.$_POST( bSafe );
    }

    public JSONObject $_POST( ) {
        return this.mSoul.$_POST( );
    }

    public JSONObject pageData() {
        return this.mSoul.getPageData();
    }

    public static String parseIncarnatedType( Pamphlet that ) {
        return that.getClass().getSimpleName().toLowerCase();
    }

    public String getCurrentIncarnatedType () {
        return this.mszCarnationType;
    }



    /**Model**/
    public void exhibit         () throws SQLException {
        String szCondition = String.format(
                " WHERE `ph_type` = '%s' AND `username` = '%s'", this.getCurrentIncarnatedType(), this.mszCurrentUser
        );

        String szModelSQL = String.format(
                "SELECT %%s FROM %s AS tPam %%s",
                this.master().user().pamphlet().tabPamphletsNS()
        );

        String szName = this.$_GSC().optString("ph_name" );
        if ( !StringUtils.isEmpty( szName ) ){
            szCondition += " AND `ph_name` LIKE '" + szName +"'";
        }
        String szAuthority = this.$_GSC().optString("ph_authority" );
        if ( !StringUtils.isEmpty( szAuthority ) ){
            szCondition += " AND `ph_authority` = '" + szAuthority +"'";
        }

        //trace( szCondition );

        int nPageLimit = this.mSoul.coach().model().adjustablePaginationPreTreat(
                (Pagesion) this.mSoul, szModelSQL, szCondition, "COUNT(*)",
                this.mSoul.getModularConfig().optInt( "pamphletPageLimit" )
        );

        this.pageData().put(
                "userPamphletList", this.mysql().fetch(
                        String.format( szModelSQL,
                                "`ph_name`,`ph_create_data`,`ph_authority`,`classid`,`ph_c_usage`,`ph_img_href`,`ph_c_usage`,`g_state`",
                                szCondition + PaginateHelper.formatLimitSentence(
                                        this.pageData().optLong( this.mSoul.paginateProperty().getVarBeginNum() ), nPageLimit
                                )
                        )
                )
        );
    }

    public void pamphletDeviser () throws SQLException {
        this.mSoul.appendDefaultAttribute( this.mszSingleImgUploaderName, this.mSoul.equipmentPeddler().purchase( this.mszSingleImgUploaderName ).mount(
                new JSONArray("[{'at':'newPamphletCoverField', 'name':'ph_img_href', 'src': ' /root/root/System/img/noimg.jpg' }]")
        ) );
    }

    public void pamphletEditor  ( boolean bIsThisGenie ) throws SQLException, IOException {
        String szClassId = $_GSC().optString("class_id" );

        JSONObject data = this.mysql().fetch(
                String.format( "SELECT `classid`,`ph_name`, `username`, `ph_note`,`ph_img_href`,`ph_authority` FROM %s WHERE `classid`= '%s'"
                        ,this.master().user().pamphlet().tabPamphletsNS()
                        ,szClassId )
        ).optJSONObject(0);

        if( StringUtils.isEmpty( szClassId ) || data == null ){
            this.mSoul.redirect( this.mSoul.spawnActionQuerySpell() );
            this.mSoul.stop();
        }

        this.pageData().put( "oldPamphletProfile", data  );

        if( bIsThisGenie ){
            String szImgUrl = this.pageData().optJSONObject("oldPamphletProfile").optString("ph_img_href");
            this.mSoul.appendDefaultAttribute( this.mszSingleImgUploaderName, this.mSoul.equipmentPeddler().purchase( this.mszSingleImgUploaderName ).mount(
                    new JSONArray("[{'at':'pamphletCoverField', 'name':'ph_img_href', 'src': '"+szImgUrl+"' }]")
            ) );
        }
    }

    public void pamphletCollection() throws SQLException {
        String szCondition     = " WHERE `username` = '" + this.mszCurrentUser + "' ";
        String sqlOutCondition = "";

        String szModelSQL = this.master().user().pamphlet().getCollectedPamphletSQLProto();

        String szName = $_GSC().optString("g_word" );
        if ( !StringUtils.isEmpty( szName ) ){
            sqlOutCondition += ( sqlOutCondition.isEmpty() ? " WHERE " : " AND  " )  + " `ph_name` LIKE '" + szName + "'" ;
        }

        int nPageLimit = this.mSoul.coach().model().adjustablePaginationPreTreat(
                (Pagesion) this.mSoul, String.format( szModelSQL, "%s", szCondition , "%s" ), sqlOutCondition ,"COUNT(*)",
                this.mSoul.getModularConfig().optInt( "pamphletPageLimit" )
        );

        this.pageData().put(
                "collectedPamphletList", this.mysql().fetch(
                        String.format( szModelSQL,
                                "tBook.`ph_name`, tBook.`ph_create_data`, tBook.`username`, tBook.`classid`, tBook.`ph_c_usage`, tBook.`ph_img_href`, tBook.`ph_c_usage`",
                                szCondition + PaginateHelper.formatLimitSentence(
                                        this.pageData().optLong( this.mSoul.paginateProperty().getVarBeginNum() ), nPageLimit
                                ), sqlOutCondition
                        )
                )
        );
    }




    /**Control**/
    public String appendNewPamphlet( boolean bIsCloneMode ) throws IOException,SQLException {
        try {
            JSONObject $_SPOST       = this.$_POST( true );
            JSONObject pamphletData  = $_SPOST.subJson( new String[]{ "ph_name","ph_note","ph_authority"} );
            String szYokedErrorPage  = this.mSoul.spawnActionQuerySpell( bIsCloneMode ? "cloneGlossary" : "appendNewPamphlet" );

            if( $_SPOST.optInt("noImgFlag" ) == 1 ){
                pamphletData.put( "ph_img_href", "" );
            }
            else if ( !this.mSoul.$_FILES().get("ph_img_href").isEmpty() ) {
                try {
                    pamphletData.put("ph_img_href",
                            this.master().user().pamphlet().fileOperator().coverUploader( this.mSoul ).exertBuff("Image", "ph_img_href",szYokedErrorPage )
                    );
                }
                catch ( Exception e ) {
                    this.mSoul.rethrowStopSignal(e);
                }
            }



            String szClassId = new SeniorRandom().nextString(15 );
            pamphletData.put( "classid", szClassId );
            pamphletData.put( "username", this.mszCurrentUser );
            String szNewName = $_SPOST.optString("ph_name");
            pamphletData.put( "ph_create_data", DateHelper.formatYMD() );
            pamphletData.put( "ph_type",this.mszCarnationType );
            pamphletData.put( "g_state","studying" );

            if( this.mysql().countFromTable(
                    String.format(
                            "SELECT COUNT(*) FROM %s WHERE `ph_type` = '%s' AND `username` = '%s' AND `ph_name` = '%s' " ,
                            this.master().user().pamphlet().tabPamphletsNS(), this.mszCarnationType, pamphletData.optString("username"),szNewName
                    )
            ) > 0 ){
                this.mSoul.alert( "'"+ this.mszCurrentUser +"'"+"的"+"'"  + szNewName + "'已经存在", 0, szYokedErrorPage );
            }


            if( this.mysql().insertWithArray( this.master().user().pamphlet().tabPamphlets(), pamphletData.getMap() ) > 0 ){
                return szClassId;
            }
        }
        catch ( JSONException e ){
            this.mSoul.trace( e.getMessage() );
            return null;
        }
        return null;
    }

    public void editPamphlet() throws SQLException,IOException {
        JSONObject $_SPOST = this.$_POST( true );
        JSONObject pamphletData = $_SPOST.subJson(new String[]{ "classid","ph_name","ph_note","ph_authority"});
        String szYokedErrorPage = this.mSoul.spawnControlQuerySpell("editPamphlet");

        JSONObject dbGlossaryInfo = this.mysql().fetch(
                String.format( "SELECT `classid`,`ph_name`,`ph_note`,`ph_img_href`,`ph_authority`, `username` FROM %s WHERE `ph_type` = '%s' AND `classid`= '%s'"
                        ,this.master().user().pamphlet().tabPamphletsNS()
                        ,this.mszCarnationType
                        ,pamphletData.optString("classid")
                )
        ).optJSONObject( 0 );

        if( !dbGlossaryInfo.optString("username").equals(this.mszCurrentUser) ){
            this.mSoul.checkResult( false );
        }

        String szNewGlossaryName = pamphletData.optString("ph_name");

        if(!szNewGlossaryName.equals(dbGlossaryInfo.optString("ph_name"))){
            if( this.mysql().countFromTable(
                    String.format(
                            "SELECT COUNT(*) FROM %s WHERE `ph_type` = '%s' AND `username` = '%s' AND `ph_name` = '%s'" ,
                            this.master().user().pamphlet().tabPamphletsNS(), this.mszCarnationType, this.mszCurrentUser, szNewGlossaryName
                    )
            ) > 0 ){
                this.mSoul.alert( "'"+ this.mszCurrentUser +"'"+"的"+"'"  + szNewGlossaryName + "'已经存在", 0, -1 );
            }
        }

        if( !pamphletData.isEmpty() ){
            if( $_POST().optInt("noImgFlag" ) == 1 ){
                pamphletData.put( "ph_img_href", "" );
                String szOldImg = dbGlossaryInfo.optString( "ph_img_href" );

                if( !StringUtils.isEmpty( szOldImg ) ){
                    if( ! FileHelper.erase( this.mSoul, szOldImg ) ){
                        Debug.console().error( "UserIndexControl: File gone missing." );
                    }
                }
            }
        }
        if ( !this.mSoul.$_FILES().get("ph_img_href").isEmpty() ){
            try {
                pamphletData.put( "ph_img_href",
                        this.master().user().pamphlet().fileOperator().coverUploader( this.mSoul ).exertBuff("Image", "ph_img_href",szYokedErrorPage )
                );

                String szOldImg = dbGlossaryInfo.optString( "ph_img_href" );
                if( !StringUtils.isEmpty( szOldImg ) && ! FileHelper.erase( this.mSoul, szOldImg ) ){
                    Debug.console().error( "UserIndexControl: File gone missing." );
                }
            }
            catch ( Exception e ){
                this.mSoul.rethrowStopSignal( e );
            }

        }
        Map<String, String > condition = new TreeMap<>();
        condition.put( "classid",pamphletData.optString("classid") );
        condition.put( "username", this.mszCurrentUser );
        this.mSoul.checkResult(
                this.mysql().updateWithArray( this.master().user().pamphlet().tabPamphlets(), pamphletData.getMap(), condition ) > 0
        );
    }

    public boolean deleteOnePamphlet( String szClassId ) throws SQLException,IOException {
        if( szClassId == null ){
            szClassId = $_GSC().optString("classid");
        }
        String szCondition = String.format( " WHERE `classid` = '%s' AND `username` = '%s'",
                szClassId , this.mszCurrentUser
        );

        JSONArray old = this.mysql().fetch (
                "SELECT `ph_img_href` FROM " + this.master().user().pamphlet().tabPamphletsNS() + szCondition
        );
        if( old.isEmpty() ){
            return false;
        }
        if( ! FileHelper.erase( this.mSoul, old.optJSONObject(0 ).optString( "ph_img_href" ) ) ){
            Debug.console().error( "UserIndexControl: File gone missing." );
        }
        return this.mysql().deleteWithSQL( this.master().user().pamphlet().tabPamphlets(), szCondition ) > 0; // Using trigger
    }

}