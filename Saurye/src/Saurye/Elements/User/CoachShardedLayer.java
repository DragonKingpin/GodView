package Saurye.Elements.User;

import Saurye.Elements.SkillBasedElement;
import Saurye.Peripheral.Skill.CoreCoach;

public abstract class CoachShardedLayer extends EpitomeSharded implements SkillBasedElement {
    protected CoachShardedLayer( OwnedElement stereotype ){
        super( stereotype );
    }

    @Override
    public CoreCoach coach(){
        return this.mStereotype.owned().getMaster().host().coach();
    }

}
