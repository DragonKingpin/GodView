package Saurye.Wizard.Public.undefined;

import Pinecone.Framework.Debug.Debug;
import Pinecone.Framework.System.Functions.*;
import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Controller;
import Pinecone.Framework.Util.Summer.prototype.Pagesion;
import Pinecone.Framework.Util.Summer.prototype.RouterMapping;
import Saurye.Peripheral.Skill.CoreCoach;
import Saurye.Peripheral.Skill.FileUploadSkill;
import Saurye.System.Prototype.JasperModifier;

import javax.servlet.ServletException;
import java.io.IOException;
import java.util.HashMap;

//@ModelEnchanter
@JasperModifier
@Controller
//@RouterMapping()
public class undefinedModel extends undefined implements Pagesion {
    public undefinedModel( ArchConnection connection ) {
        super(connection);
//        this.setPhenotypicTrait(true);

    }

    @Override
    public void beforeGenieInvoke() throws Exception {
        super.beforeGenieInvoke();
        //Debug.trace( this.alchemist().mutual().word().historyTeller().apply("test", 1800 ).getHistoryRateObj(-1 ).intervalVariance() );
    }

    public void defaultGenie() throws IOException, ServletException {
        this.mPageData.put( "debug", "default" );
        console.log("Default Call");

        Debug.trace( (new FileUploadSkill( new CoreCoach( this.system() ) )) );

        //this.fertilizedHF();
    }

    public void ha() {
        this.mPageData.put( "debug", "Ha from java" );
    }

    @RouterMapping(relative = false)
    public void fa() {
        this.mPageData.put( "debug", "fa from java" );
    }

    @RouterMapping( { "/magic", "/ss" } )
    public void magic() throws Exception {
        String szMagic = this.$_GSC().optString( FunctionTraits.thisName() );

        ( new ChosenDispatcher( new HashMap<String, Executable >(){
            {
                put( "fn1", (Executor)()->{
                    mPageData.put( "debug", "this is fn1 from magic" );
                } );
                put( "fn2", (Function)( Object...args )->{
                    mPageData.put( "debug", "this is fn2 from magic" );
                    return null;
                } );
                put( "default", (Function)( Object...args )->{
                    mPageData.put( "debug", "this is default from magic" );
                    return null;
                } );
            }
        } )).dispatch( szMagic );
    }

}
