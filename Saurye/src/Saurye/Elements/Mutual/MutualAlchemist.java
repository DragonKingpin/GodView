package Saurye.Elements.Mutual;

import Pinecone.Framework.System.Prototype.Prototype;
import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.Elements.AlchemistMaster;
import Saurye.Elements.Mutual.Dictionary.Dictionary;
import Saurye.Elements.Mutual.Etymology.Etymology;
import Saurye.Elements.Mutual.Extend.Extend;
import Saurye.Elements.Mutual.Fragment.Fragment;
import Saurye.Elements.Mutual.Glossary.Glossary;
import Saurye.Elements.Mutual.Literary.Literary;
import Saurye.Elements.Mutual.Phrase.Phrase;
import Saurye.Elements.Mutual.Sentence.Sentence;
import Saurye.Elements.Mutual.Slang.Slang;
import Saurye.Elements.Mutual.Word.Word;
import Saurye.Elements.PivotAlchemist;

public class MutualAlchemist implements PivotAlchemist {
    private JSONObject      mElementPartProto;
    private AlchemistMaster mMaster;

    private Dictionary      mDictionaryElement;
    private Etymology       mEtymologyElement;
    private Extend          mExtendElement;
    private Fragment        mFragmentElement;
    private Glossary        mGlossaryElement;
    private Literary        mLiteraryElement;
    private Phrase          mPhraseElement;
    private Sentence        mSentenceElement;
    private Slang           mSlangElement;
    private Word            mWordElement;


    private void spawnGlobalElements(){
        this.mDictionaryElement = new Dictionary( this );
        this.mEtymologyElement  = new Etymology( this );
        this.mExtendElement     = new Extend( this );
        this.mFragmentElement   = new Fragment( this );
        this.mGlossaryElement   = new Glossary( this );
        this.mLiteraryElement   = new Literary( this );
        this.mPhraseElement     = new Phrase( this );
        this.mSentenceElement   = new Sentence( this );
        this.mSlangElement      = new Slang( this );
        this.mWordElement       = new Word( this );
    }

    public MutualAlchemist( AlchemistMaster master ){
        this.mMaster           = master;
        this.mElementPartProto = this.mMaster.getElementsProto().optJSONObject( this.rootName() );
        this.spawnGlobalElements();
    }

    public JSONObject getElementPartProto() {
        return this.mElementPartProto;
    }

    public AlchemistMaster getMaster() {
        return this.mMaster;
    }

    public String          tableName( String szSimpleTable ){
        return this.mMaster.tableName( szSimpleTable );
    }

    @Override
    public String rootName() {
        return Prototype.namespaceNode( this );
    }

    @Override
    public JSONObject elementPart( String szElementPartName ) {
        return this.getElementPartProto().optJSONObject( szElementPartName );
    }

    @Override
    public JSONObject tableFields( String szElementPartName ) {
        return this.elementPart( szElementPartName ).optJSONObject( "tables" );
    }

    @Override
    public JSONObject assetFields( String szElementPartName ) {
        return this.elementPart( szElementPartName ).optJSONObject( "assets" );
    }


    /** Global Element **/
    public Dictionary dict(){
        return this.mDictionaryElement;
    }

    public Etymology etym() {
        return this.mEtymologyElement;
    }

    public Extend    extend() {
        return this.mExtendElement;
    }

    public Fragment frag() {
        return this.mFragmentElement;
    }

    public Glossary glossary() {
        return this.mGlossaryElement;
    }

    public Literary literary() {
        return this.mLiteraryElement;
    }

    public Phrase phrase() {
        return this.mPhraseElement;
    }

    public Sentence sentence() {
        return this.mSentenceElement;
    }

    public Slang slang() {
        return this.mSlangElement;
    }

    public Word word(){
        return this.mWordElement;
    }

}
