package Saurye.System.Properties;

import Pinecone.Framework.Util.JSON.JSONObject;

public class Paginate {
    private JSONObject  mJsonProto    ;
    private String      mszQueryPageID;
    private String      mszQueryPageLimit;
    private String      mszWConfPageLimit;
    private String      mszVarPageDataSum;
    private String      mszVarPageLimit;
    private String      mszVarBeginNum;
    private int         mnPaginatePageMax;

    public Paginate ( JSONObject paginate ) {
        this.mJsonProto          = paginate;
        this.mszQueryPageID      = paginate.optString( "QueryPageID" );
        this.mszQueryPageLimit   = paginate.optString( "QueryPageLimit" );
        this.mszWConfPageLimit   = paginate.optString( "WConfPageLimit" );
        this.mszVarPageDataSum   = paginate.optString( "VarPageDataSum" );
        this.mszVarPageLimit     = paginate.optString( "VarPageLimit" );
        this.mszVarBeginNum      = paginate.optString( "VarBeginNum" );
        this.mnPaginatePageMax   = paginate.optInt   ( "PaginatePageMax" );
    }

    public JSONObject getJsonProto () {
        return this.mJsonProto;
    }

    public String getQueryPageID() {
        return this.mszQueryPageID;
    }

    public String getQueryPageLimit() {
        return this.mszQueryPageLimit;
    }

    public String getWConfPageLimit() {
        return this.mszWConfPageLimit;
    }

    public String getVarPageDataSum() {
        return this.mszVarPageDataSum;
    }

    public String getVarPageLimit() {
        return this.mszVarPageLimit;
    }

    public String getVarBeginNum () {
        return this.mszVarBeginNum;
    }

    public int getPaginatePageMax() {
        return this.mnPaginatePageMax;
    }
}
