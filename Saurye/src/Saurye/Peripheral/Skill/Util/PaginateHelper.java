package Saurye.Peripheral.Skill.Util;

public class PaginateHelper {

    public static int getPageBegin( int pageID, int sumOfPage , int pageLimit ){
        double limitNum = Math.ceil( (double) sumOfPage / pageLimit );
        if (pageID == -1) {
            pageID = (int)limitNum;
        }
        return (pageID - 1) * pageLimit;
    }

    public static int getPageBeginDefault( Object pageID, int nPageDataSum ,int pageLimit ){
        int cPageID = 1;
        if( pageID != null ){
            cPageID = pageID instanceof Number ? ((Number)pageID).intValue() : Integer.parseInt((String)pageID);
        }

        return PaginateHelper.getPageBegin(cPageID,nPageDataSum,pageLimit);
    }

    public static String formatLimitSentence( long nBegin, long nLimit ){
        return String.format( " LIMIT %d , %d ", nBegin, nLimit );
    }

}
