/*
  author: shadow_in_the_dark
  name:   pvp_t_switch
  date:   05/07/16

  check if team switch is enabled or not.

*/

// mod var to store the actual state
const string DISABLE_TEAM_SWITCH = "sr_disable_team_switch";

// if set, no team switch option is available in the Information Knight dialogue
void DisableInGameTeamSwitch ();

int StartingConditional()
{
    return ! GetLocalInt ( GetModule (), DISABLE_TEAM_SWITCH );
}

void DisableInGameTeamSwitch ()
{
    SetLocalInt ( GetModule(), DISABLE_TEAM_SWITCH, TRUE );
}
