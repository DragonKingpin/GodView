package Saurye.Peripheral.Skill.Util;

import java.text.SimpleDateFormat;
import java.util.Date;

public class DateHelper {
    public static String format( String szFmt ){
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat( szFmt );
        return simpleDateFormat.format( new Date() );
    }

    public static String formatYMD (){
        return DateHelper.format( "yyyy-MM-dd" );
    }

    public static String formatYMDHMS (){
        return DateHelper.format( "yyyy-MM-dd HH：mm：ss" );
    }


    public static String format( long nTime, String szFmt ) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat( szFmt );
        return simpleDateFormat.format( new Date( nTime ) );
    }

    public static String formatByBias( long nBias, String szFmt ) {
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat( szFmt );
        return simpleDateFormat.format( new Date( System.currentTimeMillis() + nBias ) );
    }

    public static String formatByBiasYMD( long nBias ) {
        return DateHelper.formatByBias( nBias, "yyyy-MM-dd" );
    }

    public static String formatByBiasYMDHMS( long nBias ) {
        return DateHelper.formatByBias( nBias, "yyyy-MM-dd HH：mm：ss" );
    }


    public static String formatByBiasYMD_Day    ( int nDay ) {
        return DateHelper.formatByBias( nDay * 1000 * 60 * 60 * 24, "yyyy-MM-dd" );
    }

    public static String formatByBiasYMDHMS_Day ( int nDay ) {
        return DateHelper.formatByBias( nDay * 1000 * 60 * 60 * 24, "yyyy-MM-dd HH：mm：ss" );
    }

}
