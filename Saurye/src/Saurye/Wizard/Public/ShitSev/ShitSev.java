package Saurye.Wizard.Public.ShitSev;
import Pinecone.Framework.Util.Summer.ArchHostSystem;
import Pinecone.Framework.Util.Summer.Connectiom;
import Pinecone.Framework.Util.Summer.prototype.Servletson;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

//@WebServlet(name = "ShitSev", urlPatterns = {"/ShitSev"}, loadOnStartup = 1)
//@WebServlet("/")
public class ShitSev extends HttpServlet implements Servletson {
    private ArchHostSystem mSystem     = null             ;


    @Override
    public void init() throws ServletException {
        this.mSystem = ArchHostSystem.G_SystemServlet.getHostSystem();
    }

    @Override
    protected void doGet( HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {
        if( !request.getRequestURI().equals("/") ){
            response.sendError(404 );
            return;
        }
        this.mSystem.handleByDispatcher().handleGet( new Connectiom( request, response, this ) );
    }

    @Override
    protected void doPost( HttpServletRequest request, HttpServletResponse response ) throws ServletException, IOException {
        this.mSystem.handleByDispatcher().handlePost( new Connectiom( request, response, this ) );
    }

}
