package Saurye.Elements;

import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.System.Prototype.Element;

public interface StereotypicalElement extends Element {
    void javaify ( String szPrefix, Object that, JSONObject proto );
}
