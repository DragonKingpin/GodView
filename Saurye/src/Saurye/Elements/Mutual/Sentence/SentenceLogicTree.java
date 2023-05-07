package Saurye.Elements.Mutual.Sentence;

import Pinecone.Framework.Util.JSON.JSONArray;
import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.Elements.Mutual.EpitomeSharded;
import Saurye.Elements.Prototype.EpitomeCrystal;

import java.sql.SQLException;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.Vector;

public class SentenceLogicTree extends EpitomeSharded implements EpitomeCrystal {
    public SentenceLogicTree( Sentence stereotype ){
        super( stereotype );
    }

    @Override
    public String elementName() {
        return this.getClass().getSimpleName();
    }

    @Override
    public Sentence stereotype() {
        return (Sentence) this.mStereotype;
    }

    private String        mszSentence;
    private JSONArray     mArtery;
    private String[]      mPoS;
    private JSONArray     mKeyArtery;

    public SentenceLogicTree apply( String szSentence ) throws SQLException {
        this.mszSentence = szSentence;
        return this;
    }

    public JSONArray arterify() {
        Set<String >    enStopWords = this.owned().getMaster().host().textBasicProcessor().getEnStopWord();
        Vector<String > words = this.owned().getMaster().host().textBasicProcessor().en_segmenting( this.mszSentence );

        this.mArtery = new JSONArray();
        for ( int i = 0; i < words.size(); i++ ) {
            String szWord = words.get( i );
            if( !enStopWords.contains( szWord.toLowerCase() ) ){
                this.mArtery.put( szWord );
            }
        }

        return this.mArtery;
    }

    private String[] tag0(){
        this.mPoS = this.owned().getMaster().host().textBasicProcessor().en_tag( this.mszSentence );
        return this.mPoS;
    }

    public JSONArray tag( ) {
        return new JSONArray( this.tag0() );
    }

    public JSONArray tag_pine( ) {
        return new JSONArray( this.owned().getMaster().host().textBasicProcessor().getPinePoSs( this.tag0() ) );
    }

    public JSONArray tag_pine_detail( ) {
        return new JSONArray( this.owned().getMaster().host().textBasicProcessor().getPineDetailPoSs( this.tag0() ) );
    }


    public JSONObject get_markov_chain() throws SQLException {
        String[] debris = this.owned().getMaster().host().textBasicProcessor().en_segmenting_array( this.mszSentence );
        JSONObject map = new JSONObject();
        if( debris.length > 0 ){
            map.put( debris[0], 1 );
        }
        if( debris.length > 1 ){
            for ( int i = 1; i < debris.length; i++ ) {
                String szWord = debris[ i - 1 ];
                String szNext = debris[ i     ];
                map.put( szNext, this.stereotype().getMarkovProbly( szWord, szNext, null ) );
            }
        }

        return map;
    }


    public JSONArray keyWordify( boolean bUserSensitive ) throws SQLException {
        this.arterify();

        Map<Integer, String > weightMap = new TreeMap<>();

        this.mKeyArtery = new JSONArray();
        for ( int i = 0; i < this.mArtery.length(); i++ ) {
            String szWord = this.mArtery.getString( i );

            JSONArray jUB = this.mysql().fetch( String.format( "SELECT `w_over_base` FROM %s WHERE `en_word` = '%s'",
                    this.owned().word().tabWeightUnionBaseNS(), szWord
            ) );

            if( !jUB.isEmpty() ){
                weightMap.put( jUB.optJSONObject(0).optInt( "w_over_base" ), szWord );
            }
        }

        for ( Map.Entry kv : weightMap.entrySet() ) {
            this.mKeyArtery.put( kv.getValue() );
        }

        return this.mKeyArtery;
    }

}
