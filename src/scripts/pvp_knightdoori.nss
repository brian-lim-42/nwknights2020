#include "nwk_constants"

void main()
{
    object oPC=GetClickingObject();
    string team= GetLocalString(oPC,"team");

    DeleteLocalInt ( oPC, sMutex );
    location lDest;
    if (team=="SILVER")
    {
        lDest = GetLocation(GetObjectByTag("SILVER_KNIGHT_OUT"));
        AssignCommand(oPC, ActionJumpToLocation(lDest));
        JumpHenchmen(oPC, lDest, 6);
    }
    else if (team=="GOLD")
    {
        lDest = GetLocation(GetObjectByTag("GOLD_KNIGHT_OUT"));
        AssignCommand(oPC, ActionJumpToLocation(lDest));
        JumpHenchmen(oPC, lDest, 6);
    }
}
