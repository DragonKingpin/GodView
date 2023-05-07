package Saurye.Peripheral.Skill.Util;

import Pinecone.Framework.Util.Random.SeniorRandom;
import Saurye.System.PredatorArchWizardum;

import java.io.File;

public class FileHelper {
    public static String randomName( String szPath, int nLength, String szExt ) {
        SeniorRandom random = new SeniorRandom( System.nanoTime());

        while ( true ){
            String szFileName = random.nextString( nLength ) + "." + szExt ;
            String szFilePath = szPath + szFileName ;
            if( !( new File( szFilePath ) ).exists() ){
                return szFileName;
            }
        }
    }

    public static boolean erase (PredatorArchWizardum soul, String szRelatePath ) {
        String szReal = soul.system().getSystemPath() + szRelatePath;
        return ( new File( szReal ) ).delete();
    }
}
