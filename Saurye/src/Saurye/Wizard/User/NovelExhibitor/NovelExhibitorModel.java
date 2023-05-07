package Saurye.Wizard.User.NovelExhibitor;

import Pinecone.Framework.System.util.StringUtils;
import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Pagesion;
import Pinecone.Framework.Util.JSON.JSONArray;
import Pinecone.Framework.Util.JSON.JSONObject;
import Saurye.System.Prototype.JasperModifier;

import java.sql.SQLException;

@JasperModifier
public class NovelExhibitorModel extends NovelExhibitor implements Pagesion {
    public NovelExhibitorModel( ArchConnection connection ) {
        super(connection);
    }

    @Override
    public void defaultGenie() throws Exception {
        super.defaultGenie();
        showNovelChapterContent();
    }

    public void showNovelChapterContent() throws SQLException{
        String szNovel   = $_GSC().optString("novel" );
        String szChapter = $_GSC().optString( "chapter" );
        int chapterNum   = Integer.parseInt( szChapter );

        JSONArray novelChapters = this.mysql().fetch(
                String.format( "SELECT `en_name` AS chapters FROM %s WHERE `c_novel` = '%s'",
                        this.alchemist().mutual().literary().tabNVChaptersNS(),szNovel ) );
        if( novelChapters.length()< Integer.parseInt(szChapter) ) {
            chapterNum = novelChapters.length()-1;
        }
        JSONObject chapterInfo = new JSONObject();

        String szChapterName = novelChapters.getJSONObject( chapterNum ).getString("chapters" );

        chapterInfo.put( "chapter",szChapter );
        chapterInfo.put( "chapterName",szChapterName );

        this.mPageData.put( "novelInfo",this.alchemist().mutual().literary().getNovelInfo( String.format( "WHERE `en_title` = '%s'",szNovel), true ));
        this.mPageData.put( "chapterContent",this.mysql().fetch(
                String.format(
                "SELECT `s_content`,`s_e_class`,`s_element` FROM\n" +
                "        %s AS substances\n" +
                "WHERE `s_novel` = '%s' AND `s_chapter` = '%s'"
                        ,this.alchemist().mutual().literary().tabNVSubstancesNS()
                        ,szNovel, StringUtils.addSlashes( szChapterName )
                ) ));
        this.mPageData.put( "chapterInfo",chapterInfo );

    }
}
