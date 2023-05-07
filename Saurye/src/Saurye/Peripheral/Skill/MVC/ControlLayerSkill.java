package Saurye.Peripheral.Skill.MVC;

import Pinecone.Framework.System.util.StringUtils;
import Pinecone.Framework.Util.JSON.JSONArray;
import Pinecone.Framework.Util.JSON.JSONObject;
import Pinecone.Framework.Util.Summer.prototype.JSONBasedControl;
import Saurye.Peripheral.Skill.Coach;
import Saurye.Peripheral.Skill.SkillSoul;
import Saurye.Peripheral.Skill.BasicSkill;
import Saurye.System.PredatorArchWizardum;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.sql.SQLException;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.TreeSet;

public class ControlLayerSkill extends SkillSoul implements BasicSkill {
    public ControlLayerSkill( Coach coach ){
        super( coach );
    }

    @Override
    public String prototypeName() {
        return this.getClass().getSimpleName();
    }

    /** Genie **/
    public static Method getControlGenie( JSONBasedControl that, String szGenie, Class<?>... parameterTypes ) {
        try {
            return that.getClass().getMethod( szGenie, parameterTypes );
        }
        catch ( NoSuchMethodException e ){
            return null;
        }
    }

    public static Object invokeControlGenie( JSONBasedControl that, Method hfnGenie, Object...more ) {
        if( hfnGenie != null ){
            try {
                return hfnGenie.invoke( that, more );
            }
            catch ( IllegalAccessException | InvocationTargetException e ){
                e.printStackTrace();
            }
        }
        return false;
    }

    public static void commonMassDelete( JSONBasedControl that, String szKey, String szFunDeleteOne, Set notInc ) {
        JSONObject $_SPOST = ( (PredatorArchWizardum) that).$_POST(true);
        Object ids = $_SPOST.opt( szKey );

        boolean bRes = true;
        if( ids instanceof String ){
            bRes = (boolean) ControlLayerSkill.invokeControlGenie( that, ControlLayerSkill.getControlGenie( that, szFunDeleteOne, String.class ), (String) ids );
        }
        else if( ids instanceof JSONArray){
            JSONArray idsArray = (JSONArray) ids;
            for( int i=0; i < idsArray.length(); ++i ) {
                if( notInc != null && notInc.contains(idsArray.optString( i )) ){
                    continue;
                }
                //Debug.trace( idsArray.optString( i ) );
                bRes &= (boolean) ControlLayerSkill.invokeControlGenie( that, ControlLayerSkill.getControlGenie( that, szFunDeleteOne, String.class ), idsArray.optString( i ) );
            }
        }
        else {
            bRes = false;
        }

        ( (PredatorArchWizardum) that).writer().print( bRes ? "true" : "false" );
        ( (PredatorArchWizardum) that).stop();
    }

    public static void commonMassDelete( JSONBasedControl that, String szKey, String szFunDeleteOne ) {
        ControlLayerSkill.commonMassDelete( that, szKey, szFunDeleteOne, "on"  );
    }

    public static void commonMassDelete( JSONBasedControl that, String szKey, String szFunDeleteOne, String notInc ) {
        Set<String> h = new TreeSet<>();
        h.add( notInc );
        ControlLayerSkill.commonMassDelete( that, szKey, szFunDeleteOne ,h  );
    }


    public static Map simpleDeleteSingleObject( JSONObject $_GET, String szKey, String szDefaultValue ){
        szDefaultValue = StringUtils.isEmpty( szDefaultValue ) ? $_GET.optString( szKey ) : szDefaultValue;
        if( StringUtils.isEmpty( szDefaultValue ) ){
            return null;
        }

        TreeMap<String, String > map = new TreeMap<>();
        map.put( szKey, szDefaultValue );
        return map;
    }

    public boolean simpleDeleteSingleObject ( JSONObject $_SGET, String szKey, String szDefaultValue, String szTable ) throws SQLException {
        Map map = ControlLayerSkill.simpleDeleteSingleObject( $_SGET, szKey, szDefaultValue );
        if( map == null ){
            return false;
        }
        return this.mysql().deleteWithArray( szTable, map ) > 0;
    }


}
