#include "nwk_constants"

void main()
{
    object oPlayer = GetLastUsedBy();
    location lDest;

    lDest = GetLocation(GetObjectByTag("FIRE_OUT"));
    AssignCommand(oPlayer, ActionJumpToLocation(lDest));
    JumpHenchmen(oPlayer, lDest, 1);

}
