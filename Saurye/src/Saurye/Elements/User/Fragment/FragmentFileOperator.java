package Saurye.Elements.User.Fragment;

import Saurye.Elements.EpitomeElement;
import Saurye.Elements.User.CoachShardedLayer;
import Saurye.Peripheral.Skill.MultipleSkill;
import Saurye.System.PredatorArchWizardum;

public class FragmentFileOperator extends CoachShardedLayer implements EpitomeElement {
    public FragmentFileOperator(Fragment stereotype ){
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


    public MultipleSkill coverUploader(PredatorArchWizardum soul ){
        return this.coach().soulCoach( soul ).learned(
                "FileUploadSkill",
                "saveLocation", this.stereotype().astCoverSrc()
        );
    }

}