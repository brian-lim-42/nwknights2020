//  changed by PENTAGON     //
/** changes the player team(and party) , change all the tools to the other
    color and move it to the other team WP
*/

#include "nwk_changeteams"
#include "nwk_constants"
#include "nwk_dom_inc"

/*
 * get the current team , transfer to the other teams sanctuary.
 * change all objects to the other color.
 */
void main()
{
   object oPC= GetPCSpeaker();
   string team=GetLocalString(oPC,"team");

   //check if he is in the bigger team
   string small_team= checkSmallTeam();
//SpeakString("the small team is"+small_team);
//SpeakString("the current team is"+team);
   if (!((team=="SILVER")&&(small_team=="GOLD") ||
        (team=="GOLD")  &&(small_team=="SILVER")  ))
   {
        SendMessageToPC(oPC,"You cannot switch while your team is smaller than the other team");
        return;
   }
    // reset all score stuff
    ResetDominationAreaForPlayer ( oPC );
    //drop flag / ball
    int bHasGoldFlag = GetLocalInt (oPC, VARNAME_FLAG_PC_CARRIES_GOLD );
    int bHasSilverFlag = GetLocalInt (oPC, VARNAME_FLAG_PC_CARRIES_SILVER );
    if ( bHasGoldFlag )
    {
        //reset flag variable and create new flag
        WriteTimestampedLogEntry ( "Flag Carrier changed team: GOLD Team" );
        createFlagOnFloor( TEAM_GOLD,
                       GetLocation(GetObjectByTag(nwk_gold_base_flag_location_tag()))
                     );
        sendMessageToAllPlayer("",ColorString("SilverIce flag back at base",COLOR_BLUE));
    }
    if ( bHasSilverFlag )
    {
        WriteTimestampedLogEntry ( "Flag Carrier changed team: Silver Team" );
        //reset flag variable and create new flag

        createFlagOnFloor( TEAM_SILVER,
                       GetLocation(GetObjectByTag(nwk_silver_base_flag_location_tag()))
                     );
        sendMessageToAllPlayer("",ColorString("GoldenFlame flag back at base",COLOR_BLUE));
    }




    object LightBall = GetHenchman (oPC);
        if (GetTag(LightBall) == "LightBall")
    jumpFallenBall(LightBall) ;
//SpeakString("so we change teams");
   ChangeTeam(oPC);

    //now check again the new team
    team=GetLocalString(oPC,"team");




   location lDest;

   float fDirection;
   if (team=="SILVER")
   {
        lDest=GetLocation(GetObjectByTag("SILVERSTART"));
        fDirection = 90.0f;
   }
   else if (team=="GOLD")
   {
        lDest=GetLocation(GetObjectByTag("GOLDSTART"));
        fDirection = 270.0f;
   }

    sendMessageToAllPlayer ( GetName (oPC) +
                            " switched to " +
                            longTeamName ( GetLocalString ( oPC, "team") ) +
                            " team.", "" );

    adjustInventoryToNewParty ( oPC );

    AssignCommand(oPC,ActionJumpToLocation(lDest));
    AssignCommand(oPC,SetCameraFacing(fDirection));


}
