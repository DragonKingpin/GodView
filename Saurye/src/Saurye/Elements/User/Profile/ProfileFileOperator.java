package Saurye.Elements.User.Profile;

import Saurye.Elements.EpitomeElement;
import Saurye.Elements.User.CoachShardedLayer;
import Saurye.Peripheral.Skill.MultipleSkill;
import Saurye.System.PredatorArchWizardum;


public class ProfileFileOperator extends CoachShardedLayer implements EpitomeElement {
    public ProfileFileOperator(Profile stereotype ){
        super( stereotype );
    }

    @Override
    public String elementName() {
        return this.getClass().getSimpleName();
    }

    @Override
    public Profile stereotype() {
        return (Profile) this.mStereotype;
    }


    public MultipleSkill avatarUploader( PredatorArchWizardum soul ){
        return this.coach().soulCoach( soul ).learned(
                "FileUploadSkill",
                "saveLocation", this.stereotype().astAvatarSrc()
        );
    }

}