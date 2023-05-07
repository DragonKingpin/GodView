package Saurye.Elements.User.Pamphlet;

import Saurye.Elements.StereotypicalElement;
import Saurye.Elements.User.OwnedElement;
import Saurye.Elements.User.Pamphlet.Glossary.Glossary;
import Saurye.Elements.User.Pamphlet.Sentence.SentenceFetcher;
import Saurye.Elements.User.Pamphlet.Sentence.Sentence;
import Saurye.Elements.User.UserAlchemist;

public class Pamphlet extends OwnedElement implements StereotypicalElement {
    protected String mTabPamphlets          = "";
    protected String mTabConfigs            = "";
    protected String mTabCollection         = "";

    public Pamphlet ( UserAlchemist alchemist ) {
        super( alchemist );
        this.tableJavaify( this, this.mTableProto );
        this.assetJavaify( this, this.mAssetProto );
    }

    public Pamphlet ( OwnedElement parent ){
        super( parent );
    }




    @Override
    public String elementName() {
        return this.getClass().getSimpleName();
    }


    public String tabPamphlets       (){ return this.mTabPamphlets; }
    public String tabConfigs         (){ return this.mTabConfigs; }
    public String tabCollection      (){ return this.mTabCollection; }

    public String tabPamphletsNS     (){ return this.tableName( this.mTabPamphlets  ); }
    public String tabConfigsNS       (){ return this.tableName( this.mTabConfigs ); }
    public String tabCollectionNS    (){ return this.tableName( this.mTabCollection ); }

    public String getCollectedPamphletSQLProto() {
        return String.format(
                "SELECT %%s FROM " +
                        "(  " +
                        "   SELECT * From %s AS tCol %%s " +
                        ") AS tCol LEFT JOIN %s AS tBook ON tBook.`classid` = tCol.`classid` %%s",
                this.tabCollectionNS(),
                this.tabPamphletsNS()
        );
    }




    /**Descendant Elements **/

    private Glossary        mGlossaryElement;

    private Sentence        mSentenceElement;

    public  Glossary        glossary          () {
        if( this.mGlossaryElement == null ){
            this.mGlossaryElement = new Glossary( this );
        }
        return this.mGlossaryElement;
    }

    public  Sentence        sentence          () {
        if( this.mSentenceElement == null ){
            this.mSentenceElement = new Sentence( this );
        }
        return this.mSentenceElement;
    }






    /** Asset **/
    protected PamphletFileOperator     mFileOperator      = null;

    public String                      astCoverSrc       (){ return null; }

    public PamphletFileOperator        fileOperator          () {
        if( this.mFileOperator == null ){
            this.mFileOperator = new PamphletFileOperator( this );
        }
        return this.mFileOperator;
    }

    public SentenceFetcher             sentenceFetcher       () {
        return new SentenceFetcher( this );
    }

    public PamphletStudio              studio                ( PamphletIncarnation soul ) throws ClassCastException {
        return ( new PamphletStudio( this ) ).apply( soul );
    }

}
