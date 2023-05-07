package Saurye.Elements.Mutual.Word;

import Pinecone.Framework.Debug.Debug;
import Pinecone.Framework.Util.JSON.JSONArray;
import Pinecone.Framework.Util.JSON.JSONObject;
import Pinecone.Framework.Util.RDB.MappedSQLSplicer;
import Saurye.Elements.Mutual.EpitomeSharded;
import Saurye.Elements.Prototype.EpitomeCrystal;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.SQLException;

public class WordWeightTree extends EpitomeSharded implements EpitomeCrystal {
    public WordWeightTree( Word stereotype ){
        super( stereotype );
    }

    @Override
    public String elementName() {
        return this.getClass().getSimpleName();
    }

    @Override
    public Word stereotype() {
        return (Word) this.mStereotype;
    }

    public static int fragmentBandWeightify ( String szBand ) {
        switch ( szBand ){
            case "junior": {
                return 1;
            }
            case "middle": {
                return 2;
            }
            case "senior": {
                return 3;
            }
            default: {
                return 4;
            }
        }
    }

    private String        mszEnWord;

    private JSONObject    mNexusTree;

    public WordWeightTree apply( String szEnWord ) throws SQLException {
        this.mszEnWord  = szEnWord;
        this.mNexusTree = this.stereotype().wordNexusTree().apply( szEnWord ).eval();
        return this;
    }

    public JSONObject     getNexusTree() {
        return this.mNexusTree;
    }


    public JSONArray getEtymNode () {
        return this.mNexusTree.optJSONArray( "children" ).optJSONObject( 0 ).optJSONArray( "children" );
    }

    public JSONObject get_etym_weights() {
        JSONArray jThisNode = this.getEtymNode();
        if( jThisNode.isEmpty() ){
            return new JSONObject();
        }

        return ( (JSONObject)jThisNode.back() ).optJSONObject( "pine_raw_w" );
    }


    public JSONObject getFragNode () {
        return this.mNexusTree.optJSONArray( "children" ).optJSONObject( 3 );
    }

    public JSONObject get_frag_weights() {
        JSONObject jThisNode = this.getFragNode();
        if( jThisNode.optJSONArray( "children" ).isEmpty() ){
            return new JSONObject();
        }

        return jThisNode.optJSONObject( "pine_raw_w" );
    }


    public JSONObject getDynaNode () {
        return this.mNexusTree.optJSONArray( "children" ).optJSONObject( 4 );
    }

    public JSONObject get_dyna_weights() {
        JSONObject jThisNode = this.getDynaNode();
        if( jThisNode.optJSONArray( "children" ).isEmpty() ){
            return new JSONObject();
        }

        return jThisNode.optJSONObject( "pine_raw_w" );
    }


    public JSONObject getProfNode () {
        return this.mNexusTree.optJSONArray( "children" ).optJSONObject( 5 );
    }

    public JSONObject get_prof_weights() {
        JSONObject jThisNode = this.getProfNode();
        if( jThisNode.optJSONArray( "children" ).isEmpty() ){
            return new JSONObject();
        }

        return jThisNode.optJSONObject( "pine_raw_w" );
    }


    public JSONObject getFromNode () {
        return this.mNexusTree.optJSONArray( "children" ).optJSONObject( 6 );
    }

    public JSONObject get_form_weights() {
        JSONObject jThisNode = this.getFromNode();
        if( jThisNode.optJSONArray( "children" ).isEmpty() ){
            return new JSONObject();
        }

        return jThisNode.optJSONObject( "pine_raw_w" );
    }

    public void storage_dp_transfer_table ( FileWriter sqlWriter ) throws IOException {
        JSONObject jEtymWeight = this.get_etym_weights();
        JSONObject jFragWeight = this.get_frag_weights();
        JSONObject jDynaWeight = this.get_dyna_weights();
        JSONObject jProfWeight = this.get_prof_weights();
        JSONObject jFormWeight = this.get_form_weights();

        MappedSQLSplicer sqlSplicer = new MappedSQLSplicer();

        jEtymWeight.remove( "w_e_devi" );
        jEtymWeight.getMap().putAll( jFragWeight.getMap() );
        jEtymWeight.put( "en_word", this.mszEnWord );
        sqlWriter.write( sqlSplicer.spliceInsertSQL( this.owned().word().tabWeightEtymFragNS(), jEtymWeight.getMap(), false ) + ";\n" );

        jProfWeight.getMap().putAll( jFormWeight.getMap() );
        jProfWeight.put( "en_word", this.mszEnWord );
        sqlWriter.write( sqlSplicer.spliceInsertSQL( this.owned().word().tabWeightProfFormNS(), jProfWeight.getMap(), false ) + ";\n" );

        jDynaWeight.put( "en_word", this.mszEnWord );
        sqlWriter.write( sqlSplicer.spliceInsertSQL( this.owned().word().tabWeightDynamicNS(), jDynaWeight.getMap(), false ) + ";\n" );

    }

    public void storage_dp_transfer_table ( File sqlFile, JSONArray words ) throws IOException, SQLException {
        FileWriter sqlWriter = new FileWriter( sqlFile );

        //JSONArray words = new JSONArray( FileUtil.readAll( "J:/MutualWordsLibList.json5" ) );
        for ( int i = 0; i < words.length(); i++ ) {
            String szWord = words.optString( i );
            Debug.echo( i,":", szWord," " );

            this.apply( szWord ).storage_dp_transfer_table( sqlWriter ) ;
        }

        sqlWriter.close();

    }

    public double eval_etym(){
        return 0;
    }



}
