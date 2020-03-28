// NWTACTICS by Jhenne  (tallonzek@hotmail.com)
// 07/07/02
// Red Gate OnFailToOpen script, lets teammembers and their pets through.
// see the bluegate script for a fully commented version

void main()
{
    object oUser = GetClickingObject();
    string sTeam = GetLocalString(oUser, "team");
    object oDoor = OBJECT_SELF;
    if (sTeam == "SILVER")
    {
        ActionOpenDoor(oDoor);
    }
    else if (GetStandardFactionReputation(STANDARD_FACTION_MERCHANT, oUser) == 60 && !GetIsPC(oUser))
    {
        ActionOpenDoor(oDoor);
        DelayCommand(15.0, AssignCommand(oDoor,ActionCloseDoor(oDoor)));

    }
}

