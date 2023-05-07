package Saurye.Peripheral.Equipment;

import Pinecone.Framework.System.Prototype.Prototype;
import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.System.Predator;
import Saurye.System.Prototype.PeripheralBus;

public interface EquipmentPeddler extends PeripheralBus {
    enum Type {
        T_UI
    }

    default Class childType() {
        try {
            return Class.forName( Prototype.namespace( this ) + "." + Prototype.namespaceNode( this ) );
        } catch ( ClassNotFoundException e ){
            return null;
        }
    }

    String prototypeName();

    Type type();

    JSONObject getPrivateConfig();

    Predator host();

    String getEquipmentNS();

    Equipment purchase( String szName );

    Equipment purchase( String szName, JSONObject additions );

}
