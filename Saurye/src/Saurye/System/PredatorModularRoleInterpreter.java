package Saurye.System;

public abstract class PredatorModularRoleInterpreter {
    public static int interpret( String szRole ){
        switch ( szRole ){
            case "Public":{
                return 0;
            }
            case "User":{
                return 1;
            }
            case "Admin":{
                return 2;
            }
            case "SuperAdmin":{
                return 3;
            }
            case "system":{
                return 4;
            }
            default:{
                return -1;
            }
        }
    }

    public static String interpret( int nRole ){
        switch ( nRole ){
            case 0:{
                return "Public";
            }
            case 1:{
                return "User";
            }
            case 2:{
                return "Admin";
            }
            case 3:{
                return "SuperAdmin";
            }
            case 4:{
                return "system";
            }
            default:{
                return null;
            }
        }
    }
}
