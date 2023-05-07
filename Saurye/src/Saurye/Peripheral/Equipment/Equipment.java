package Saurye.Peripheral.Equipment;

import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.System.Prototype.Peripheral;

public interface Equipment extends Peripheral {
    String prototypeName();

    EquipmentPeddler.Type type();

    JSONObject property();

    Equipment enchant( JSONObject additions );

    Equipment enchant( String key, Object val );

    Object synthesis();

    Object mount( Object ats );

    default String nodeName() {
        return this.getClass().getSimpleName();
    }

}
