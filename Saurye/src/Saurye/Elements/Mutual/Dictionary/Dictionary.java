package Saurye.Elements.Mutual.Dictionary;

import Saurye.Elements.StereotypicalElement;
import Saurye.Elements.Mutual.MutualAlchemist;
import Saurye.Elements.Mutual.OwnedElement;

public class Dictionary extends OwnedElement implements StereotypicalElement {
    protected String mTabEnCnIndex             = "";
    protected String mTabEn2Cn                 = "";
    protected String mTabEn2En                 = "";

    protected String mTabProEn2Cn              = "";
    protected String mTabProField              = "";

    public Dictionary ( MutualAlchemist alchemist ){
        super( alchemist );
        this.tableJavaify( this, this.mTableProto );
    }

    @Override
    public String elementName() {
        return this.getClass().getSimpleName();
    }


    public String tabEnCnIndex          (){ return this.mTabEnCnIndex; }
    public String tabEn2Cn              (){ return this.mTabEn2Cn; }
    public String tabEn2En              (){ return this.mTabEn2En; }

    public String tabProEn2Cn           (){ return this.mTabProEn2Cn; }
    public String tabProField           (){ return this.mTabProField; }

    public String tabEnCnIndexNS        (){ return this.tableName( this.mTabEnCnIndex ); }
    public String tabEn2CnNS            (){ return this.tableName( this.mTabEn2Cn ); }
    public String tabEn2EnNS            (){ return this.tableName( this.mTabEn2En ); }

    public String tabProEn2CnNS         (){ return this.tableName( this.mTabProEn2Cn ); }
    public String tabProFieldNS         (){ return this.tableName( this.mTabProField ); }



    private EnglishToChinese mDictEn2Cn = null;

    public EnglishToChinese dictEn2Cn() {
        if( this.mDictEn2Cn == null ){
            this.mDictEn2Cn = new EnglishToChinese( this );
        }
        return this.mDictEn2Cn;
    }
}
