package Saurye.Elements.User.Fragment;

import Saurye.Elements.StereotypicalElement;
import Saurye.Elements.User.OwnedElement;
import Saurye.Elements.User.UserAlchemist;

public class Fragment extends OwnedElement implements StereotypicalElement {
    protected String mTabGlossary           = "";
    protected String mTabRoots              = "";
    protected String mTabCollection         = "";

    public Fragment(UserAlchemist alchemist ) {
        super( alchemist );
        this.tableJavaify( this, this.mTableProto );
    }

    @Override
    public String elementName() {
        return this.getClass().getSimpleName();
    }


    public String tabRoots         (){ return this.mTabRoots; }
    public String tabGlossary      (){ return this.mTabGlossary; }
    public String tabCollection    (){ return this.mTabCollection;}

    public String tabRootsNS       (){ return this.tableName( this.mTabRoots ); }
    public String tabGlossaryNS   (){ return this.tableName( this.mTabGlossary ); }
    public String tabCollectionNS  (){ return this.tableName( this.mTabCollection ); }

    public String getCollectedGlossarySQLProto(){
        return String.format(
                "SELECT %%s FROM " +
                        "(  " +
                        "   SELECT * From %s AS tCol %%s " +
                        ") AS tCol LEFT JOIN %s AS tBook ON tBook.`classid` = tCol.`classid` %%s",
                this.tabCollectionNS(),
                this.tabGlossaryNS()
        );
    }

    /** Asset **/
    protected String               mAstCoverSrc    = "";
    protected FragmentFileOperator mFileOperator   = null;
    protected FragmentRootFetcher  mWordFetcher    = null;

    public String                 astCoverSrc       (){ return this.mAstCoverSrc; }

    public FragmentFileOperator fileOperator      () {
        if( this.mFileOperator == null ){
            this.mFileOperator = new FragmentFileOperator( this );
        }
        return this.mFileOperator;
    }

    public FragmentRootFetcher fragmentFetcher       () {
        if( this.mWordFetcher == null ){
            this.mWordFetcher = new FragmentRootFetcher( this );
        }
        return this.mWordFetcher;
    }
}