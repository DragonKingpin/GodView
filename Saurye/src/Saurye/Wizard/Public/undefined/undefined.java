package Saurye.Wizard.Public.undefined;

import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Wizard;
import Saurye.System.PredatorGenieBottle;

public class undefined extends PredatorGenieBottle implements Wizard {
    public undefined( ArchConnection connection ){
        super(connection);
        //console.error ( "Ally has been summoned." );
    }

    public String prototypeName(){
        return this.getClass().getSuperclass().getSimpleName();
    }

    @Override
    protected void finalize() {
        console.error ( "Ally has been slain." );
    }
}
