package Saurye.Wizard.User.GeniusTranslator;

import Pinecone.Framework.System.util.StringUtils;
import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Pagesion;
import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.System.Prototype.JasperModifier;

import java.io.IOException;
import java.sql.SQLException;
import java.util.regex.Pattern;

@JasperModifier
public class GeniusTranslatorModel extends GeniusTranslator implements Pagesion {
    public GeniusTranslatorModel( ArchConnection connection ){
        super(connection);
    }

    protected String mszQuery;

    @Override
    public void beforeGenieInvoke() {
        this.mszQuery                = this.$_GSC().optString( "query" );
    }

    @Override
    public void defaultGenie() throws Exception {
        super.defaultGenie();
        this.sentenceProfile();
    }

    public void sentenceProfile() throws SQLException, IOException {
        if( !StringUtils.isEmpty( this.mszQuery ) ) {
            boolean bIsCnLike = Pattern.compile( "[\\u4E00-\\u9FA5]+" ).matcher( this.mszQuery ).find();
            boolean bIsPhrase = Pattern.compile( "[a-zA-Z0-9]\\s[a-zA-Z0-9]" ).matcher( this.mszQuery ).find();

            if( !bIsCnLike ){
                JSONObject jPhrase = new JSONObject();
                if( bIsPhrase ){
                    jPhrase.put ( "type", "phrase" );
                    jPhrase.put (
                            "phrasesList", this.alchemist().mutual().phrase().fetchDefAndEgSentencesByPhrase( this.mszQuery, "" )
                    );
                }
                else {
                    jPhrase.put( "type", "word" );
                    jPhrase.put (
                            "basicInfo", this.alchemist().mutual().word().fetchBasicInfo( this.mszQuery )
                    );
                    jPhrase.put (
                            "cnDefs", this.alchemist().mutual().dict().dictEn2Cn().fetchCnDefine( this.mszQuery )
                    );
                }
                this.mPageData.put( "phraseInfo", jPhrase );
            }


            JSONObject jSlang = new JSONObject();
            jSlang.put (
                    "slangDefEgSentences", this.alchemist().mutual().slang().fetchSlangDefEgSentences( this.mszQuery )
            );

            jSlang.put (
                    "slangDefs", this.alchemist().mutual().slang().fetchSlangDefs( this.mszQuery )
            );
            this.mPageData.put( "slangInfo", jSlang );

        }
    }

}
