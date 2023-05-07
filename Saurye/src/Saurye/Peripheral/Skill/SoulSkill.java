package Saurye.Peripheral.Skill;

import Saurye.System.PredatorArchWizardum;

public interface SoulSkill extends SpecialSkill {
    void bind( PredatorArchWizardum soul ) ;

    PredatorArchWizardum mySoul();
}
