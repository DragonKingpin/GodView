package Saurye.Elements.User.Pamphlet.Sentence;

import Saurye.Elements.User.Pamphlet.Pamphlet;

public class Sentence extends Pamphlet {
    protected String mTabEnSentences        = "";
    protected String mTabEnSentWords        = "";

    public Sentence( Pamphlet parent ) {
        super( parent );
        this.tableJavaify( this, this.mTableProto );
        this.assetJavaify( this, this.mAssetProto );
    }

    @Override
    public String elementName() {
        return this.getClass().getSimpleName();
    }


    public String tabEnSentences     (){ return this.mTabEnSentences; }
    public String tabEnSentWords     (){ return this.mTabEnSentWords; }

    public String tabEnSentencesNS   (){ return this.tableName( this.mTabEnSentences ); }
    public String tabEnSentWordsNS   (){ return this.tableName( this.mTabEnSentWords ); }




    /** Asset **/
    protected String               mAstCoverSrc    = "";

    public String                  astCoverSrc       (){ return this.mAstCoverSrc; }

}