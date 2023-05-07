package Saurye.Peripheral.Skill;

import Pinecone.Framework.Util.JSON.JSONObject;
import Pinecone.Framework.Util.RDB.MySQL.MySQLExecutor;
import Saurye.System.Predator;

public abstract class SkillSoul implements Skill {
    protected Coach mCoach = null ;

    protected JSONObject mProperties;

    public SkillSoul( Coach coach ) {
        this.mCoach = coach;
    }

    @Override
    public Skill setProperty( String key, Object val ) {
        this.mProperties.put( key, val );
        return this;
    }

    @Override
    public JSONObject property() {
        return this.mProperties;
    }

    public Predator host() {
        return this.mCoach.host();
    }

    protected MySQLExecutor mysql(){
        return this.host().mysql();
    }

    @Override
    public Coach getCoach() {
        return this.mCoach;
    }
}
