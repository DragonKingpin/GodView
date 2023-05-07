package Saurye.Elements.Mutual.Slang;

import Pinecone.Framework.Util.JSON.JSONArray;

import Saurye.Elements.StereotypicalElement;
import Saurye.Elements.Mutual.MutualAlchemist;
import Saurye.Elements.Mutual.OwnedElement;

import java.sql.SQLException;

public class Slang extends OwnedElement implements StereotypicalElement {
    protected String mTabSlangs                = "";
    protected String mTabDefs                  = "";
    protected String mTabEgSent                = "";

    public Slang ( MutualAlchemist alchemist ){
        super( alchemist );
        this.tableJavaify( this, this.mTableProto );
    }

    @Override
    public String elementName() {
        return this.getClass().getSimpleName();
    }


    public String tabSlangs(){
        return this.mTabSlangs;
    }
    public String tabDefs(){
        return this.mTabDefs ;
    }
    public String tabEgSents(){
        return this.mTabEgSent ;
    }

    public String tabSlangsNS(){
        return this.tableName( this.mTabSlangs );
    }
    public String tabDefsNS(){
        return this.tableName( this.mTabDefs );
    }
    public String tabEgSentNS(){
        return this.tableName( this.mTabEgSent );
    }




    public JSONArray fetchSlangDefs ( String szSlang ) throws SQLException {
        return this.mysql().fetch(
                String.format( " SELECT  tDef.`en_slang`, tDef.`s_source`, tDef.`classid`, tDef.`com_def`, tDef.`c_author`, tDef.`c_date` FROM " +
                                "%s AS tDef WHERE tDef.`en_slang` = '%s'",
                        this.tabDefsNS(), szSlang
                )
        );
    }

    public JSONArray fetchSlangDefEgSentences ( String szSlang ) throws SQLException {
        return this.mysql().fetch(
                String.format( " SELECT  tSent.`en_slang`, tSent.`classid`, tSent.`eg_sentence` FROM %s AS tSent WHERE tSent.`en_slang` = '%s'",
                        this.tabEgSentNS(), szSlang
                )
        );
    }


}
