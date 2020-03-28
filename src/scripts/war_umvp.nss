/*
  author: shadow_in_the_dark
  name:   war_umvp
  date:   05/07/03

  speak message with name and score of the ultimative MVP

*/
#include "nwk_mvp"
void main()
{
    string sName = GetCampaignString ( sUMvPDatabase, sUMvPName );
    string sAccount = GetCampaignString ( sUMvPDatabase, sUMvPAccountName );
    string sScore = IntToString ( GetCampaignInt ( sUMvPDatabase, sUMvPScore ) );
    SpeakString ( "\n"
                  + sName + " [" + sAccount + "]\n" +
                  "with " + sScore + " points" );
}

