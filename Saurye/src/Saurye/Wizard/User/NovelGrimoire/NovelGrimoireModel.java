package Saurye.Wizard.User.NovelGrimoire;

import Pinecone.Framework.System.util.StringUtils;
import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Pagesion;
import Saurye.Peripheral.Skill.Util.PaginateHelper;
import Saurye.System.Prototype.JasperModifier;

import java.sql.SQLException;
import java.util.regex.Pattern;


@JasperModifier
public class NovelGrimoireModel extends NovelGrimoire implements Pagesion {
    public NovelGrimoireModel( ArchConnection connection ) {
        super(connection);
    }

    @Override
    public void defaultGenie() throws Exception {
        super.defaultGenie();
        this.novelList();
    }

    public void novelList() throws SQLException {
        String szKeyWord = $_GSC().optString("keyWord");
        String szConditionSQL = "";

        if( !StringUtils.isEmpty( szKeyWord ) ){
            boolean bIsCnLike = Pattern.compile( "[\\u4E00-\\u9FA5]+" ).matcher( szKeyWord ).find();
            if( !bIsCnLike ){
                szConditionSQL += " WHERE `en_title` LIKE '%" + szKeyWord + "%' OR `n_author` LIKE '%" + szKeyWord + "%' ";
            }
            else {
                szConditionSQL += " WHERE `cn_title` LIKE '%" + szKeyWord + "%' ";
            }
        }

        int nPageLimit = this.coach().model().adjustablePaginationPreTreat(this,
                String.format( "SELECT %%s FROM %s AS tNovels %%s", this.alchemist().mutual().literary().tabNovelsNS() ), szConditionSQL, "COUNT(*)"
        );

        this.mPageData.put( "NovelList", this.alchemist().mutual().literary().getNovelInfo(
                szConditionSQL + PaginateHelper.formatLimitSentence (
                this.mPageData.optLong( this.paginateProperty().getVarBeginNum() ), nPageLimit
        ), false ) );
    }

    public void novelProfile () throws SQLException {
        String szNovel = $_GSC().optString("en_title" );

        this.mPageData.put( "NovelInfo",this.alchemist().mutual().literary().getNovelInfo(
                String.format( "WHERE `en_title` = '%s'",szNovel ), true
        ));

        this.mPageData.put( "NovelChapters",this.mysql().fetch(
                String.format( "SELECT `en_name` AS chapters FROM %s WHERE `c_novel` = '%s'",
                        this.alchemist().mutual().literary().tabNVChaptersNS(),szNovel )
                )
        );
    }
}
