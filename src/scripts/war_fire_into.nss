#include "nwk_constants"

void main()
{
    object oPlayer = GetLastUsedBy();
    location lDest;

    lDest = GetLocation(GetObjectByTag("FIRE_IN"));
    AssignCommand(oPlayer, ActionJumpToLocation(lDest));
    JumpHenchmen(oPlayer, lDest, 1);

}
