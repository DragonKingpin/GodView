package Saurye.Elements.Mutual.Literary;

import Pinecone.Framework.Util.JSON.JSONArray;
import Saurye.Elements.Mutual.MutualAlchemist;
import Saurye.Elements.Mutual.OwnedElement;
import Saurye.Elements.StereotypicalElement;

import java.sql.SQLException;

public class Literary extends OwnedElement implements StereotypicalElement {
    protected String mTabNVAuthor                  = "";
    protected String mTabNovels                    = "";
    protected String mTabNVSubstances              = "";
    protected String mTabNVChapters                = "";

    public Literary ( MutualAlchemist alchemist ){
        super( alchemist );
        this.tableJavaify( this, this.mTableProto );
    }

    @Override
    public String elementName() {
        return this.getClass().getSimpleName();
    }


    public String tabNVAuthor               (){ return this.mTabNVAuthor;   }
    public String tabNovels                 (){ return this.mTabNovels;     }
    public String tabNVSubstances           (){ return this.mTabNVSubstances; }
    public String tabNVChapters             (){ return this.mTabNVChapters;   }

    public String tabNVAuthorNS             (){ return this.tableName( this.mTabNVAuthor );     }
    public String tabNovelsNS               (){ return this.tableName( this.mTabNovels );       }
    public String tabNVSubstancesNS         (){ return this.tableName( this.mTabNVSubstances ); }
    public String tabNVChaptersNS           (){ return this.tableName( this.mTabNVChapters);    }


    public JSONArray getNovelInfo           ( String szConditionSQL, boolean bAllSynopsis ) throws SQLException {
        return this.mysql().fetch( String.format (
                "SELECT tNovels.*, tAuthors.`na_synopsis`, tAuthors.`cn_name` FROM " +
                        "( " +
                        "  SELECT tNovels.`id`, tNovels.`en_title`, tNovels.`cn_title`, tNovels.`n_author`, %s AS `note`, tNovels.`n_img` FROM %s AS tNovels %s " +
                        ") AS tNovels LEFT JOIN %s AS tAuthors ON tAuthors.`en_name` = tNovels.`n_author` ORDER BY `id`",
                bAllSynopsis? "tNovels.`n_synopsis`" : "LEFT( tNovels.`n_synopsis`, 100 )",
                this.tabNovelsNS() , szConditionSQL,
                this.tabNVAuthorNS()
        ) );
    }
}
