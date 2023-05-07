package Saurye.Wizard.User.GeniusExplorer;

import Pinecone.Framework.System.util.StringUtils;
import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Pagesion;
import Saurye.Peripheral.Skill.Util.PaginateHelper;
import Saurye.Peripheral.Skill.Util.StringHelper;
import Saurye.System.Prototype.JasperModifier;

import java.io.IOException;
import java.sql.SQLException;
import java.util.regex.Pattern;

@JasperModifier
public class GeniusExplorerModel extends GeniusExplorer implements Pagesion {
    public GeniusExplorerModel( ArchConnection connection ){
        super(connection);
    }

    @Override
    public void defaultGenie() throws Exception {
        super.defaultGenie();
        this.wordSearch();
    }

    public void wordSearch() throws SQLException, IOException {
        String szKeyWord = this.$_GSC().optString( "kw" );
        if( !StringUtils.isEmpty( szKeyWord ) ){
            boolean bIsCnLike = Pattern.compile( "[\\u4E00-\\u9FA5]+" ).matcher( szKeyWord ).find();
            boolean bIsPhrase = Pattern.compile( "[a-zA-Z0-9]\\s[a-zA-Z0-9]" ).matcher( szKeyWord ).find();
            boolean bIsFuzzy  = szKeyWord.indexOf( '%' ) >= 0;

            if( !bIsCnLike && !bIsPhrase && !bIsFuzzy ){
                this.redirect( this.querySpell().queryWord( szKeyWord ) );
                this.stop();
            }
            else if( bIsPhrase ){
                this.redirect( this.querySpell().translatePhrase( szKeyWord ) );
                this.stop();
            }
            else {
                String szPhoneticInfoSQL = "";
                String szColumnInfo      = "tMutual.*, tDictEn2Cn.`cn_means`, tDictEn2Cn.`m_property`, tCnI.`cn_word`, tBand.`w_level_cache` AS `w_level`, tFreq.`w_freq_base` ";
                String szMutualConditionSQL    = "";
                String szIndexTabSQL     = String.format(
                        "SELECT tMutual.* FROM %s AS tMutual %%s", this.alchemist().mutual().word().tabWordNS()
                );
                String szCountSQL = String.format (
                        "SELECT %%s FROM %s AS tMutual  %%s", this.alchemist().mutual().word().tabWordNS()
                );
                String szDictionaryProtoSQL = String.format(
                        "SELECT %%%%s FROM ( " +
                                " ( " +
                                "   ( " +
                                "     (" +
                                "       ( %%s ) AS tMutual " +
                                "       LEFT JOIN %s AS tDictEn2Cn ON tDictEn2Cn.`en_word` = tMutual.`en_word` AND BINARY tMutual.`en_word` = BINARY tDictEn2Cn.`en_word` " +
                                "     ) LEFT JOIN %s AS tCnI ON tCnI.`en_word` = tMutual.`en_word` AND BINARY tCnI.`en_word` = BINARY tMutual.`en_word`" +
                                "   ) LEFT JOIN %s AS tBand ON tBand.`en_word` = tMutual.`en_word` AND BINARY tMutual.`en_word` = BINARY tBand.`en_word` " +
                                " ) LEFT JOIN %s AS tFreq ON tFreq.`en_word` = tMutual.`en_word` " +
                                ") %%s ORDER BY IF( tFreq.`w_freq_base` IS NULL , 99999999, tFreq.`w_freq_base` ), tMutual.`id` ",
                        this.alchemist().mutual().dict().tabEn2CnNS(),
                        this.alchemist().mutual().dict().tabEnCnIndexNS(),
                        this.alchemist().mutual().glossary().tabBandNS(),
                        this.alchemist().mutual().word().tabWeightUnionBaseNS()
                );

                if( bIsFuzzy && !bIsCnLike ){
                    szMutualConditionSQL = " WHERE tMutual.`en_word` LIKE '" + szKeyWord + "'";
                }
                else if( bIsCnLike ){
                    szPhoneticInfoSQL = String.format( " LEFT JOIN %s AS tPh ON tPh.`en_word` = tMutual.`en_word` ", this.alchemist().mutual().word().tabWordNS() );
                    szColumnInfo += " , tPh.`us_phonetic_symbol`, tPh.`uk_phonetic_symbol`";

                    if( !bIsFuzzy ){
                        szMutualConditionSQL = " WHERE tCnI.`cn_word` = '" + szKeyWord + "'" ;
                        szIndexTabSQL     = String.format(
                                "SELECT tCnI.* FROM %s AS tCnI %s",
                                this.alchemist().mutual().dict().tabEnCnIndexNS(), szMutualConditionSQL
                        );
                        szCountSQL = String.format (
                                "SELECT %%s FROM %s AS tCnI %%s", this.alchemist().mutual().dict().tabEnCnIndexNS()
                        );
                    }
                    else {
                        String szCnProtoTabSQL     = String.format(
                                "SELECT %%s FROM (" +
                                        "SELECT tCnI.`id`, tCnI.`en_word` FROM %s AS tCnI WHERE tCnI.`cn_word` LIKE '%s'  " +
                                        "UNION " +
                                        "SELECT tCnD.`id`,tCnD.`en_word` FROM %s AS tCnD WHERE tCnD.`cn_means` LIKE '%s'   " +
                                ") AS tMutual GROUP BY `en_word` " ,
                                this.alchemist().mutual().dict().tabEnCnIndexNS(), StringHelper.safeFmtString( szKeyWord, "%%%%" ),
                                this.alchemist().mutual().dict().tabEn2CnNS(), StringHelper.safeFmtString( szKeyWord, "%%%%" )
                        );
                        szIndexTabSQL = String.format( szCnProtoTabSQL, "*" );
                        szMutualConditionSQL = "";
                        szCountSQL    = "SELECT %s FROM ( " + szIndexTabSQL + " ) AS tCount %s ";
                        szIndexTabSQL += "%s"; // For limit

                        trace( szCountSQL );
                    }
                }

                int nPageLimit = this.coach().model().adjustablePaginationPreTreat( this, szCountSQL, szMutualConditionSQL );
                String szDictionarySQL = String.format( szDictionaryProtoSQL, szIndexTabSQL, szPhoneticInfoSQL );
                this.mPageData.put (
                        "WordsList", this.mysql().fetch(
                                String.format (
                                        szDictionarySQL ,
                                        szColumnInfo,
                                        szMutualConditionSQL + " " + PaginateHelper.formatLimitSentence(
                                                this.mPageData.optLong( this.paginateProperty().getVarBeginNum() ), nPageLimit
                                        )
                                )
                        )
                );
            }


        }
    }

