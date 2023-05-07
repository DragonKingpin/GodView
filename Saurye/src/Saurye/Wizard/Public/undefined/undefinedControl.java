package Saurye.Wizard.Public.undefined;

import Pinecone.Framework.Debug.Debug;
import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.JSONBasedControl;
import Pinecone.Framework.Util.Summer.MultipartFile.MultipartException;
import Pinecone.Framework.Util.Summer.MultipartFile.MultipartFile;

import java.util.Map;

public class undefinedControl extends undefined implements JSONBasedControl {
    public undefinedControl( ArchConnection connection  ){
        super(connection);
    }


    public void defaultGenie() throws Exception {

//        CommonsFileUploadDispatcher commonsFileUploadDispathcher = new CommonsFileUploadDispatcher( this.parent() );
//        CommonsMultipartResolver commonsMultipartResolver = commonsFileUploadDispathcher.getMultipartResolver();
        try{
            Map<String, MultipartFile > mR = this.$_FILES();
            Debug.trace( mR );
            //Debug.trace( ((CommonsMultipartFile)mR.getFile("fileA")).getStoragePath() );

            console.log ( this.$_GET  (true) );
            console.log ( this.$_POST (true) );
            console.log ( this.$_GSC  () );


        }
        catch ( MultipartException e ){
            e.printStackTrace();
        }


        Debug.trace( this.currentHttpMethod() );
        Debug.trace( this.$_POST(true) );
    }

    public void shit(){
        Debug.trace("Control Shit");
    }
}
