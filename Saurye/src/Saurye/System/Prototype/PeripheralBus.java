package Saurye.System.Prototype;

import Pinecone.Framework.Util.JSON.JSONObject;

public interface PeripheralBus {
    Class childType();

    default JSONObject nodeProperty(){
        return new JSONObject();
    }
}
