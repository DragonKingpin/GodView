package Saurye.Peripheral.Equipment;

import Pinecone.Framework.System.Prototype.Prototype;
import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.System.PredatorArchWizardum;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;

public class UIEquipmentPeddler extends EquipmentPeddlerSour implements EquipmentPeddler {
    public UIEquipmentPeddler( PredatorArchWizardum hSoul ) {
        super( hSoul );
    }

    @Override
    public String prototypeName() {
        return "UI";
    }

    @Override
    public Type type(){
        return Type.T_UI;
    }

    @Override
    public JSONObject getPrivateConfig(){
        return this.nodeProperty().optJSONObject( this.prototypeName() );
    }

    public String getTemplatePath() {
        return this.host().getSystemPath() + this.host().getRealTemplatePath() + this.nodeProperty().getString( "TemplatePath" );
    }

    public String tplFileTypeName() {
        return ".html";
    }

    @Override
    public String getEquipmentNS() {
        return Prototype.namespace( this );
    }

    @Override
    public UIEquipment purchase( String szName ){
        String szFullName = this.getEquipmentNS() + "." + szName;

        UIEquipment hEquip = null;
        try {
            Class<?> pVoid = Class.forName( szFullName );
            try{
                Constructor<?> constructor = pVoid.getConstructor( this.getClass() );
                hEquip = (UIEquipment) constructor.newInstance( this );
            }
            catch ( NoSuchMethodException | InvocationTargetException e1 ){
                return null;
            }
        }
        catch ( ClassNotFoundException | IllegalAccessException | InstantiationException e ){
            return null;
        }

        return hEquip;
    }

    @Override
    public UIEquipment purchase( String szName, JSONObject additions ) {
        UIEquipment h = this.purchase( szName );
        return (UIEquipment) h.enchant( additions );
    }
}