    public void fragmentSearch() throws SQLException {
        String szKeyWord = $_GSC( ).optString("kw");
        String szAttentiveness = "f_stub_name";
        if( szKeyWord.indexOf('-') != -1 ){
            szAttentiveness = "en_fragment";
        }

        if( !szKeyWord.isEmpty() ){
            String szSelectSql = "SELECT tFrags.`id` AS f_id , en_fragment AS f_en,cn_def  AS f_cn, tFrags.f_clan_name AS f_clan FROM " +
                    "%s AS tFrags LEFT JOIN %s AS tDef ON tDef.f_clan_name = tFrags.f_clan_name WHERE %s LIKE '%s' " +
                    "GROUP BY f_en %s ";
            String szCountSQL = String.format (
                    "SELECT %%s FROM %s AS tMutual %%s",
                    this.alchemist().mutual().frag().tabFragsNS()
            );

            String  szMutualConditionSQL = String.format( "WHERE f_stub_name LIKE '%s'", szKeyWord );

            int nPageLimit = this.coach().model().adjustablePaginationPreTreat( this, szCountSQL, szMutualConditionSQL );

            this.mPageData.put( "searchFragmentList",this.mysql().fetch(
                    String.format( szSelectSql,
                            this.alchemist().mutual().frag().tabFragsNS(),
                            this.alchemist().mutual().frag().tabCDefsNS(),
                            szAttentiveness,
                            szKeyWord,
                            PaginateHelper.formatLimitSentence(
                                    this.mPageData.optLong( this.paginateProperty().getVarBeginNum() ), nPageLimit
                            )
                    )
            ) );

        }


    }

}
