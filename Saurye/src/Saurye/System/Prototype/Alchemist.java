package Saurye.System.Prototype;

import Pinecone.Framework.Util.Summer.prototype.Citizen;

/**
 *  Hazelnut Alchemist [ Element Architect ]
 *  Copyright © 2008 - 2024 Bean Nuts Foundation ( DR.Undefined ) All rights reserved. [Mr.A.R.B / WJH]
 *  Tip:
 *  *****************************************************************************************
 *  Author: undefined
 *  Last Modified Date: 2021-03-16
 *  *****************************************************************************************
 *  "An alchemist was a scientist in the Middle Ages who tried to discover how to change
 *  ordinary metals into gold."
 *  Using alchemist in pinecone is define as "Who tried to discover how to change
 *  one element (Object) into another element (Object)."
 *  Alchemist could be considered as who only transfer 'metals' but not basic on magic.
 *  *****************************************************************************************
 *  ;) Hope you enjoy this
 */
public interface Alchemist extends Citizen {
    @Override
    default String vocationName(){
        return this.getClass().getSimpleName();
    }
}
