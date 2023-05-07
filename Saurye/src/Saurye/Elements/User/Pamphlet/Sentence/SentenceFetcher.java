package Saurye.Elements.User.Pamphlet.Sentence;

import Saurye.Elements.EpitomeElement;
import Saurye.Elements.User.EpitomeSharded;
import Saurye.Elements.User.Pamphlet.Pamphlet;

public class SentenceFetcher extends EpitomeSharded implements EpitomeElement {
    public SentenceFetcher(Pamphlet stereotype) { super(stereotype);
    }

    @Override
    public String elementName() {
        return this.getClass().getSimpleName();
    }

    @Override
    public Pamphlet stereotype() {
        return (Pamphlet) this.mStereotype;
    }


    private BasicSentenceList mBasicSentenceList = null;

    public BasicSentenceList basicSentenceList () {
        if( this.mBasicSentenceList == null ){
            this.mBasicSentenceList = new BasicSentenceList( this.stereotype() );
        }
        return this.mBasicSentenceList;
    }

}
