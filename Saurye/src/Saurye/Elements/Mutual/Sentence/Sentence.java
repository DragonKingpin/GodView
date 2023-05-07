package Saurye.Elements.Mutual.Sentence;

import Pinecone.Framework.Util.JSON.JSONArray;
import Saurye.Elements.StereotypicalElement;
import Saurye.Elements.Mutual.MutualAlchemist;
import Saurye.Elements.Mutual.OwnedElement;

import java.sql.SQLException;

public class Sentence extends OwnedElement implements StereotypicalElement {
    protected String mTabEnBand           = "";
    protected String mTabEnDefEg          = "";
    protected String mTabWordEnEg         = "";

    public Sentence ( MutualAlchemist alchemist ){
        super( alchemist );
        this.tableJavaify( this, this.mTableProto );
    }

    @Override
    public String elementName() {
        return this.getClass().getSimpleName();
    }

    public String tabEnBand      (){ return this.mTabEnBand; }
    public String tabEnDefEg     (){ return this.mTabEnDefEg; }
    public String tabWordEnEg    (){ return this.mTabWordEnEg; }

    public String tabEnBandNS    (){ return this.tableName( this.mTabEnBand ); }
    public String tabEnDefEgNS   (){ return this.tableName( this.mTabEnDefEg ); }
    public String tabWordEnEgNS  (){ return this.tableName( this.mTabWordEnEg ); }


    public SentenceLogicTree logicTree(){
        return new SentenceLogicTree( this );
    }

    public double getMarkovProbly( String szWord, String szNextWord, String szPoS ) throws SQLException {
        String szCondition = " WHERE tMar.`en_word`='" + szWord + "'" + (
                szPoS == null ? "" : " AND mk_pos = '" + szPoS + "'"
        );
        JSONArray jMarkovMax = this.mysql().fetch(
                "SELECT MAX(id) AS nMax, MIN(id) AS nMin FROM " + this.owned().word().tabMarkovTrans1GNS() +
                        " AS tMar " + szCondition
        );

        if( !jMarkovMax.isEmpty() ){
            int nMaxId = jMarkovMax.optJSONObject( 0 ).optInt( "nMax" );
            int nMinId = jMarkovMax.optJSONObject( 0 ).optInt( "nMin" );
            int nCount = nMaxId - nMinId;

            JSONArray jNext = this.mysql().fetch(
                    "SELECT `en_word`, `id`, `next_count` FROM " + this.owned().word().tabMarkovTrans1GNS() +
                            " AS tMar " + szCondition + " AND `next_word` = '" + szNextWord + "'"
            );

            if( !jNext.isEmpty() ){
                int nId = jNext.optJSONObject(0).getInt( "id" );

                return (double) ( nMaxId - nId ) / (double) nCount;
            }

        }

        return 0;
    }

}
