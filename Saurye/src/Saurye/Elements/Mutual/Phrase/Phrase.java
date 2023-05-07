package Saurye.Elements.Mutual.Phrase;

import Pinecone.Framework.Util.JSON.JSONArray;
import Saurye.Elements.StereotypicalElement;
import Saurye.Elements.Mutual.MutualAlchemist;
import Saurye.Elements.Mutual.OwnedElement;

import java.sql.SQLException;

public class Phrase extends OwnedElement implements StereotypicalElement {
    protected String mTabPhrases               = "";
    protected String mTabDefs                  = "";
    protected String mTabEgSent                = "";

    public Phrase ( MutualAlchemist alchemist ){
        super( alchemist );
        this.tableJavaify( this, this.mTableProto );
    }

    @Override
    public String elementName() {
        return this.getClass().getSimpleName();
    }

    public String tabPhrases          (){ return this.mTabPhrases; }
    public String tabDefs             (){ return this.mTabDefs; }
    public String tabEgSent           (){ return this.mTabEgSent; }


    public String tabPhrasesNS        (){ return this.tableName( this.mTabPhrases ); }
    public String tabDefsNS           (){ return this.tableName( this.mTabDefs ); }
    public String tabEgSentNS         (){ return this.tableName( this.mTabEgSent ); }







    public JSONArray fetchDefAndEgSentences( String szConditionSQL ) throws SQLException {
        return this.mysql().fetch(
                String.format(  "SELECT  tPhr.`en_word`, tPhr.`en_phrase`, tPhr.`ph_type`, " +
                                "        tPhrD.`ph_en_def`, tPhrD.`ph_property`, tPhrD.`ph_cn_def`, " +
                                "        tSent.`eg_sentence`, tSent.`eg_cn_def`" +
                                "FROM" +
                                "(" +
                                "   ( " +
                                "       SELECT tPhr.`en_word`, tPhr.`en_phrase`, tPhr.`ph_type` " +
                                "       FROM %s AS tPhr %s" +
                                "       GROUP BY tPhr.`en_phrase`" +
                                "   ) AS tPhr LEFT JOIN %s AS tPhrD ON tPhrD.`en_phrase` = tPhr.`en_phrase` AND tPhrD.`ph_type` = tPhr.`ph_type`" +
                                ")  LEFT JOIN %s AS tSent ON tSent.`classid` = tPhrD.`classid` ORDER BY tPhr.`ph_type` DESC",
                        this.tabPhrasesNS(),
                        szConditionSQL,
                        this.tabDefsNS(),
                        this.tabEgSentNS()
                )
        );
    }

    public JSONArray fetchDefAndEgSentencesByWord ( String szWord, String szCondition ) throws SQLException {
        return this.fetchDefAndEgSentences(
                String.format( " WHERE tPhr.`en_word` = '%s' %s ", szWord, szCondition )
        );
    }

    public JSONArray fetchDefAndEgSentencesByPhrase ( String szPhrase, String szCondition ) throws SQLException {
        return this.fetchDefAndEgSentences(
                String.format( " WHERE tPhr.`en_phrase` = '%s' %s ", szPhrase, szCondition )
        );
    }
}
