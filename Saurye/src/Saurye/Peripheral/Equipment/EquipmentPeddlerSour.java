package Saurye.Peripheral.Equipment;

import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.System.Predator;
import Saurye.System.PredatorArchWizardum;

public abstract class EquipmentPeddlerSour implements EquipmentPeddler {
    protected PredatorArchWizardum mhParentImage;

    public EquipmentPeddlerSour ( PredatorArchWizardum hSoul ) {
        this.mhParentImage = hSoul;
    }

    public Predator host(){
        return this.mhParentImage.system();
    }

    @Override
    public JSONObject nodeProperty(){
        return this.host().getPeripheralConfig().getJSONObject( this.childType().getSimpleName() );
    }
}
