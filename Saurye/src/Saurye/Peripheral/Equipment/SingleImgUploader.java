package Saurye.Peripheral.Equipment;

import Pinecone.Framework.Util.JSON.JSONArray;
import Pinecone.Framework.Util.JSON.JSONException;
import Pinecone.Framework.Util.JSON.JSONObject;

import java.io.IOException;
import java.util.Map;

public class SingleImgUploader implements UIEquipment {
    private UIEquipmentPeddler mPeddler;

    private String mszRenderedCache;

    private JSONObject mAdditions;

    public SingleImgUploader( UIEquipmentPeddler peddler ){
        this.mPeddler = peddler;
        try {
            this.mszRenderedCache = this.mPeddler.host().readFileContentAll( this.getUITemplatePath() );
            this.mAdditions = this.mPeddler.getPrivateConfig().optJSONObject( this.prototypeName() );
            if( !this.mAdditions.hasOwnProperty( "fileMaxSize" ) ){
                this.mAdditions.put( "fileMaxSize", this.mPeddler.host().getPredatorUploadConfig().get( "PublicFileUpSize" ) );
            }
            if( !this.mAdditions.hasOwnProperty( "imgMaxSize" ) ){
                this.mAdditions.put( "imgMaxSize", this.mPeddler.host().getPredatorUploadConfig().get( "PublicImgUpSize" ) );
            }
        }
        catch ( IOException | JSONException e ){
            e.printStackTrace();
        }
    }

    public String getUITemplatePath (){
        return this.mPeddler.getTemplatePath() + this.prototypeName() + this.mPeddler.tplFileTypeName();
    }

    @Override
    public EquipmentPeddler.Type type() {
        return EquipmentPeddler.Type.T_UI;
    }

    @Override
    public String prototypeName(){
        return this.getClass().getSimpleName();
    }

    @Override
    public JSONObject property() {
        return this.mAdditions;
    }

    @Override
    public UIEquipment enchant( JSONObject additions ) {
        for( Object row : additions.entrySet() ){
            Map.Entry addition = (Map.Entry) row;
            this.enchant( (String) addition.getKey(), addition.getValue() );
        }
        return this;
    }

    @Override
    public UIEquipment enchant( String key, Object val ) {
        this.mAdditions.put( key, val );
        return this;
    }

    @Override
    public String synthesis() {
        return this.mszRenderedCache;
    }

    @Override
    public String mount( Object ats ){
        StringBuilder szImgUploadStream = new StringBuilder();
        if( ats instanceof JSONArray ){
            JSONArray eachs = (JSONArray) ats;

            for( int i = 0; i < eachs.length(); ++i ){
                JSONObject row = eachs.optJSONObject(i);
                String szAt   = row.optString( "at" );
                String szName = row.optString( "name" );
                long nAllowSize = this.mAdditions.optLong( "imgMaxSize" );
                if( row.hasOwnProperty( "maxSize" ) ){
                    nAllowSize = row.optLong( "maxSize" );
                }
                String szSrc = this.mAdditions.optString( "defaultImgSrc" );
                if( row.hasOwnProperty( "src" ) ) {
                    szSrc = row.optString( "src" );
                }

                szImgUploadStream.append( " Saurye.equipment.ui.SingleImgUploader.mount(\"").
                        append(szAt).append("\",\"").append( szName ).append("\",").append(nAllowSize).append(",\"").append(szSrc).append("\");");
            }
        }
        return this.synthesis() + szImgUploadStream.toString() + "</script>";
    }

}
