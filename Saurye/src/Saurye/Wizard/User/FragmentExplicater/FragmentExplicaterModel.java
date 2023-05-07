package Saurye.Wizard.User.FragmentExplicater;

import Pinecone.Framework.System.util.StringUtils;
import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Pagesion;
import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.System.Prototype.JasperModifier;

import java.sql.SQLException;

@JasperModifier
public class FragmentExplicaterModel extends FragmentExplicater implements Pagesion {
    public FragmentExplicaterModel( ArchConnection connection ){
        super(connection);
    }

    protected String mszEnFragment;

    protected JSONObject mhRootExplication;

    @Override
    public void beforeGenieInvoke() throws Exception {
        super.beforeGenieInvoke();
        this.mszEnFragment                = this.$_GSC().optString( "query" );
        if( StringUtils.isEmpty( this.mszEnFragment ) ){
            this.redirect(this.spawnWizardActionSpell( "GeniusExplorer", "fragmentSearch" ) );
            this.stop();
        }

        this.mhRootExplication = new JSONObject();
        String szFragment = $_GSC().optString("query");
        this.mhRootExplication.put( "fragmentInfo",this.mysql().fetch(
                String.format( "SELECT `cn_rank_def` AS f_cn_def, `f_rank`, tFrags.`f_clan_name` AS f_clan FROM ( " +
                                "     ( SELECT tFrags.`f_clan_name`, tFrags.`f_stub_name` FROM %s AS tFrags WHERE `en_fragment` = '%s' ) AS tFrags " +
                                "LEFT JOIN %s AS tBand ON tBand.`f_stub_name` = tFrags.`f_stub_name` )",
                        this.alchemist().mutual().frag().tabFragsNS(),
                        szFragment,
                        this.alchemist().mutual().frag().tabBandNS()
                )
        ));
    }

    @Override
    public void defaultGenie() throws Exception {
        super.defaultGenie();
        fragmentProfile();
    }

