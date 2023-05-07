package Saurye.System.Prototype;

import Pinecone.Framework.Util.Summer.prototype.JSONBasedControl;
import Pinecone.Framework.Util.Summer.prototype.Pagesion;
import Pinecone.Framework.Util.Summer.prototype.Wizard;
import Saurye.System.PredatorArchWizardum;

import javax.servlet.http.HttpServletRequest;

public class PredatorProto {
    /** Soul **/
    public static PredatorArchWizardum mySoul(HttpServletRequest request ){
        return (PredatorArchWizardum) request.getAttribute("Prototype");
    }

    public static Wizard wizard( HttpServletRequest request ){
        return (Wizard) request.getAttribute("Prototype");
    }

    public static Pagesion model(HttpServletRequest request ){
        return (Pagesion) request.getAttribute("Prototype");
    }

    public static JSONBasedControl controls( HttpServletRequest request ){
        return (JSONBasedControl) request.getAttribute("Prototype");
    }

    public static String jspMyName( Object that ){
        try {
            return that.getClass().getSimpleName().split("_")[0];
        }
        catch ( Exception E ){
            return "";
        }
    }
}
