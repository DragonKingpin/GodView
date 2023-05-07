package Saurye.Elements.User;

import Saurye.Elements.AlchemistMaster;
import Saurye.Elements.EpitomeElement;
import Saurye.Elements.MySQLBasedElement;

public interface UserEpitomeElement extends MySQLBasedElement, EpitomeElement {
    UserAlchemist owned();

    AlchemistMaster master();
}