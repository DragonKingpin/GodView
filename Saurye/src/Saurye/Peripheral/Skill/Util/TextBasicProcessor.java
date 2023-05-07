package Saurye.Peripheral.Skill.Util;

import Pinecone.Framework.Debug.Debug;
import Pinecone.Framework.Util.JSON.JSONArray;
import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.Peripheral.Skill.Plug.HanLPFileIoAdapter;
import Saurye.System.Predator;
import com.hankcs.hanlp.HanLP;
import com.hankcs.hanlp.seg.common.Term;
import opennlp.tools.postag.POSModel;
import opennlp.tools.postag.POSTaggerME;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.SQLException;
import java.util.*;
import java.util.regex.Pattern;

public class TextBasicProcessor {
    private Predator mHost;

    private Set<String > mCnStopWord;

    private Set<String > mEnStopWord;

    public TextBasicProcessor( Predator host ) {
        this.mHost = host;
        HanLPFileIoAdapter.asPrototype( this.mHost );

        this.loadStopWord();
    }


    private Set<String > getStopWordSet( String szTableName ) throws SQLException {
        JSONArray res = this.mHost.mysql().fetch(
                String.format( "SELECT `c_token` FROM %s", szTableName )
        );

        Set<String > set = new HashSet<>();

        for ( Object obj : res ) {
            set.add( ( (JSONObject)obj ).optString( "c_token" ) );
        }

        return set;
    }

    private void loadStopWord( ){
        if( this.mCnStopWord == null || this.mEnStopWord == null ){
            try{
                this.mCnStopWord = this.getStopWordSet( this.mHost.mysql().tableName( Predator.TABLE_CN_STOP_WORD ) );
                this.mEnStopWord = this.getStopWordSet( this.mHost.mysql().tableName( Predator.TABLE_EN_STOP_WORD ) );
            }
            catch ( SQLException e ){
                e.printStackTrace();
            }
        }
    }

    public Set<String > getCnStopWord() {
        this.loadStopWord();
        return this.mCnStopWord;
    }

    public Set<String > getEnStopWord() {
        this.loadStopWord();
        return this.mEnStopWord;
    }

    public String[]           en_segmenting_array ( String szEn ) {
        return szEn.split( "[\\s.,]+" );
    }

    public Vector<String >    en_segmenting( String szEn ) {
        Vector<String > res = new Vector<>();
        Collections.addAll( res, this.en_segmenting_array( szEn ) );
        return res;
    }

    public Vector<String >    cn_segmenting( String szCn ) {
        List<Term > segTokenList = HanLP.segment( szCn );
        Vector<String > vector = new Vector<>();

        for ( Term st : segTokenList ) {
            vector.add( st.word );
        }

        return vector;
    }

    public Vector<String >    cn_segmenting_only( String szCn ) {
        List<Term > segTokenList = HanLP.segment( szCn );
        Vector<String > vector = new Vector<>();

        for ( Term st : segTokenList ) {
            if( Pattern.compile( "[\\u4E00-\\u9FA5]+" ).matcher( st.word ).find() ){
                vector.add( st.word );
            }
        }

        return vector;
    }

    public Vector<String >    cn_segmenting_important( String szCn ) {
        List<Term > segTokenList = HanLP.segment( szCn );
        Vector<String > vector = new Vector<>();

        for ( Term st : segTokenList ) {
            if( !this.mCnStopWord.contains( st.word ) && Pattern.compile( "[\\u4E00-\\u9FA5]+" ).matcher( st.word ).find() ){
                vector.add( st.word );
            }
        }

        return vector;
    }