    public void fragmentProfile() throws SQLException {
        String szFragment = $_GSC().optString("query");

        String szTabEpitomes = this.alchemist().mutual().frag().tabHomologuesNS();
        this.mhRootExplication.put(
                "fragmentEpitome", this.mysql().fetch(
                        String.format(  "SELECT tArchS.`w_epitome`, tArchS.`cn_infer`, tArchS.`c_def_id`," +
                                        "       tArch.`c_form_kin`, tArch.`cn_def`, tArch.`f_clan_name`, " +
                                        "       tArch.`en_fragment`, tArch.`ety_relevant`, tArch.`f_rank`, tArch.`cn_rank_def`," +
                                        "       tCnDict.`m_property`, tCnDict.`cn_means`" +
                                        "FROM " +
                                        "    (" +
                                        "      ( " +
                                        "       SELECT  tArch.`w_epitome`, tArch.`cn_infer`, tArch.`c_def_id`,tArch.`f_clan_name`," +
                                        "               tClan.`c_form_kin`, tCDef.`cn_def`, tCDef.`f_def_id`, tCDef.`id` AS `cd_id`," +
                                        "               tFrags.`en_fragment`, tCEtyD.`ety_relevant`, tBand.`f_rank`, tBand.`cn_rank_def` " +
                                        "       FROM " +
                                        "           (" +
                                        "            (" +
                                        "             (" +
                                        "              (" +
                                        "                (" +
                                        "                  ( " +
                                        "                    ( SELECT * FROM %s AS tArch WHERE tArch.`f_clan_name` = (" +
                                        "                       SELECT tFrags.`f_clan_name` FROM %s AS tFrags WHERE tFrags.`en_fragment` = '%s' AND tFrags.`f_prototype` = '' ) " +
                                        "                    ) AS tArch " +
                                        "                    LEFT JOIN %s AS tCDef ON tCDef.`f_clan_name` = tArch.`f_clan_name`" +
                                        "                  ) LEFT JOIN %s AS tClan ON tClan.`en_clan_name` = tArch.`f_clan_name` " +
                                        "                ) LEFT JOIN %s AS tFrags ON tFrags.`f_clan_name` = tArch.`f_clan_name` " +
                                        "              ) LEFT JOIN %s AS tFEtyD ON tFEtyD.`en_fragment` = tFrags.`f_stub_name`" +
                                        "             ) LEFT JOIN %s AS tCEtyD ON tCEtyD.`en_clan_name` = tFEtyD.`f_clan_name`" +
                                        "            ) LEFT JOIN %s AS tBand ON tBand.`f_stub_name` = tFrags.`f_stub_name`" +
                                        "           )  GROUP BY tCDef.`f_def_id` " +
                                        "      ) AS tArch LEFT JOIN %s AS tArchS ON tArchS.`c_def_id` = tArch.`f_def_id`" +
                                        "    ) LEFT JOIN ( " +
                                        "                  SELECT tCnDict.* FROM " +
                                        "                  ( " +
                                        "                     ( ( SELECT * FROM %s AS tArch WHERE tArch.`f_clan_name` = (" +
                                        "                            SELECT tFrags.`f_clan_name` FROM %s AS tFrags WHERE tFrags.`en_fragment` = '%s' AND tFrags.`f_prototype` = '' ) ) AS tArch" +
                                        "                        LEFT JOIN %s AS tAS ON tArch.`f_clan_name` = tAS.`f_clan_name` " +
                                        "                     ) LEFT JOIN %s AS tCnDict ON tCnDict.`en_word` = tAS.`w_epitome`  " +
                                        "                  ) GROUP BY tCnDict.`en_word`" +
                                        " ) AS tCnDict ON tCnDict.`en_word` = tArchS.`w_epitome` ORDER BY tArch.`cd_id` ",
                                szTabEpitomes, this.alchemist().mutual().frag().tabFragsNS(), szFragment,

                                this.alchemist().mutual().frag().tabCDefsNS(),
                                this.alchemist().mutual().frag().tabClansNS(),
                                this.alchemist().mutual().frag().tabFragsNS(),
                                this.alchemist().mutual().etym().tabFFragNS(),
                                this.alchemist().mutual().etym().tabFClansNS(),
                                this.alchemist().mutual().frag().tabBandNS(),
                                szTabEpitomes,

                                szTabEpitomes, this.alchemist().mutual().frag().tabFragsNS(), szFragment, szTabEpitomes,
                                this.alchemist().mutual().dict().tabEn2CnNS()
                        )
                )
        );

        this.mPageData.put( "FragmentExplication", this.mhRootExplication );
    }

    public void fragmentEtymology() throws SQLException {
        String szFragment = $_GSC().optString("query");

        this.mhRootExplication.put( "fragmentEtymology",this.mysql().fetch(
                String.format( " SELECT `w_epitome`,tClan.`en_clan_name` AS f_clan,`ety_relevant` AS f_relevant,`en_etymon_def` AS f_etymon , `en_simple_def` AS f_simple_def FROM ( " +
                                "         ( SELECT tFEty.`f_clan_name` FROM %s AS tFEty WHERE en_fragment = " +
                                "           (" +
                                "               SELECT f_stub_name FROM %s AS tFrags WHERE en_fragment = '%s' AND tFrags.`f_prototype` = ''" +
                                "           ) GROUP BY tFEty.`f_clan_name`" +
                                "    ) AS tFEty LEFT JOIN %s AS tClan ON tClan.`en_clan_name` = tFEty.`f_clan_name` " +
                                "LEFT JOIN %s AS tEpit ON tEpit.`f_clan_name` = tFEty.`f_clan_name`" +
                                ")",
                        this.alchemist().mutual().etym().tabFFragNS(),
                        this.alchemist().mutual().frag().tabFragsNS() ,szFragment,
                        this.alchemist().mutual().etym().tabFClansNS(),
                        this.alchemist().mutual().etym().tabFEpitomeNS()
                )
        ));



        this.mPageData.put( "FragmentExplication", this.mhRootExplication );
    }

}
