package Saurye.Peripheral.Skill;

import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.System.PredatorArchWizardum;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;

public class MultipleSoulCoach extends CoreCoach {
    private PredatorArchWizardum mSoul;

    public MultipleSoulCoach(PredatorArchWizardum soul ) {
        super( soul.system() );
        this.mSoul = soul;
    }

    @Override
    public MultipleSkill learned( String szSkillName ) {
        String szFullName = this.getNodeNamespace() + "." + szSkillName;

        MultipleSkill hSkill;
        try {
            Class<?> pVoid = Class.forName( szFullName );
            try{
                Constructor<?> constructor = pVoid.getConstructor( PredatorArchWizardum.class );
                hSkill = (MultipleSkill) constructor.newInstance( this.mSoul );
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
    public MultipleSkill learned( String szSkillName, JSONObject properties ) {
        MultipleSkill h = this.learned( szSkillName );
        return (MultipleSkill) h.setProperty( properties );
    }

    @Override
    public MultipleSkill learned( String szSkillName, String key, Object val ) {
        MultipleSkill h = this.learned( szSkillName );
        return (MultipleSkill) h.setProperty( key, val );
    }
}
