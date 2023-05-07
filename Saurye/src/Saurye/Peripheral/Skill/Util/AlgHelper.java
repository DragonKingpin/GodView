package Saurye.Peripheral.Skill.Util;

import Pinecone.Framework.System.util.CharactersUtils;

import java.util.*;

public class AlgHelper {
    public static void moleculify ( char[] objs, Map<Character, Integer > moleculeMap ){
        for ( char obj : objs ) {
            if( !moleculeMap.containsKey( obj ) ){
                moleculeMap.put( obj, 0 );
            }
            moleculeMap.put( obj, (int)moleculeMap.get(obj) + 1 );
        }
    }

    public static String molecularFormulaify( Map<Character, Integer > moleculeMap ){
        StringBuilder sb = new StringBuilder();
        for ( Object obj : moleculeMap.entrySet() ) {
            Map.Entry kv = (Map.Entry) obj;
            sb.append( kv.getKey() );
            int nAtom = (int) kv.getValue();
            if( nAtom != 1 ){
                sb.append( nAtom );
            }
        }
        return sb.toString();
    }

    public static String molecularFormulaify( char[] objs ){
        Map<Character, Integer > map = new TreeMap<>();
        AlgHelper.moleculify( objs, map );
        return AlgHelper.molecularFormulaify( map );
    }

    public static double entropify ( char[] objs, Map<Character, Integer > moleculeMap ){
        AlgHelper.moleculify( objs, moleculeMap );

        double nEntropy = 0.0;
        int    nSum     = objs.length;
        for ( Object obj : moleculeMap.entrySet() ) {
            Map.Entry kv = (Map.Entry) obj;
            double nP    = ( (double) (int) kv.getValue() ) / nSum;
            nEntropy+= nP * Math.log( nP );
        }
        return - nEntropy;
    }

    public static Vector<Character > vectorify( char[] objs ) {
        Vector<Character > characters = new Vector<>( objs.length );
        for ( int i = 0; i < objs.length; i++ ) {
            characters.add( objs[i] );
        }
        return characters;
    }

    public static Vector<Vector<Character > > vectorifyArrays( ArrayList<String > objs ) {
        Vector<Vector<Character > > charss = new Vector<>( objs.size() );
        for ( int i = 0; i < objs.size(); i++ ) {
            charss.add( AlgHelper.vectorify( objs.get(i).toCharArray() ) );
        }
        return charss;
    }

    public static String[] mirroifyString( String szThat ) {
        int nBias = szThat.length() % 2 != 0 ? 1 : 0;
        int nMid  = szThat.length() / 2;

        String[]  debris      = new String[3];
        debris[0] = szThat.substring( 0, nMid );
        debris[1] = szThat.substring( nMid ,nMid + nBias  );
        debris[2] = szThat.substring( nMid + nBias );

        return debris;
    }

    public static ArrayList<String > atomify( String szThat ){
        ArrayList<String > res = new ArrayList<>();
        Map<String,Boolean > atoms = new TreeMap<>();
        Map<Character,Boolean > charMap = new TreeMap<>();
        String szTemp = "";
        for( int i = 0;i < szThat.length(); i++ ){
            char element = szThat.charAt(i);
            szTemp += element;
            charMap.put( element, true );
            if( i == szThat.length() - 1 || charMap.get(szThat.charAt(i+1)) != null ){
                if( atoms.get(szTemp) == null ){
                    res.add( szTemp );
                }
                atoms.put( szTemp, true );
                szTemp = "";
                charMap.clear();
            }
        }

        res.sort( ( String sz1, String sz2 )-> {
            return sz2.length() - sz1.length();
        });

        return res;
    }



    public static boolean isIsomer_SortedThat( char[] arrThis, char[] arrSortedThat, boolean bNoCase ) {
        if( bNoCase ){
            CharactersUtils.toLower( arrThis );
        }
        Arrays.sort( arrThis );
        return Arrays.equals( arrThis, arrSortedThat );
    }

    public static boolean isIsomer( char[] arrThis, char[] arrThat, boolean bNoCase ) {
        if( bNoCase ){
            CharactersUtils.toLower( arrThis );
            CharactersUtils.toLower( arrThat );
        }
        Arrays.sort( arrThis );
        Arrays.sort( arrThat );
        return Arrays.equals( arrThis, arrThat );
    }

    public static boolean isIsomer( String szThis, String szThat, boolean bNoCase ) {
        if( szThis.length() == szThat.length() ){
            char[] arrThis = szThis.toCharArray();
            char[] arrThat=  szThat.toCharArray();

            return AlgHelper.isIsomer( arrThis, arrThat, bNoCase );
        }
        return false;
    }

