//nwk_const_teams
const string TEAM_NAME_SILVER="SILVER";
const string TEAM_NAME_GOLD="GOLD";
const string TEAM_NAME_NONE="NONE";

const int TEAM_SILVER=13;
const int TEAM_GOLD=24;
const int TEAM_NONE=35;


string getTeamNameByInt(int team)
{
    if (team ==TEAM_SILVER)
        return TEAM_NAME_SILVER;
    else if (team== TEAM_GOLD)
        return TEAM_NAME_GOLD;
    else
        return TEAM_NAME_NONE;
}
int getIntbyTeamName(string teamName)
{
     if (teamName == TEAM_NAME_SILVER)
        return TEAM_SILVER;
    else if (teamName== TEAM_NAME_GOLD)
        return TEAM_GOLD;
    else
        return TEAM_NONE;
}

int getTeamIntByPC(object oPC)
{
    string teamString = GetLocalString(oPC, "team");
    return getIntbyTeamName(teamString);
}

string getTeamNameByPC ( object oPC )
{
    return GetLocalString(oPC, "team");
}


string ConstTeams_getOppositeTeamName(string teamName)
{
    if (teamName==TEAM_NAME_SILVER)
        return  TEAM_NAME_GOLD;
    else if (teamName==TEAM_NAME_GOLD)
        return   TEAM_NAME_SILVER;
    else
        return TEAM_NAME_NONE;
}

