package Saurye.Elements.User.Fragment;

import Saurye.Elements.EpitomeElement;
import Saurye.Elements.User.EpitomeSharded;
import Saurye.Elements.User.Fragment.FragmentFetcher.BasicRootList;

public class FragmentRootFetcher extends EpitomeSharded implements EpitomeElement {
    public FragmentRootFetcher( Fragment stereotype ){
        super( stereotype );
    }

    @Override
    public String elementName() {
        return this.getClass().getSimpleName();
    }

    @Override
    public Fragment stereotype() {
        return (Fragment) this.mStereotype;
    }


    private BasicRootList mBasicRootList = null;

    public BasicRootList basicRootList () {
        if( this.mBasicRootList == null ){
            this.mBasicRootList = new BasicRootList( this.stereotype() );
        }
        return this.mBasicRootList;
    }

    public BasicRootList basicRootList ( String sqlInnerIndex ){
        return this.basicRootList().apply( sqlInnerIndex );
    }

    public BasicRootList basicRootList ( String sqlInnerIndex, String sqlOuterCondition ) {
        return this.basicRootList().apply( sqlInnerIndex, sqlOuterCondition );
    }

    public BasicRootList basicRootList ( String sqlInnerIndex, String sqlInnerCondition, String sqlOuterCondition ) {
        return this.basicRootList().apply( sqlInnerIndex, sqlInnerCondition, sqlOuterCondition );
    }

    public String getUserRootInnerSQL( String szClassId ) {
        return this.getUserRootInnerSQL( "tUD.*", szClassId );
    }

    public String getUserRootInnerSQL( String szColumn, String szClassId ) {
        return String.format( "SELECT %s FROM %s AS tUIdx WHERE tUIdx.`classid` = '%s' %%s",
                szColumn, master().user().fragment().tabRootsNS(), szClassId
        );
    }

}
