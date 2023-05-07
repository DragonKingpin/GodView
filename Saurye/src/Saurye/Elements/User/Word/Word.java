package Saurye.Elements.User.Word;

import Saurye.Elements.StereotypicalElement;
import Saurye.Elements.User.OwnedElement;
import Saurye.Elements.User.UserAlchemist;

public class Word extends OwnedElement implements StereotypicalElement {
    protected String mTabRecall             = "";
    protected String mTabRecord             = "";

    public Word ( UserAlchemist alchemist ) {
        super( alchemist );
        this.tableJavaify( this, this.mTableProto );
    }

    @Override
    public String elementName() {
        return this.getClass().getSimpleName();
    }


    public String tabRecall         (){ return this.mTabRecall; }
    public String tabRecord         (){ return this.mTabRecord; }

    public String tabRecallNS       (){ return this.tableName( this.mTabRecall ); }
    public String tabRecordNS       (){ return this.tableName( this.mTabRecord ); }

}