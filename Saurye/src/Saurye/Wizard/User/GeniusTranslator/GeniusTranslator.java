package Saurye.Wizard.User.GeniusTranslator;

import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Wizard;
import Saurye.System.PredatorGenieBottle;

public class GeniusTranslator extends PredatorGenieBottle implements Wizard {
    public GeniusTranslator( ArchConnection connection ){
        super(connection);
    }

    public String prototypeName(){
        return this.getClass().getSuperclass().getSimpleName();
    }
}
