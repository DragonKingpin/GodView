package Saurye.Peripheral.Skill;

import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.System.Prototype.Peripheral;
import java.util.Map;

public interface Skill extends Peripheral {
    String prototypeName();

    Coach getCoach();

    default Skill setProperty( String key, Object val ){ return this; }

    default Skill setProperty( JSONObject properties ){
        for( Object row : properties.entrySet() ){
            Map.Entry kv = (Map.Entry) row;
            this.setProperty( (String) kv.getKey(), kv.getValue() );
        }
        return this;
    }

    default JSONObject property(){
        return null;
    }

    default String nodeName() {
        return this.getClass().getSimpleName();
    }
}
