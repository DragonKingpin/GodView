package Saurye.Wizard.Admin.AdminMutualWordDepositor;

import Pinecone.Framework.System.util.StringUtils;
import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Pagesion;
import Saurye.Peripheral.Skill.Util.PaginateHelper;
import Saurye.System.Prototype.JasperModifier;

import javax.servlet.ServletException;
import java.io.IOException;
import java.sql.SQLException;

@JasperModifier
public class AdminMutualWordDepositorModel extends AdminMutualWordDepositor implements Pagesion {
    public AdminMutualWordDepositorModel( ArchConnection connection ){
        super(connection);
    }

    private class MutualIndexerCnEnSearcher {

    }


    @Override
    public void defaultGenie() throws Exception {
        super.defaultGenie();
        this.mutualWordsList();
    }

    public void mutualWordsList() throws SQLException {
        String szCoreIndexTable  = this.alchemist().mutual().word().tabWordNS();
        String szPhoneticInfoSQL = "";
        String szColumnInfo      = "tMutual.*, tDictEn2Cn.`cn_means` AS `cn_simple_mean`, tBand.`w_level_cache` AS `w_level` ";
        if( $_GSC().hasOwnProperty( "cn_word" ) || $_GSC().hasOwnProperty( "cn_fuzzy_index" ) || $_GSC().hasOwnProperty( "cn_fuzzy_def" ) ){
            szPhoneticInfoSQL = String.format( " LEFT JOIN %s AS tPh ON tMutual.`en_word` = tPh.`en_word` ", szCoreIndexTable );
            szColumnInfo += " , tPh.`us_phonetic_symbol`, tPh.`uk_phonetic_symbol`";
            if ( $_GSC().hasOwnProperty( "cn_fuzzy_def" ) ){
                szCoreIndexTable  = this.alchemist().mutual().dict().tabEn2CnNS();
            }
            else {
                szCoreIndexTable  = this.alchemist().mutual().dict().tabEnCnIndexNS();
            }
        }

        String szModularBasicSQL = String.format(
                "SELECT %%s FROM ( " +
                        "( " +
                        "  ( SELECT * FROM %s AS tMutual %%s ) AS tMutual " +
                        "  LEFT JOIN %s AS tDictEn2Cn ON tMutual.`en_word` = tDictEn2Cn.`en_word` AND BINARY tMutual.`en_word` = BINARY tDictEn2Cn.`en_word` " +
                        ")" +
                        " LEFT JOIN %s AS tBand ON tMutual.`en_word` = tBand.`en_word` AND BINARY tMutual.`en_word` = BINARY tBand.`en_word` " +
                " ) %s GROUP BY tDictEn2Cn.`en_word` ORDER BY tMutual.`id` ",
                szCoreIndexTable,
                this.alchemist().mutual().dict().tabEn2CnNS(),
                this.alchemist().mutual().glossary().tabBandNS(),
                szPhoneticInfoSQL
        );

        String szMutualConditionSQL    = "";
        String szEnWord                = this.$_GSC().optString( "en_word" );
        String szSelectEnWordSQL       = StringUtils.isEmpty( szEnWord ) ? "" : " tMutual.`en_word` LIKE '" + szEnWord + "'";
        if( !szSelectEnWordSQL.isEmpty() ){
            szMutualConditionSQL = " WHERE " + szSelectEnWordSQL;
        }

        String szCnWord                = this.$_GSC().optString( "cn_word" );
        if( $_GSC().hasOwnProperty( "cn_fuzzy_index" ) ){
            szCnWord                   = "%" + this.$_GSC().optString( "cn_fuzzy_index" ) + "%";
        }
        String szSelectCnWordSQL       = StringUtils.isEmpty( szCnWord ) ? "" : " tMutual.`cn_word` LIKE '" + szCnWord + "'";
        if( $_GSC().hasOwnProperty( "cn_fuzzy_def" ) ){
            szCnWord                   = "%" + this.$_GSC().optString( "cn_fuzzy_def" ) + "%";
            szSelectCnWordSQL          = StringUtils.isEmpty( szCnWord ) ? "" : " tMutual.`cn_means` LIKE '" + szCnWord + "'";
        }
        if( !szSelectCnWordSQL.isEmpty() ) {
            szMutualConditionSQL += ( szMutualConditionSQL.isEmpty() ? " WHERE " : " AND " ) + szSelectCnWordSQL;
        }

        String szCountSQL = String.format (
                "SELECT %%s FROM %s AS tMutual %%s", szCoreIndexTable
        );
        int nPageLimit = this.coach().model().adjustablePaginationPreTreat( this, szCountSQL, szMutualConditionSQL );

        this.mPageData.put (
                "WordsList", this.mysql().fetch(
                        String.format(
                                szModularBasicSQL ,
                                szColumnInfo,
                                szMutualConditionSQL + " " + PaginateHelper.formatLimitSentence(
                                        this.mPageData.optLong( this.paginateProperty().getVarBeginNum() ), nPageLimit
                                )
                        )
                )
        );
    }

    public void appendNewWord(){

    }

    public void wordEditor() throws IOException, ServletException, SQLException {
        String szModularBasicSQL = String.format(
                "SELECT %%s FROM %s AS tMutual LEFT JOIN %s AS tDictEn2Cn ON tMutual.en_word = tDictEn2Cn.en_word %%s",
                this.alchemist().mutual().word().tabWordNS(),
                this.alchemist().mutual().dict().tabEn2CnNS()
        );

        this.mPageData.put(
                "CurrentWordInfo", this.assertSelectResult(this.mysql().fetch(
                        String.format(
                                szModularBasicSQL ,
                                "tMutual.*",
                                " WHERE tMutual.id = '" + this.assertString( this.$_GSC().optString("id") ) + "'"
                        )
                        )
                ).optJSONObject(0)
        );
    }

}
