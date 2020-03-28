/*
  author: shadow_in_the_dark
  name:   nwk_party_reset
  date:   05/03/27

  Reset the party of the Speaker. Usage will be loged.

*/
#include "nwk_party"
void main()
{
    object oPlayer = GetPCSpeaker();

    string sTeam = GetLocalString ( oPlayer, "team" );
    string sMessage = "\n*************************************************** \n" +
                      "* Player: " + GetPCPlayerName ( oPlayer )+ " / " +
                         GetName ( oPlayer ) + " has activate party reset for team " + sTeam + ".\n" +
                      "***************************************************";
    SendMessageToAllDMs ( sMessage );
    WriteTimestampedLogEntry ( sMessage );
    SetNewTeamLeader ( sTeam, OBJECT_INVALID );
    ResetLikes ();

}

