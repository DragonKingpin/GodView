package Saurye.Elements.Mutual.Etymology;

import Pinecone.Framework.Util.JSON.JSONArray;
import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.Elements.StereotypicalElement;
import Saurye.Elements.Mutual.MutualAlchemist;
import Saurye.Elements.Mutual.OwnedElement;

import java.sql.SQLException;

public class Etymology extends OwnedElement implements StereotypicalElement {
    protected String mTabDefs                 = "";
    protected String mTabCnPoS                = "";
    protected String mTabEnPoS                = "";
    protected String mTabRelevance            = "";
    protected String mTabLinguae              = "";

    protected String mTabFEpitome             = "";
    protected String mTabFClans               = "";
    protected String mTabFFrag                = "";

    public Etymology ( MutualAlchemist alchemist ){
        super( alchemist );
        this.tableJavaify( this, this.mTableProto );
    }

    @Override
    public String elementName() {
        return this.getClass().getSimpleName();
    }

    public String tabDefs      (){ return this.mTabDefs; }
    public String tabCnPoS     (){ return this.mTabCnPoS; }
    public String tabEnPoS     (){ return this.mTabEnPoS; }
    public String tabRelevance (){ return this.mTabRelevance; }
    public String tabLinguae   (){ return this.mTabLinguae; }

    public String tabFEpitome  (){ return this.mTabFEpitome; }
    public String tabFClans    (){ return this.mTabFClans; }
    public String tabFFrag     (){ return this.mTabFFrag; }


    public String tabDefsNS      (){ return this.tableName( this.mTabDefs ); }
    public String tabCnPoSNS     (){ return this.tableName( this.mTabCnPoS ); }
    public String tabEnPoSNS     (){ return this.tableName( this.mTabEnPoS ); }
    public String tabRelevanceNS (){ return this.tableName( this.mTabRelevance ); }
    public String tabLinguaeNS   (){ return this.tableName( this.mTabLinguae ); }

    public String tabFEpitomeNS  (){ return this.tableName( this.mTabFEpitome ); }
    public String tabFClansNS    (){ return this.tableName( this.mTabFClans ); }
    public String tabFFragNS     (){ return this.tableName( this.mTabFFrag ); }



    public JSONArray fetchRelevantBasic( String szEnWord ) throws SQLException {
        return this.mysql().fetch(
                String.format( " SELECT  tRel.`en_word`, tRel.`ety_relevant`, tLing.`en_weight`, tLing.`e_direct_frequency`, tLing.`cn_def` FROM " +
                                " ( SELECT * FROM %s AS tRel WHERE tRel.`en_word` = '%s' ) AS tRel" +
                                " LEFT JOIN %s AS tLing ON tRel.`ety_relevant` = tLing.`en_derived` ORDER BY tLing.`id`",
                        this.tabRelevanceNS(), szEnWord,
                        this.tabLinguaeNS()
                )
        );
    }

    public JSONObject getLinguaeInfo ( String szLinguae )  throws SQLException {
        JSONArray jRaw = this.mysql().fetch( "SELECT `en_weight`, `e_direct_frequency`, `cn_def` FROM " + this.tabLinguaeNS() );
        if( !jRaw.isEmpty() ){
            return jRaw.optJSONObject( 0 );
        }
        return new JSONObject();
    }
}
