/*
  author: shadow_in_the_dark
  name:   sr_dbg_umvp
  date:   05/07/02

  show the stored values for the ulimative MvP
*/
#include "nwk_mvp"
void main()
{
    string sName = GetCampaignString ( sUMvPDatabase, sUMvPName );
    string sAccount = GetCampaignString ( sUMvPDatabase, sUMvPAccountName );
    string sScore = IntToString ( GetCampaignInt ( sUMvPDatabase, sUMvPScore ) );
    SendMessageToAllDMs ( "Ultimative MvP: " + sName + " (" + sAccount + ") with " + sScore + " Points" );
}

