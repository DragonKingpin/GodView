package Saurye.Elements.Mutual.Glossary;

import Saurye.Elements.StereotypicalElement;
import Saurye.Elements.Mutual.MutualAlchemist;
import Saurye.Elements.Mutual.OwnedElement;

public class Glossary extends OwnedElement implements StereotypicalElement {
    protected String mTabBand                 = "";
    protected String mTabGlossary             = "";
    protected String mTabBook                 = "";

    public Glossary ( MutualAlchemist alchemist ){
        super( alchemist );
        this.tableJavaify( this, this.mTableProto );
    }

    @Override
    public String elementName() {
        return this.getClass().getSimpleName();
    }


    public String tabBand                   (){ return this.mTabBand; }
    public String tabGlossary               (){ return this.mTabGlossary; }
    public String tabBook                   (){ return this.mTabBook; }

    public String tabBandNS                 (){ return this.tableName( this.mTabBand ); }
    public String tabGlossaryNS             (){ return this.tableName( this.mTabGlossary ); }
    public String tabBookNS                 (){ return this.tableName( this.mTabBook ); }

}
