void main()
{
    object oPC = GetLastUsedBy();
    if (!GetIsPC(oPC)) return;
    AssignCommand(oPC, ClearAllActions());
    object oTarget;
    location lTarget;
    oTarget = GetWaypointByTag("WL22" );
    lTarget = GetLocation(oTarget);
    if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;
    DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
    oTarget = oPC;
}
