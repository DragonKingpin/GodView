package Saurye.Peripheral.Skill;

import Pinecone.Framework.System.Prototype.Prototype;
import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.System.Predator;
import Saurye.System.Prototype.PeripheralBus;

public interface Coach extends PeripheralBus {
    default Class childType() {
        try {
            return Class.forName( Prototype.namespace( this ) + "." + Prototype.namespaceNode( this ) );
        } catch ( ClassNotFoundException e ){
            return null;
        }
    }

    String prototypeName();

    Predator host() ;

    String getNodeNamespace();

    Skill learned( String szSkillName );

    Skill learned( String szSkillName, JSONObject properties );

    Skill learned( String szSkillName, String key, Object val );
}
