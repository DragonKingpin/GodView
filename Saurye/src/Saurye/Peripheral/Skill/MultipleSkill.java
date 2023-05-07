package Saurye.Peripheral.Skill;

import Pinecone.Framework.System.Functions.FunctionTraits;

import java.lang.reflect.Method;

public interface MultipleSkill extends Skill {
    default Object exert( String szMethodName , Object... obj ) throws Exception {
        return FunctionTraits.invoke( this, szMethodName, obj );
    }

    default Object exertMajor( Object... obj ) throws Exception {
        Method[] fns = this.getClass().getDeclaredMethods();
        Method majorFn = null;
        for( Method fn : fns ) {
            MajorSkill annotation = fn.getAnnotation( MajorSkill.class );
            if( annotation != null && annotation.value() ){
                majorFn = fn;
                break;
            }
        }
        if( majorFn != null ){
            return FunctionTraits.invoke( this, majorFn, obj );
        }
        throw new IllegalStateException( "At least one major skill be defined." );
    }

    default String majorSkill() {
        Method[] fns = this.getClass().getDeclaredMethods();
        for( Method fn : fns ) {
            MajorSkill annotation = fn.getAnnotation( MajorSkill.class );
            if( annotation != null && annotation.value() ){
                return fn.getName();
            }
        }
        return null;
    }

    default Object exertMajorWithBuff( String szBuffName , Object... obj ) throws Exception {
        return this.exert( this.majorSkill() + szBuffName, obj );
    }

    default Object exertMajorWithBuff( String szNS, String szBuffName , Object... obj ) throws Exception {
        return this.exert( this.majorSkill() + szNS + szBuffName, obj );
    }

    default Object exertBuff ( String szBuffName ,Object... obj ) throws Exception {
        Method[] fns = this.getClass().getDeclaredMethods();
        Method buffFn = null;
        for( Method fn : fns ) {
            Buff annotation = fn.getAnnotation( Buff.class );
            if( annotation != null && annotation.value().equals( szBuffName ) ){
                buffFn = fn;
                break;
            }
        }
        if( buffFn != null ){
            return FunctionTraits.invoke( this, buffFn, obj );
        }
        throw new IllegalStateException( "No such buff be found in this skill." );
    }

}
