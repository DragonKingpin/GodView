package Saurye.Elements.Mutual.Fragment;

import Pinecone.Framework.Util.JSON.JSONArray;
import Saurye.Elements.StereotypicalElement;
import Saurye.Elements.Mutual.MutualAlchemist;
import Saurye.Elements.Mutual.OwnedElement;

import java.sql.SQLException;

public class Fragment extends OwnedElement implements StereotypicalElement {
    protected String mTabClans                 = "";
    protected String mTabFrags                 = "";
    protected String mTabBand                  = "";
    protected String mTabCDefs                 = "";
    protected String mTabHomologues            = "";

    public Fragment ( MutualAlchemist alchemist ){
        super( alchemist );
        this.tableJavaify( this, this.mTableProto );
    }

    @Override
    public String elementName() {
        return this.getClass().getSimpleName();
    }

    public String tabClans()      { return this.mTabClans; }
    public String tabFrags()      { return this.mTabFrags; }
    public String tabBand()       { return this.mTabBand; }
    public String tabCDefs()      { return this.mTabCDefs; }
    public String tabHomologues() { return this.mTabHomologues; }

    public String tabClansNS()      { return this.tableName( this.mTabClans ); }
    public String tabFragsNS()      { return this.tableName( this.mTabFrags ); }
    public String tabBandNS()       { return this.tableName( this.mTabBand ); }
    public String tabCDefsNS()      { return this.tableName( this.mTabCDefs ); }
    public String tabHomologuesNS() { return this.tableName( this.mTabHomologues ); }


    public JSONArray fetchCriticalNexus( String szWord ) throws SQLException {
        return this.mysql().fetch(
                String.format(  "SELECT  tArch.`w_epitome`, tArch.`c_def_id`," +
                                "        tClan.`c_form_kin`, tCDef.`cn_def`, tCDef.`f_clan_name`, tCDef.`f_def_id`, tCDef.`id` AS `cd_id`," +
                                "        tFrags.`en_fragment`, tCEtyD.`ety_relevant`, tBand.`f_rank`, tBand.`cn_rank_def` " +
                                "FROM " +
                                "     (" +
                                "      (" +
                                "       (" +
                                "        (" +
                                "          (" +
                                "            ( " +
                                "              ( SELECT * FROM %s AS tArch WHERE tArch.`w_epitome` = '%s' ) AS tArch " +
                                "              LEFT JOIN %s AS tCDef ON tCDef.`f_clan_name` = tArch.`f_clan_name`" +
                                "            ) LEFT JOIN %s AS tClan ON tClan.`en_clan_name` = tArch.`f_clan_name` " +
                                "          ) LEFT JOIN %s AS tFrags ON tFrags.`f_clan_name` = tArch.`f_clan_name` " +
                                "        ) LEFT JOIN %s AS tFEtyD ON tFEtyD.`en_fragment` = tFrags.`f_stub_name`" +
                                "       ) LEFT JOIN %s AS tCEtyD ON tCEtyD.`en_clan_name` = tFEtyD.`f_clan_name`" +
                                "      ) LEFT JOIN %s AS tBand ON tBand.`f_stub_name` = tFrags.`f_stub_name`" +
                                "     )  GROUP BY tCDef.`f_clan_name`",
                        this.tabHomologuesNS(), szWord,

                        this.tabCDefsNS(),
                        this.tabClansNS(),
                        this.tabFragsNS(),
                        this.owned().etym().tabFFragNS(),
                        this.owned().etym().tabFClansNS(),
                        this.tabBandNS()
                )
        );
    }

}