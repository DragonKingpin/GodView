package Saurye.System.Auxiliary;

import Saurye.System.PredatorArchWizardum;
import Saurye.Wizard.Public.UnifyLogin.UnifyLogin;
import Saurye.Wizard.User.GeniusExplorer.GeniusExplorer;
import Saurye.Wizard.User.GeniusTranslator.GeniusTranslator;
import Saurye.Wizard.User.PersonalSentences.PersonalSentences;
import Saurye.Wizard.User.WordExplicater.WordExplicater;

import java.util.Iterator;
import java.util.Map;

public class QuerySpell {
    private PredatorArchWizardum mSoul;

    public QuerySpell( PredatorArchWizardum soul ){
        this.mSoul = soul;
    }

    PredatorArchWizardum soul(){
        return this.mSoul;
    }


    public String spawnWizardActionSpell ( String szPrototype, String szActionFnName ){
        return this.mSoul.spawnWizardActionSpell( szPrototype, szActionFnName );
    }

    public String spawnWizardControlSpell ( String szPrototype, String szControlFnName ){
        return this.mSoul.spawnWizardControlSpell( szPrototype, szControlFnName );
    }

    public String spawnActionQuerySpell(){
        return this.mSoul.spawnActionQuerySpell( );
    }

    public String spawnControlQuerySpell(){
        return this.mSoul.spawnControlQuerySpell( );
    }

    public String spawnKeyValuesQueryPartSpell( Map keyValuesJsonMap ){
        StringBuilder partQueryString = new StringBuilder();

        Iterator iterator = keyValuesJsonMap.entrySet().iterator();
        Map.Entry entry;
        while ( iterator.hasNext() ) {
            entry = (Map.Entry) iterator.next();
            partQueryString.append( entry.getKey() ).append( "=" ).append( (String) entry.getValue() );
            if( iterator.hasNext() ){
                partQueryString.append( "&" );
            }
        }
        return partQueryString.toString();
    }

    public String spawnActionQuerySpell( String szActionFunctionName, Map keyValuesJsonMap ){
        return this.mSoul.spawnActionQuerySpell( szActionFunctionName ) + "&" + this.spawnKeyValuesQueryPartSpell( keyValuesJsonMap );
    }

    public String spawnControlQuerySpell( String szControlFunctionName, Map keyValuesJsonMap ){
        return this.mSoul.spawnControlQuerySpell( szControlFunctionName ) + "&" + this.spawnKeyValuesQueryPartSpell( keyValuesJsonMap );
    }



    public String wordExplicaterSpell() {
        return this.spawnWizardActionSpell( WordExplicater.class.getSimpleName(), null );
    }

    public String queryWord( String szWord ){
        return this.wordExplicaterSpell() + "&query=" + szWord;
    }

    public String geniusExplorerSpell( String szAction ){
        return this.spawnWizardActionSpell( GeniusExplorer.class.getSimpleName(), szAction );
    }

    public String geniusTranslatorSpell(){
        return this.spawnWizardActionSpell( GeniusTranslator.class.getSimpleName(), null );
    }

    public String translatePhrase( String szPhrase ){
        return this.geniusTranslatorSpell() + "&query=" + szPhrase;
    }



    public String userSentenceSpell() {
        return this.spawnWizardActionSpell( PersonalSentences.class.getSimpleName(), null );
    }

    public String searchUserSentence( String szWord ){
        return this.spawnWizardActionSpell( PersonalSentences.class.getSimpleName(), "megaPamphlet" ) +
                "&linkedWord=" + szWord;
    }



    public String gotoLogin () {
        return this.spawnWizardActionSpell( UnifyLogin.class.getSimpleName() , "" );
    }
}
