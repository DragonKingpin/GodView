package Saurye.Elements.Mutual;

import Saurye.Elements.AlchemistMaster;
import Saurye.Elements.EpitomeElement;
import Saurye.Elements.MySQLBasedElement;

public interface MutualEpitomeElement extends MySQLBasedElement, EpitomeElement {
     MutualAlchemist owned();

    AlchemistMaster master();
}
