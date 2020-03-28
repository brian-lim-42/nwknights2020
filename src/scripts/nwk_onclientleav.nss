/** onClientLeave
    1. if he was carrying the flag , create new flag at base
    2. erase all the local variables of him.

*/

#include "nwk_party"
#include "nwk_flag"
#include "nwk_ball"

 void main()
{


    // get the exiting PC
    object oPC=GetExitingObject ();
    string sPCName = GetName ( oPC );
    string sTeam = GetLocalString ( oPC, "team" );

    if ( ! ( GetStringLength ( sPCName ) > 70 ) )
    {
        WriteTimestampedLogEntry ( "OnClientLeave - Player Name " + sPCName );
    } else
    {
        WriteTimestampedLogEntry ( "OnClientLeave - Player Name to long." );
    };

    if (GetLocalInt(oPC,"pc_registered"))
    {
        int bHasGoldFlag = GetLocalInt (oPC, VARNAME_FLAG_PC_CARRIES_GOLD );
        int bHasSilverFlag = GetLocalInt (oPC, VARNAME_FLAG_PC_CARRIES_SILVER );
        // WriteTimestampedLogEntry ( "OnClientLeave - Player has Silver Flag: " + IntToString (bHasSilverFlag)  );
        // WriteTimestampedLogEntry ( "OnClientLeave - Player has Gold Flag: " + IntToString (bHasGoldFlag)  );
        // check if flag carrier leaves
        if ( bHasGoldFlag )
        {
            //reset flag variable and create new flag
            WriteTimestampedLogEntry ( "Flag Carrier leaved: GOLD Team" );
            createFlagOnFloor( TEAM_GOLD,
                           GetLocation(GetObjectByTag(nwk_gold_base_flag_location_tag()))
                         );
            sendMessageToAllPlayer("",ColorString("SilverIce flag back at base",COLOR_BLUE));
        }
        if ( bHasSilverFlag )
       {
            WriteTimestampedLogEntry ( "Flag Carrier leaved: Silver Team" );
            //reset flag variable and create new flag

            createFlagOnFloor( TEAM_SILVER,
                           GetLocation(GetObjectByTag(nwk_silver_base_flag_location_tag()))
                         );
            sendMessageToAllPlayer("",ColorString("GoldenFlame flag back at base",COLOR_BLUE));
        }


        ResetDominationAreaForPlayer ( oPC );

        //party issue
        RemoveFromParty(oPC);
        if (isTeamLeader(oPC))
            SetNewTeamLeader(sTeam, oPC);

        DeleteLocalString(oPC, "team");
        DeleteLocalInt(oPC, "personalscore");
        DeleteLocalInt(oPC, "pc_registered");


        deleteMvp(oPC,sPCName);



    // flag and ball issue.

        object oHenchman = GetHenchman (oPC);
        if (GetTag(oHenchman) == "LightBall")
        {
            jumpFallenBall(oHenchman) ;
        }
        else
        {
            DestroyObject (oHenchman);
        }
    ////////////////////////////////


     }


}
