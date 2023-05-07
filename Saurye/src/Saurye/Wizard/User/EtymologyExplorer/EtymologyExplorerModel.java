package Saurye.Wizard.User.EtymologyExplorer;

import Pinecone.Framework.System.util.StringUtils;
import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Pagesion;
import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.Peripheral.Skill.Util.PaginateHelper;
import Saurye.System.Prototype.JasperModifier;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Vector;
import java.util.regex.Pattern;

@JasperModifier
public class EtymologyExplorerModel extends EtymologyExplorer implements Pagesion {
    public EtymologyExplorerModel( ArchConnection connection  ){
        super(connection);
    }

    @Override
    public void defaultGenie() throws Exception {
        super.defaultGenie();
        this.wordEtymomSearch();
        this.EtymonGrade();
    }

    public String filter ( String szCondition, Vector<String> conditionVector,String szContectType ){
        if(!conditionVector.isEmpty()) {
            if(szContectType.equals("AND")||szContectType.equals("OR")){
                for(String szKey:conditionVector ){
                    if(!StringUtils.isEmpty( $_GSC().optString( szKey ) )){
                        if( szCondition.isEmpty() ){
                            szCondition+=" WHERE "+String.format(" `%s` LIKE '%s' ",szKey,$_GSC().optString( szKey ));
                        }
                        else{
                            szCondition += String.format(" %s `%s` LIKE '%s' ",szContectType,szKey,$_GSC().optString( szKey ));
                        }

                    }
                }
            }

        }
        return szCondition;
    }

    public void EtymonGrade() throws SQLException{
        this.mPageData.put( "EtymonGrade",this.mysql().fetch(String.format( "SELECT `en_derived`,`en_weight`,`cn_def` FROM %s ",this.alchemist().mutual().etym().tabLinguaeNS())));
    }

    public void wordEtymomSearch() throws SQLException, IOException {
        String mszEnWord = $_GSC().optString("kw");
        JSONObject hWordExplication = new JSONObject();
        if (!StringUtils.isEmpty(mszEnWord)) {
            boolean bIsPhrase = Pattern.compile("[a-zA-Z0-9]\\s[a-zA-Z0-9]").matcher(mszEnWord).find();
            boolean bIsFuzzy  = mszEnWord.indexOf('%') >= 0;

            String szConditionSQL = "SELECT `en_word` FROM predator_w_etymon_derived_relevance AS tRel WHERE tRel.`en_word` LIKE '"+mszEnWord+"'";
            String szCountSQL     = String.format("SELECT %%S FROM %s %%s",this.alchemist().mutual().etym().tabCnPoSNS());
            String szCountConditionSQL = " WHERE en_word LIKE '"+mszEnWord+"'";

            int nPageLimit = this.coach().model().adjustablePaginationPreTreat( this, szCountSQL, szCountConditionSQL ,"COUNT(*)");

            hWordExplication.put(
                    "relevantSimple", this.mysql().fetch(
                            String.format(" SELECT  tRel.`en_word`, tRel.`ety_relevant`, tLing.`en_weight`, tLing.`e_direct_frequency`, tLing.`cn_def` FROM " +
                                            " ( SELECT * FROM %s AS tRel WHERE tRel.`en_word`IN (%s) ) AS tRel" +
                                            " LEFT JOIN %s AS tLing ON tRel.`ety_relevant` = tLing.`en_derived` ORDER BY `en_word`",
                                    this.alchemist().mutual().etym().tabRelevanceNS(), szConditionSQL,
                                    this.alchemist().mutual().etym().tabLinguaeNS()
                            )
                    )
            );

            hWordExplication.put(
                    "etymologyDefs",this.mysql().fetch(
                            String.format("SELECT tDefs.`en_word`,tDefs.`com_def` FROM %s AS tDefs,\n" +
                                            "(SELECT `def_id` FROM %s AS tEnDefs WHERE `en_word` IN \n" +
                                            "(%s) GROUP BY `en_word`) \n" +
                                            "AS tEnDef WHERE tEnDef.`def_id` = tDefs.`def_id`"+PaginateHelper.formatLimitSentence(
                                    this.mPageData.optLong( this.paginateProperty().getVarBeginNum() ), nPageLimit)
                                    ,this.alchemist().mutual().etym().tabDefsNS(),
                                    this.alchemist().mutual().etym().tabEnPoSNS(),szConditionSQL)
                    ));
        }

        this.mPageData.put("WordExplication", hWordExplication);
    }
}
