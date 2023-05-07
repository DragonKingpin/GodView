package Saurye.Elements.User;

import Pinecone.Framework.System.Prototype.Prototype;
import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.Elements.AlchemistMaster;
import Saurye.Elements.PivotAlchemist;
import Saurye.Elements.User.Fragment.Fragment;
import Saurye.Elements.User.Pamphlet.Glossary.Glossary;
import Saurye.Elements.User.Pamphlet.Pamphlet;
import Saurye.Elements.User.Profile.Profile;
import Saurye.Elements.User.Word.Word;

public class UserAlchemist implements PivotAlchemist {
    private JSONObject      mElementPartProto;
    private AlchemistMaster mMaster;

    private Fragment        mFragmentElement;
    private Pamphlet        mPamphletElement;
    private Profile         mProfileElement;
    private Word            mWordElement;

    private void spawnGlobalElements() {
        this.mFragmentElement  = new Fragment ( this  );
        this.mPamphletElement  = new Pamphlet ( this );
        this.mProfileElement   = new Profile  ( this );
        this.mWordElement      = new Word     ( this );
    }

    public UserAlchemist( AlchemistMaster master ){
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

    public JSONObject tableFields( JSONObject proto ) {
        return proto.optJSONObject( "tables" );
    }

    @Override
    public JSONObject tableFields( String szElementPartName ) {
        return this.tableFields( this.elementPart( szElementPartName ) );
    }

    public JSONObject assetFields( JSONObject proto ) {
        return proto.optJSONObject( "assets" );
    }

    @Override
    public JSONObject assetFields( String szElementPartName ) {
        return this.assetFields( this.elementPart( szElementPartName ) );
    }













    public Fragment fragment () {
        return this.mFragmentElement;
    }

    public Glossary glossary () {
        return this.pamphlet().glossary();
    }

    public Pamphlet pamphlet () { return this.mPamphletElement; }

    public Profile profile   () {
        return this.mProfileElement;
    }

    public Word    word      () {
        return this.mWordElement;
    }

}
