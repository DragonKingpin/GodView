package Saurye.Wizard.User.FragmentExplicater;

import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Wizard;
import Saurye.System.PredatorGenieBottle;

public class FragmentExplicater extends PredatorGenieBottle implements Wizard {
    public FragmentExplicater( ArchConnection connection ){
        super(connection);
    }

    public String prototypeName(){
        return this.getClass().getSuperclass().getSimpleName();
    }

}
