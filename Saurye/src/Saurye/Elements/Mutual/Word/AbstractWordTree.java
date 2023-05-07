package Saurye.Elements.Mutual.Word;

import Pinecone.Framework.Util.JSON.JSONArray;
import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.Elements.Mutual.EpitomeSharded;

public abstract class AbstractWordTree extends EpitomeSharded {
    public AbstractWordTree(Word stereotype ){
        super( stereotype );
    }

    protected JSONObject applyNode(JSONObject that, String szId, String szName, JSONArray children ) {
        that.put( "id",   szId   );
        that.put( "name", szName );
        that.put( "children", children );
        return that;
    }

    protected JSONObject applyNode( JSONObject that, String szId, String szName ) {
        return this.applyNode( that, szId, szName, new JSONArray() );
    }

    protected JSONObject spawnNode( String szId, String szName, JSONArray children ) {
        JSONObject that = new JSONObject();
        return this.applyNode( that, szId, szName, children );
    }

    protected JSONObject spawnNode( String szId, String szName ) {
        JSONObject that = new JSONObject();
        return this.applyNode( that, szId, szName );
    }

    protected JSONObject spawnKVNode( String szId, String szKey, Object val ) {
        JSONObject that = new JSONObject();
        if( val instanceof JSONArray ){
            return this.applyNode( that, szId, szKey, (JSONArray) val );
        }
        JSONArray jPart = new JSONArray();
        jPart.put( this.spawnNode( this.idMaker( szId, 0 ), val.toString() ) );
        return this.applyNode( that, szId, szKey, jPart );
    }

    protected String idMaker( String szUpperId, int i ){
        return szUpperId + "_" + i;
    }
}
