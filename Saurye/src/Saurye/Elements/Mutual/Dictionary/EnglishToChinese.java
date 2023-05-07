package Saurye.Elements.Mutual.Dictionary;

import Pinecone.Framework.Util.JSON.JSONArray;
import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.Elements.EpitomeElement;
import Saurye.Elements.Mutual.EpitomeSharded;

import java.sql.SQLException;

public class EnglishToChinese extends EpitomeSharded implements EpitomeElement {
    public EnglishToChinese ( Dictionary stereotype ){
        super( stereotype );
    }

    @Override
    public String elementName() {
        return this.getClass().getSimpleName();
    }

    @Override
    public Dictionary stereotype() {
        return (Dictionary) this.mStereotype;
    }



    public JSONArray fetchCnDefine( String szWord ) throws SQLException {
        return this.mysql().fetch(
                String.format( "SELECT tCnDict.`en_word`,tCnDict.`m_property`, tCnDict.`cn_means` FROM %s AS tCnDict WHERE tCnDict.`en_word` = '%s'",
                        this.stereotype().tabEn2CnNS(), szWord
                )
        );
    }

    public JSONArray fetchCnIndexDef( String szWord ) throws SQLException {
        return this.mysql().fetch(
                String.format( "SELECT tCnDict.`m_property`, tCnDict.`cn_word` FROM %s AS tCnDict WHERE tCnDict.`en_word` = '%s'",
                        this.stereotype().tabEnCnIndexNS(), szWord
                )
        );
    }

    public JSONObject fetchCnIndexMap( String szWord ) throws SQLException {
        JSONArray  jDefs = this.fetchCnIndexDef( szWord );
        JSONObject map   = new JSONObject();
        for ( int i = 0; i < jDefs.length(); i++ ) {
            JSONObject row = jDefs.optJSONObject( i );
            String szPoS   = row.optString( "m_property" );
            if( !map.hasOwnProperty( szPoS ) ){
                map.put( szPoS, new JSONArray() );
            }
            map.optJSONArray( szPoS ).put( row.optString( "cn_word" ) );
        }

        return map;
    }


}
