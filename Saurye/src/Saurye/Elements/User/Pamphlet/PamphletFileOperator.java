package Saurye.Elements.User.Pamphlet;

import Saurye.Elements.EpitomeElement;
import Saurye.Elements.User.CoachShardedLayer;
import Saurye.Peripheral.Skill.MultipleSkill;
import Saurye.System.PredatorArchWizardum;

public class PamphletFileOperator extends CoachShardedLayer implements EpitomeElement {
    public PamphletFileOperator( Pamphlet stereotype ){
        super( stereotype );
    }

    @Override
    public String elementName() {
        return this.getClass().getSimpleName();
    }

    @Override
    public Pamphlet stereotype() {
        return (Pamphlet) this.mStereotype;
    }


    public MultipleSkill coverUploader( PredatorArchWizardum soul ) {
        PamphletIncarnation hProto = (PamphletIncarnation) soul;

        return this.coach().soulCoach( soul ).learned(
                "FileUploadSkill",
                "saveLocation", hProto.protoIncarnated().astCoverSrc()
        );
    }

}
