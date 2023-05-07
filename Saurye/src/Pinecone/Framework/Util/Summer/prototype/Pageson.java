package Pinecone.Framework.Util.Summer.prototype;

import Pinecone.Framework.Util.JSON.JSONObject;

import javax.servlet.ServletException;
import java.io.IOException;
import java.lang.reflect.Method;

public interface Pageson extends Wizard {
    JSONObject getPageData();

    String toJSONString();

    String getModelCommand();

    void setRenderum( Method fnRenderum );

    void render() throws ServletException, IOException;

    void setEnchanterRole( boolean bRole );

    boolean isEnchanter();
}
