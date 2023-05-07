package Saurye.Wizard.Admin.AdminMutualGlossary;


import Pinecone.Framework.Util.Random.SeniorRandom;
import Pinecone.Framework.Util.JSON.JSONObject;
import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.JSONBasedControl;
import Saurye.System.Predator;
import Saurye.Peripheral.Skill.MVC.ControlLayerSkill;

import java.io.IOException;
import java.sql.SQLException;


public class AdminMutualGlossaryControl extends AdminMutualGlossary implements JSONBasedControl {
    public AdminMutualGlossaryControl( ArchConnection connection ) {
        super(connection);
    }

    @Override
    public void defaultGenie() throws Exception {
        super.defaultGenie();
    }

    public void appendNewGlossary() throws IOException,SQLException {
        JSONObject $_SPOST = this.$_POST( true );
        JSONObject en2ch_data = $_SPOST.subJson( new String[]{ "username", "g_name","g_note","g_authority" } );
        String szClassId = new SeniorRandom().nextString(8);
        do{
            szClassId = new SeniorRandom().nextString(8);
        }
        while(this.mysql().countFromTable(String.format("SELECT COUNT(*) FROM %s WHERE `class_id` = '%s'", this.tableName(Predator.TABLE_MUTUAL_GLOSSARY),szClassId ))>0);
        en2ch_data.put("class_id",szClassId);
        String szNewGlossaryName = $_SPOST.optString("g_name");
        String szUsername=$_SPOST.optString("username");
        //String szDate=this.mysql().getSystemTime();
        //en2ch_data.put("create_data",szDate);
        if( this.mysql().countFromTable(
                String.format(
                        "SELECT COUNT(*) FROM %s WHERE `username` = '%s' AND `g_name` = '%s'" ,
                        this.tableName(Predator.TABLE_MUTUAL_GLOSSARY), szUsername,szNewGlossaryName )
        ) > 0 ){
            this.alert( "'"+szUsername+"'"+"的"+"'"  + szNewGlossaryName +"'单词本已经存在", 0, -1 );
        }

        boolean bRes = this.mysql().insertWithArray( Predator.TABLE_MUTUAL_GLOSSARY, en2ch_data.getMap() ) > 0;
        this.checkResult( bRes, null, this.spawnActionQuerySpell() );
    }

    public void deleteOneGlossary() throws IOException,SQLException {
//        this.checkResult(
//                this.deleteOneGlossary( null )
//        );
    }

    public void modifyOneGlossary() throws IOException, SQLException {
        JSONObject $_SPOST = this.$_POST( true );

        JSONObject condition  = $_SPOST.subJson( "class_id" );
        System.out.println(condition);
        JSONObject glossary_data = $_SPOST.subJson( new String[]{ "g_name","g_authority","g_note" } );
        boolean bRes = this.mysql().updateWithArray( Predator.TABLE_MUTUAL_GLOSSARY, glossary_data.getMap(), condition.getMap() ) > 0;

        this.checkResult( bRes );
    }

    public boolean deleteOneGlossary( String szID ) throws IOException, SQLException {
        return false;
       // return this.coach().control().simpleDeleteSingleObject( "id", szID, Saurye.TABLE_MUTUAL_GLOSSARY );
    }

    public void glossaryMassDelete() throws IOException, SQLException {
        ControlLayerSkill.commonMassDelete( this, "id[]", "deleteOneGlossary" );
    }
}