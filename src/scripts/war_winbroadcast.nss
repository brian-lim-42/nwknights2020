// NWTACTICS by Jhenne  (tallonzek@hotmail.com)
// 07/07/02
// Capture script, called from the trigger script in the map
// trigger script crashed with "too many instructions" with half
// of this code in it for some reason. so have the PC do it instead.
//changed by PENTAGON
//#include "nwk_constants"
#include "nwk_maps"
#include "nwk_flag"
#include "nwk_team_onscore"

void main()
{
// grab him as an object as well for scoring purposes
object oWinner = OBJECT_SELF;








object oTrophy = CreateItemOnObject ("Trophy", oWinner);

// give only the player his bonus points (team will be done in a called procedure
SetLocalInt(oWinner, "personalscore",
GetLocalInt(oWinner, "personalscore")+nwk_flag_player_bonus());

calcuateMvp(oWinner);




//create general visual action (jumps and cheers)
object SilverGeneral =  nwk_SilverGeneral();
object GoldGeneral   = nwk_GoldGeneral();
location SilverGeneralDest = nwk_SilverGeneralDest();
location GoldGeneralDest = nwk_GoldGeneralDest();

object oGeneral;
location lDest;

string flag_bringer_team=GetLocalString(OBJECT_SELF,"team");
if (flag_bringer_team=="SILVER")
{
    oGeneral = SilverGeneral;
    lDest =  SilverGeneralDest;
}
else if (flag_bringer_team=="GOLD")
{
    oGeneral = GoldGeneral;
    lDest =  GoldGeneralDest;
}

AssignCommand (oGeneral, ClearAllActions());
AssignCommand (oGeneral, ActionJumpToLocation (lDest));
AssignCommand (oGeneral, ActionPlayAnimation (ANIMATION_FIREFORGET_VICTORY3, 1.0, 100.0 ));
DelayCommand (5.0, AssignCommand (oGeneral, ActionSit (GetNearestObjectByTag ("CHAIR", OBJECT_SELF))));


  executeOnTeamPoint( OBJECT_SELF,// scorerPC,
                      nwk_flag_win_points() ,
                      nwk_flag_team_bonus() ,   //team bonus
                      nwk_flag_team_bonus() // broadcastEveryPointAmount .like bonus
                                            // meaning every flag!
                     );







}