    public static final HashMap<String, String > S_TaggerMaper = new HashMap<String,String >() {
        {
            put("PHRASE","general");
            put( "CC", "conj" );put("CD", "num" );put( "DT","general" );
            put( "EX","general" );put( "FW","n" );put( "IN","prep" );
            put( "JJ","adj" );put( "JJR","adj" );put( "JJS","adj" );
            put("LS","general" );put( "MD","aux" );put( "NN","n" );
            put( "NNS","n" );put("NNP", "n" );put( "NNPS", "n" );
            put( "PDT","general" );put( "POS","general" );put( "PRP","pron" );
            put( "PRP$","pron" );
            put( "RB","adv" );put( "RBR","adv" );put("RBS","adv" );
            put( "RP","art" );put("SYM","general");put("TO","general");
            put("UH","int");put("VB","v");put("VBD","v");
            put("VBP","v");
            put("VBG","v");put("VBN","v");put("VBZ","v");
            put("WDT","v");put("WP","pron");put("WRB","adv");
        }
    };

    public static final HashMap<String, String > S_TaggerMaperDetail = new HashMap<String,String >() {
        {
            put("PHRASE","phrase");
            put( "CC", "conj" );put("CD", "num" );put( "DT","det" );
            put( "EX","ex_there" );put( "FW","n" );put( "IN","prep" );
            put( "JJ","adj" );put( "JJR","adj" );put( "JJS","adj" );
            put("LS","item" );put( "MD","aux" );put( "NN","n" );
            put( "NNS","n_s" );put("NNP", "n_proper" );put( "NNPS", "n_proper_s" );
            put( "PDT","pre_det" );put( "POS","genitive" );put( "PRP","pron" );
            put( "PRP$","pron" );
            put( "RB","adv" );put( "RBR","adv" );put("RBS","adv" );
            put( "RP","art" );put("SYM","symbol");put("TO","to");
            put("UH","int");put("VB","v");put("VBD","v_ed");
            put("VBP","v_ing_no_3rd");
            put("VBG","v_ing");put("VBN","v_done");put("VBZ","v_ing_3rd");
            put("WDT","WH_det");put("WP","pron");put("WRB","adv");
        }
    };

    private POSModel    mTagModel     = null;
    private POSTaggerME mTagTagger    = null;

    private void loadOpenNLP(){
        if( this.mTagTagger == null ){
            try{
                this.mTagModel  = new POSModel( new FileInputStream (
                        new File( this.mHost.getResourcesPath() + "/plug/openNLP/en-pos-maxent.bin")
                ));
                this.mTagTagger = new POSTaggerME( this.mTagModel );
            }
            catch ( IOException e ){
                Debug.cerr( e.getMessage() );
            }
        }
    }

    public POSModel    getTagModel() {
        this.loadOpenNLP();
        return this.mTagModel;
    }

    public POSTaggerME getTagTagger() {
        this.loadOpenNLP();
        return this.mTagTagger;
    }

    public String      getPinePoS (String szPoS ) {
        if( TextBasicProcessor.S_TaggerMaper.containsKey( szPoS ) ){
            return TextBasicProcessor.S_TaggerMaper.get( szPoS );
        }
        return "general";
    }

    public String[]    getPinePoSs( String[] szPoSs ) {
        for ( int i = 0; i < szPoSs.length; i++ ) {
            szPoSs[i] = this.getPinePoS( szPoSs[i] );
        }
        return szPoSs;
    }

    public String      getPineDetailPoS ( String szPoS ) {
        if( TextBasicProcessor.S_TaggerMaperDetail.containsKey( szPoS ) ){
            return TextBasicProcessor.S_TaggerMaperDetail.get( szPoS );
        }
        return "general";
    }

    public String[]    getPineDetailPoSs( String[] szPoSs ) {
        for ( int i = 0; i < szPoSs.length; i++ ) {
            szPoSs[i] = this.getPineDetailPoS( szPoSs[i] );
        }
        return szPoSs;
    }

    public String[]    en_tag( String szEn ){
        this.loadOpenNLP();
        return this.mTagTagger.tag( this.en_segmenting_array( szEn ) );
    }

    public String[]    en_tag_pine( String szEn ){
        return this.getPinePoSs( this.en_tag( szEn ) );
    }

    public String[]    en_tag_pine_detail( String szEn ){
        return this.getPineDetailPoSs( this.en_tag( szEn ) );
    }

}
