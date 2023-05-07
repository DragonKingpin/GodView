package Saurye.Peripheral.Skill;

import Pinecone.Framework.System.Prototype.Prototype;
import Pinecone.Framework.Util.JSON.JSONArray;
import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.Peripheral.Skill.MVC.ControlLayerSkill;
import Saurye.Peripheral.Skill.MVC.ModelLayerSkill;
import Saurye.System.Predator;
import Saurye.System.PredatorArchWizardum;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;


public class CoreCoach implements Coach {
    protected Predator              mMatrix           = null ;
    private ModelLayerSkill         mModelSkill       = null ;
    private ControlLayerSkill       mControlSkill     = null ;
    private CipherSkill             mCipherSkill      = null ;
    private PredatorWordSortHelper  mWordSortHelper   = null;

    public CoreCoach( Predator matrix ) {
        this.mMatrix         = matrix;
        this.mModelSkill     = new ModelLayerSkill( this );
        this.mControlSkill   = new ControlLayerSkill( this );
        this.mCipherSkill    = new CipherSkill( this );
        this.mWordSortHelper = new PredatorWordSortHelper();
    }

    @Override
    public Predator host() {
        return this.mMatrix;
    }

    @Override
    public String prototypeName() {
        return this.getClass().getSimpleName();
    }

    @Override
    public JSONObject nodeProperty(){
        return this.mMatrix.getPeripheralConfig().optJSONObject( this.childType().getSimpleName() );
    }

    public ModelLayerSkill model(){
        return this.mModelSkill;
    }

    public ControlLayerSkill control(){
        return this.mControlSkill;
    }

    public CipherSkill cipher(){
        return this.mCipherSkill;
    }

    public PredatorWordSortHelper sort() { return this.mWordSortHelper; }

    public MultipleSoulCoach soulCoach(PredatorArchWizardum soul ) {
        return new MultipleSoulCoach( soul );
    }

    @Override
    public String getNodeNamespace() {
        return Prototype.namespace( this );
    }

    @Override
    public Skill learned( String szSkillName ) {
        String szFullName = this.getNodeNamespace() + "." + szSkillName;

        Skill hSkill;
        try {
            Class<?> pVoid = Class.forName( szFullName );
            try{
                Constructor<?> constructor = pVoid.getConstructor( this.getClass() );
                hSkill = (Skill) constructor.newInstance( this );
            }
            catch ( NoSuchMethodException | InvocationTargetException e1 ){
                return null;
            }
        }
        catch ( ClassNotFoundException | IllegalAccessException | InstantiationException e ){
            return null;
        }

        return hSkill;
    }

    @Override
    public Skill learned( String szSkillName, JSONObject properties ) {
        Skill h = this.learned( szSkillName );
        return (Skill) h.setProperty( properties );
    }

    @Override
    public Skill learned( String szSkillName, String key, Object val ) {
        Skill h = this.learned( szSkillName );
        return (Skill) h.setProperty( key, val );
    }




    public static String getUserRole(){
        return "public";
    }

    public static JSONArray spawnMenuFairyWithRole( JSONObject hMenuStream ){
        String role = CoreCoach.getUserRole();
        JSONArray currentMenu = hMenuStream.getJSONArray("union") ;

        if( role.equals("superAdmin") ){

        }
        else {
            JSONArray client = hMenuStream.getJSONArray("client");
            for( int i=0; i < client.length();i++ ){
                currentMenu.put(client.getJSONObject(i));
            }

            JSONArray roleMenu = hMenuStream.optJSONArray( role );
            if( roleMenu != null ){
                for( int i=0; i < roleMenu.length();i++ ){
                    currentMenu.put(roleMenu.getJSONObject(i));
                }
            }
        }

        JSONObject jsonObject = new JSONObject( "{'title':'管理员专区', 'href':'javascript:void(0)', 'icon':'fa fa-magic'}" );
        jsonObject.put("submenu",hMenuStream.getJSONArray("admin"));

        currentMenu.put(jsonObject);

        return currentMenu;
    }

}
