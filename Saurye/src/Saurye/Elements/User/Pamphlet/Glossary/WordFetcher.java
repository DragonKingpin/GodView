package Saurye.Elements.User.Pamphlet.Glossary;

import Saurye.Elements.EpitomeElement;
import Saurye.Elements.User.EpitomeSharded;

public class WordFetcher extends EpitomeSharded implements EpitomeElement {
    public WordFetcher( Glossary stereotype ){
        super( stereotype );
    }

    @Override
    public String elementName() {
        return this.getClass().getSimpleName();
    }

    @Override
    public Glossary stereotype() {
        return (Glossary) this.mStereotype;
    }



    public BasicWordList basicWordList () {
        return new BasicWordList( this.stereotype() );
    }

    public BasicWordList basicWordList ( String sqlInnerIndex ){
        return this.basicWordList().apply( sqlInnerIndex );
    }

    public BasicWordList basicWordList ( String sqlInnerIndex, String sqlOuterCondition ) {
        return this.basicWordList().apply( sqlInnerIndex, sqlOuterCondition );
    }

    public BasicWordList basicWordList ( String sqlInnerIndex, String sqlInnerCondition, String sqlOuterCondition ) {
        return this.basicWordList().apply( sqlInnerIndex, sqlInnerCondition, sqlOuterCondition );
    }

    public String getUserWordInnerSQL( String szClassId ) {
        return this.getUserWordInnerSQL( "tUIdx.*", szClassId );
    }

    public String getUserWordInnerSQL( String szColumn, String szClassId ) {
        return String.format( "SELECT %s FROM %s AS tUIdx WHERE tUIdx.`classid` = '%s' %%s",
                szColumn, master().user().glossary().tabWordsNS(), szClassId
        );
    }

}
