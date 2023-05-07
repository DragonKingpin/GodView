package Saurye.Wizard.System.SystemCoven;

import Pinecone.Framework.Util.Summer.ArchConnection;
import Pinecone.Framework.Util.Summer.prototype.Pagesion;
import Pinecone.Framework.Util.Summer.prototype.ModelEnchanter;

import java.sql.SQLException;

@ModelEnchanter
public class SystemCovenModel extends SystemCoven implements Pagesion {
    public SystemCovenModel( ArchConnection connection ){
        super(connection);
    }

    @Override
    protected void appendDefaultPageDate(){

    }

    @Override
    @ModelEnchanter(false)
    public void defaultGenie() throws Exception {
        super.defaultGenie();
        this.writer().print( "undefined" );
    }

    @ModelEnchanter(false)
    public void getAllBandLevels() throws SQLException {
        this.writer().print( this.mysql().fetch(
                "SELECT `g_name`, `g_nickname` FROM " + this.alchemist().mutual().glossary().tabGlossaryNS() + " WHERE `gt_name` = 'band'" )
        );
    }

}
