package Saurye.Elements.Mutual.Word;

import Saurye.Elements.EpitomeElement;
import Saurye.Elements.Mutual.EpitomeSharded;

public class BandWords extends EpitomeSharded implements EpitomeElement {
    public BandWords ( Word stereotype ){
        super( stereotype );
    }

    @Override
    public String elementName() {
        return this.getClass().getSimpleName();
    }

    @Override
    public Word stereotype() {
        return (Word) this.mStereotype;
    }

}
