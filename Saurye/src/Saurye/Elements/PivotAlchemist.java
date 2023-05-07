package Saurye.Elements;

import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.System.Prototype.Alchemist;

public interface PivotAlchemist extends Alchemist {
    String rootName();

    JSONObject elementPart ( String szElementPartName );

    JSONObject tableFields ( String szElementPartName );

    JSONObject assetFields ( String szElementPartName );
}
