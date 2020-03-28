/*
  author: shadow_in_the_dark
  name:   sr_dbg_party
  date:   05/04/23

  Re-create both parties

*/
#include "nwk_party"
void main()
{
    SetNewTeamLeader ( TEAM_NAME_GOLD, OBJECT_INVALID );
    SetNewTeamLeader ( TEAM_NAME_SILVER, OBJECT_INVALID );
    ResetLikes ();
}

