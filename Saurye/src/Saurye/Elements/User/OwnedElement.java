package Saurye.Elements.User;

import Pinecone.Framework.Util.JSON.JSONObject;
import Pinecone.Framework.Util.RDB.MySQL.MySQLExecutor;
import Saurye.Elements.MySQLBasedElement;
import Saurye.Elements.StereotypicalElement;

public abstract class OwnedElement implements StereotypicalElement, MySQLBasedElement {
    protected UserAlchemist   mAlchemist;
    protected JSONObject      mElementProto         = null;
    protected JSONObject      mTableProto           = null;
    protected JSONObject      mAssetProto           = null;

    protected OwnedElement ( UserAlchemist alchemist ){
        this.mAlchemist     = alchemist;
        this.mElementProto  = this.mAlchemist.elementPart( this.elementName()  );
        this.mTableProto    = this.mAlchemist.tableFields( this.elementName() );
        this.mAssetProto    = this.mAlchemist.assetFields( this.elementName() );
    }

    protected OwnedElement ( OwnedElement parent ){
        this.mAlchemist     = parent.mAlchemist;
        this.mElementProto  = parent.elementProto().optJSONObject( this.elementName()  );
        this.mTableProto    = this.mAlchemist.tableFields( this.mElementProto );
        this.mAssetProto    = this.mAlchemist.assetFields( this.mElementProto );
    }



    protected String tableName( String szSimpleTable ) {
        return this.mAlchemist.tableName( szSimpleTable );
    }

    @Override
    public MySQLExecutor mysql() {
        return this.mAlchemist.getMaster().host().mysql();
    }

    public UserAlchemist owned() {
        return this.mAlchemist;
    }

    @Override
    public void javaify ( String szPrefix, Object that, JSONObject proto ){
        this.mAlchemist.getMaster().javaify( szPrefix, that, proto );
    }

    public void tableJavaify ( Object that, JSONObject proto ){
        this.mAlchemist.getMaster().tableJavaify( that, proto );
    }

    public void assetJavaify ( Object that, JSONObject proto ){
        this.mAlchemist.getMaster().assetJavaify( that, proto );
    }

    public JSONObject tables(){
        return this.mAlchemist.getMaster().tableJsonify( this );
    }

    public JSONObject elementProto() {
        return this.mElementProto;
    }

    public JSONObject tableProto() {
        return this.mTableProto;
    }

    public JSONObject assetProto() {
        return this.mTableProto;
    }

}
