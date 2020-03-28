//on gold door

// NWTACTICS By Jhenne (tallonzek@hotmail.com)
// 07/07/02
// Team Door script, only allows red team through.
void main()
{
    object oPC=GetClickingObject();
    if (oPC == OBJECT_INVALID)
        oPC=GetLastUsedBy ();

    string sTeam = GetLocalString (oPC, "team");
    location lDest = GetLocation(GetObjectByTag("GOLDSTART"));
    object oHenchMan = GetHenchman (oPC);

    // only let the PC through if he is silver team and not carrying the flag or ball

    if ((sTeam == "GOLD") && (GetLocalInt(oPC,"hasgoldflag")==0) && (GetTag(oHenchMan) != "LightBall"))
    {
            SetStandardFactionReputation(STANDARD_FACTION_COMMONER, 50, oPC);
            AssignCommand( oPC, JumpToLocation(lDest));
    }
    else
        SpeakString("You cannot use this door if you are from SILVER team or if you are carrying the flag or ball");
}