    public static Map<String, ArrayList<String > > spawnSortedCharSeqMap( List list, boolean bNoCase ){
        Map<String, ArrayList<String > > sortedCharSeq = new TreeMap<>();

        for( Object obj : list ){
            String szWord = (String) obj;
            char[] array = bNoCase ? CharactersUtils.toLower( szWord.toCharArray() ) : szWord.toCharArray();
            Arrays.sort( array );

            String szSortedWord = new String( array );
            if( !sortedCharSeq.containsKey( szSortedWord ) ){
                sortedCharSeq.put( szSortedWord, new ArrayList<>() );
            }
            sortedCharSeq.get( szSortedWord ).add( szWord );
        }
        return sortedCharSeq;
    }

    public static ArrayList<String > searchIsomer( String szThat, Map<String, ArrayList<String > > sortedCharSeq, boolean bNoCase ){
        char[] array = bNoCase ? CharactersUtils.toLower( szThat.toCharArray() ) : szThat.toCharArray();
        Arrays.sort( array );
        String szSortedWord = new String( array );

        return sortedCharSeq.get( szSortedWord );
    }

    public static ArrayList<String > searchIsomer( String szThat, List list, boolean bNoCase ){
        return AlgHelper.searchIsomer( szThat, AlgHelper.spawnSortedCharSeqMap( list, bNoCase ), bNoCase );
    }

    public static Map<String, ArrayList<String > > spawnSortedOnlyCharSeqMap( List list, boolean bNoCase ){
        Map<String, ArrayList<String > >  sortedCharSeq  = new TreeMap<>();

        for( Object obj : list ){
            String szWord = (String) obj;

            Map<Character, Integer >          moleculeMap    = new TreeMap<>();
            char[] array = bNoCase ? CharactersUtils.toLower( szWord.toCharArray() ) : szWord.toCharArray();
            AlgHelper.moleculify( array, moleculeMap );
            Object[] onlyChars = moleculeMap.keySet().toArray();

            String szSortedWord = new String( CharactersUtils.toChars(onlyChars) );
            if( !sortedCharSeq.containsKey( szSortedWord ) ){
                sortedCharSeq.put( szSortedWord, new ArrayList<>() );
            }
            sortedCharSeq.get( szSortedWord ).add( szWord );
        }
        return sortedCharSeq;
    }

    public static String toAtomSequence( Map<Character, Integer > moleculeMap ){
        Object[] onlyChars = moleculeMap.keySet().toArray();
        return new String( CharactersUtils.toChars(onlyChars) );
    }

    public static String toAtomSeries( Map<Character, Integer > moleculeMap ){
        StringBuilder sb = new StringBuilder();
        for ( Map.Entry kv : moleculeMap.entrySet() ) {
            Character atom = (Character) kv.getKey();
            int n          = (int) kv.getValue();

            for ( int i = 0; i < n; i++ ) {
                sb.append( atom );
            }
        }
        return sb.toString();
    }

    public static ArrayList<String > searchAllotropy( String szThat, Map<String, ArrayList<String > > sortedCharSeq, boolean bNoCase ){
        char[] array = bNoCase ? CharactersUtils.toLower( szThat.toCharArray() ) : szThat.toCharArray();

        Map<Character, Integer >          moleculeMap    = new TreeMap<>();
        AlgHelper.moleculify( array, moleculeMap );
        String szSortedWord = AlgHelper.toAtomSequence( moleculeMap );

        return sortedCharSeq.get( szSortedWord );
    }

    public static ArrayList<String > searchAllotropy( String szThat, List list, boolean bNoCase ){
        return AlgHelper.searchAllotropy( szThat, AlgHelper.spawnSortedOnlyCharSeqMap( list, bNoCase ), bNoCase );
    }



    public static ArrayList<String > chunkify( String szThat, int nMinChunk, int nMaxChunk ){
        ArrayList<String > substrs = new ArrayList<>();
        if( szThat.isEmpty() ){
            return substrs;
        }

        int nRealChunk = szThat.length() < nMinChunk ? szThat.length() : nMinChunk;

        int nAvg = ( nMinChunk + nMaxChunk ) / 2;

        if( szThat.length() >= nMinChunk + nMaxChunk ){
            if ( szThat.length() > nMaxChunk ){
                nRealChunk = nMaxChunk;
            }
        }
        else if( szThat.length() > nAvg ){
            nRealChunk = nAvg;
        }

        int nChunkNum = szThat.length() / nRealChunk;

        for ( int i = 0; i < nChunkNum; i++ ) {
            substrs.add( szThat.substring( i * nRealChunk,  i * nRealChunk + nRealChunk ) );
        }

        String szLast = szThat.substring( nChunkNum * nRealChunk );
        if( !szLast.isEmpty() ){
            substrs.add( szLast );
        }

        return substrs;
    }

    public static String[]           goldify( String szThat ){
        int nMid  = (int)Math.round( (double) szThat.length() * 0.618 );
        return new String[]{
                szThat.substring( 0, nMid ), szThat.substring( nMid )
        };
    }

}
