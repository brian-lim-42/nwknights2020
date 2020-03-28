/** FileName : nwk_changeteams
*/
#include "nwk_colors"
#include "nwk_party"
#include "nwk_constants"
#include "nwk_flag"
#include "nwk_ball"
#include "nwk_dom_inc"






/** checks if balancing is needed, if so change team of the PC
 * @param   oPC     - the one that may change
 * @param   sDestPointIndicator - string which is used to indicate to which kind
            of destination the PC will jump (if balance dectates it). for example
            start point means respawn point on map . sanc means in sanc.
            You must use the constants from nwk_map file.

 */
void balanceTeamsWithPC(object oPC , int sDestPointIndicator, float fRestockDelay)
{

    int needToChange = FALSE;
    int iNewTeamConst;
    //check if a team need change , only if difference is 2 or more.
    struct PartyCounter playerCounter = countPlayersInParties();
    string sCurrentTeamName =  GetLocalString(oPC, "team");
    if (    (playerCounter.difference >= 2)
          &&(playerCounter.biggerTeamName ==  sCurrentTeamName)
       )
    {
           needToChange = TRUE;
    }


    //to determine where to jump the PC , we need to konw what is his new base.
    //if it going to change , change it.
    //We first jump and only after changeTeams and reEquip to be nice graphically.
    //otherwise , on the battlefield , the player would do the reEqupment.
    if (needToChange==TRUE)
    {
        sCurrentTeamName = ConstTeams_getOppositeTeamName(sCurrentTeamName);
    }

    //jump to new dest + resssurect
    jumpPlayerByIndicator(oPC,sCurrentTeamName,sDestPointIndicator,TRUE);


    //drop flag / ball
    object oPlayer=oPC;
    int nSilverFlag = GetLocalInt ( oPlayer, "hassilverflag");
    int nGoldFlag = GetLocalInt   ( oPlayer, "hasgoldflag");
    // if he had the gold the flag, create one on the floor
    if (nGoldFlag ==1)
        createFallenFlag(oPlayer);
    else if (nSilverFlag == 1)
        createFallenFlag(oPlayer) ;

    object LightBall = GetHenchman (oPlayer);
        if (GetTag(LightBall) == "LightBall")
    jumpFallenBall(LightBall) ;

    if (needToChange==TRUE)
    {

       //this change party relevance and the local "team" variable
       ChangeTeam(oPC);
       AssignCommand(oPC,SpeakString(ColorString("************\nTo balance the team sizes : You have switched teams .\n************",COLOR_RED)));


       ResetDominationAreaForPlayer ( oPlayer );

       //change inventory , the silver things will be gold and vice versa. other
       //will not change
       DelayCommand(fRestockDelay,adjustInventoryToNewParty(oPC));
    }





}







