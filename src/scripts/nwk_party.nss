
#include "nwk_const_teams"
#include "nwk_constants"
#include "nwk_colors"

//local variable of PC : lastAction
string VARNAME_LAST_ACTION = "lastAction";
string VARNAME_LAST_ACTION_TARGET = "lastActionTarget" ;


string checkSmallTeam();
void SetNewTeamLeader(string sTeam, object oNotUse);
int isTeamLeader(object oPc);
void ChangeTeam(object oPC);
void joinParty(string team,object oPc);
void setLikes(object oPlayer);

// Reset like/dislike for all player
void ResetLikes ();

// returns a string with the party membership of all players
string CreatePartyList ();

/**
 * loops through all party members and saves their current action
 * on a local variable int LAST_ACTION (save the constant of the action)
 * and also LAST_ACTION_TARGET (save the target of the action if there
 * was any , like last attacted , last chair to sit on etc)
 * @param sTeam the team to check TEAM_NAME_GOLD or TEAM_NAME_SILVER
 */
void saveLastActionOfAllPartyMembers(string sTeam)
{
/*    // use semaphore to avoid multiple calls
    if ( ! GetLocalInt ( GetModule(), sTeam ))
    {
        SetLocalInt ( GetModule(), sTeam, 1 );
        object oPC = GetFirstPC();
        object oTarget;
        while (GetIsObjectValid(oPC))
        {
            if (GetLocalString(oPC, "team") ==sTeam)
            {
                int currentAction = GetCurrentAction(oPC);
                SetLocalInt(oPC,VARNAME_LAST_ACTION,currentAction);
                //if it was attack , save the attacked target
                if (currentAction == ACTION_ATTACKOBJECT)
                oTarget = GetAttackTarget(oPC);
                SetLocalObject(oPC,VARNAME_LAST_ACTION_TARGET,oTarget);
            }
            oPC = GetNextPC();
        }
    } */
}

/**
 * assign the last action to the team members.
 * currently :
 * attack is reAssgined
 * rest is not reassigned , instead the PC get fully rested
 */
void assignLastActionOfAllPartyMembers(string sTeam)
{/*
    object oPC = GetFirstPC();
    object oTarget;
    while (GetIsObjectValid(oPC))
    {
        if (GetLocalString(oPC, "team") ==sTeam)
        {
            int lastAction = GetLocalInt(oPC,VARNAME_LAST_ACTION);
            //if it was attack , reAttack
            if (lastAction == ACTION_ATTACKOBJECT)
            {
                oTarget = GetLocalObject(oPC,VARNAME_LAST_ACTION_TARGET);
                AssignCommand( oPC , ActionAttack (oTarget));
            }
            else if (lastAction ==ACTION_REST)
            {
                ForceRest(oPC);
            }
        }
        oPC = GetNextPC();
    }
    // release semaphore
    DeleteLocalInt ( GetModule (), sTeam );  */
}




/* returns the smaller team name (silver/gold)
   if they both the same , returns "SAME"
*/
string checkSmallTeam()
{

    int nSilverNum = 0;
    int nGoldNum = 0;

    object oTeamTest = GetFirstPC();
    while ( GetIsObjectValid(oTeamTest) == TRUE )
    {
      if (GetLocalString(oTeamTest, "team") == "SILVER")
        {
          nSilverNum++;
        }
      else if (GetLocalString(oTeamTest, "team") == "GOLD")
        {
          nGoldNum++;
        }
      oTeamTest=GetNextPC();
    }


    if (nSilverNum == nGoldNum)
        return "SAME";
    else if (nSilverNum < nGoldNum)
        return "SILVER";
    else
        return "GOLD";
}









/** change the team-leader. it is used when leader leaves the game or changes
    teams. a player party membership depends only on the party leader , so when
    it is gone, all party become obselete.
    the leader will be the first one from that team that we catch on the loop
    of all the pc`s in the game.
@args:sTeam - the team that it`s leader will be changed.
      oNotUse - a player name that must not be used as leader or even member.
*/

void SetNewTeamLeader(string sTeam, object oNotUse)
{
    object oPC;
    object oNewLeader;
    int NewLeader = 0;

    //if there is only one player in the whole game , the inside loop does
    //nothing , so we must first make the team leader null
    if (sTeam == "SILVER")
                SetLocalObject(GetModule(), "oSilverLeader", OBJECT_INVALID);
    else if (sTeam == "GOLD")
                SetLocalObject(GetModule(), "oGoldLeader", OBJECT_INVALID);

    saveLastActionOfAllPartyMembers(sTeam);
    // If the player is the team leader for his party,
    //or if the team leader is OBJECT_INVALID, then rebuild the party.
     oPC = GetFirstPC();
     while (GetIsObjectValid(oPC))
     {
         if (GetLocalString(oPC, "team") == sTeam && oNotUse != oPC)
         {
             RemoveFromParty(oPC);
             if (NewLeader == 0)
             {
                 if (sTeam == "SILVER")
                         SetLocalObject(GetModule(), "oSilverLeader", oPC);
                 else if (sTeam == "GOLD")
                         SetLocalObject(GetModule(), "oGoldLeader", oPC);
                 NewLeader = 1;
                 oNewLeader = oPC;
             }
             else
             {
                 // debug log to search for reason of broken parties
                 if ( ! GetIsObjectValid ( oNewLeader ) )
                 {
                    WriteTimestampedLogEntry ( "***********************************************\n" +
                                               "* ERROR INVALID TEAM LEADER IN SetNewTeamLeader\n" +
                                               "***********************************************" );
                 }
                 // end debug
                 AddToParty(oPC, oNewLeader);
             }

         }
        oPC = GetNextPC();
    }
    assignLastActionOfAllPartyMembers(sTeam);

}

/** returns true if the PC is the leader of his team.
 */
int isTeamLeader(object oPc)
{
    string sTeam=GetLocalString(oPc,"team");
    object obj;

    if (sTeam=="SILVER")
        obj=GetLocalObject(GetModule(), "oSilverLeader");
    else if (sTeam=="GOLD")
        obj=GetLocalObject(GetModule(), "oGoldLeader");

    if (obj==oPc)
        return 1;
    else
        return 0;
}





/** change the team of the oPc.
    if he is the leader , we must rebuild it`s old team.
@args:  oPc
*/
void ChangeTeam(object oPC)
{
    saveLastActionOfAllPartyMembers("SILVER");
    saveLastActionOfAllPartyMembers("GOLD");
    string sTeam=GetLocalString(oPC,"team");
     object Leader;

    // determine if he was the leader of old party
    if (isTeamLeader(oPC))
    {
        RemoveFromParty(oPC);
        SetNewTeamLeader(sTeam, oPC);
    }
    else
    {
        RemoveFromParty(oPC);
    }

   //join the new party
   if (sTeam=="SILVER")
        joinParty("GOLD",oPC);
   else if (sTeam=="GOLD")
       joinParty("SILVER",oPC);

   assignLastActionOfAllPartyMembers("GOLD");
   assignLastActionOfAllPartyMembers("SILVER");

}



/** inserts the oPc to the team , if the team is empty or "broken", makes him
    it`s leader.
*/
void joinParty(string sTeam,object oPC)
{
    object Leader;

    saveLastActionOfAllPartyMembers(sTeam);

    if (sTeam == "SILVER")
    {
            Leader = GetLocalObject(GetModule(), "oSilverLeader");
            SetLocalString (oPC, "team", "SILVER" );

            if (Leader == OBJECT_INVALID)
                SetNewTeamLeader("SILVER", Leader);
            else
                AddToParty(oPC, Leader);
    }
    else if (sTeam == "GOLD")
    {
            Leader = GetLocalObject(GetModule(), "oGoldLeader");
            SetLocalString (oPC, "team", "GOLD" );

            if (Leader == OBJECT_INVALID)
                SetNewTeamLeader("GOLD", Leader);
            else
                AddToParty(oPC, Leader);
    }

    setLikes(oPC);

    assignLastActionOfAllPartyMembers(sTeam);

}






/**   setLikes
// NWTACTICS by Jhenne (tallonzek@hotmail.com)
// 07/07/02
// origin: SetLikes file, sets the teams to dislike each other.
// code is taken from the Bioware Contest of Champions
// mod.
// @param
     oPlayer - the new player that all team things must
                change to include him or dislike him.
  */
void setLikes(object oPlayer)
{
    object oPC=GetFirstPC();
    string sTeam;
    string sSelfTeam = GetLocalString(oPlayer, "team");

    // set the PC's to like their team and dislike the other team.
    while ( GetIsObjectValid(oPC) == TRUE )
    {
        sTeam=GetLocalString(oPC, "team");
        if ( sTeam == sSelfTeam )
        {
            SetPCLike(oPlayer,oPC);
            SetPCLike(oPC,oPlayer);
        }
        else
        {
            SetPCDislike(oPlayer,oPC);
            SetPCDislike(oPC,oPlayer);
        }
        oPC = GetNextPC();
    }
}


string CreatePartyList ()
{
    string sList;

    // collect Goldenflame and Silverice in different lists
    string sGoldList = "";
    string sSilverList = "";
    object oPC = GetFirstPC ();
    while ( GetIsObjectValid ( oPC ) )
    {
        if ( GetLocalString ( oPC, "team" ) == "SILVER" )
        {
            sSilverList += GetName ( oPC ) + " [" + GetPCPlayerName ( oPC ) + "]\n";
        } else if ( GetLocalString ( oPC, "team" ) == "GOLD" )
        {
            sGoldList += GetName ( oPC ) + " [" + GetPCPlayerName ( oPC ) + "]\n";
        }
        oPC = GetNextPC ();
    }

    // create the List
    sList = "****************************\n" +
            "GoldenFlame Team:\n" + sGoldList +
            "****************************\n" +
            "SilverIce Team:\n" + sSilverList;
    return sList;
}



float ARMOUR_EQUIP_DELAY = 1.0;




//shuffle teams membership randomly
//replace armor and set to new team
//send to sanctuary
void ShuffleTeams ();




struct PartyCounter
{
    int nSilverNum;
    int nGoldNum;

    string biggerTeamName;
    int difference;
};

struct PartyCounter countPlayersInParties()
{
    struct PartyCounter partyCounter;
    partyCounter.nSilverNum = 0;
    partyCounter.nGoldNum = 0;

    object oTeamTest = GetFirstPC();
    while ( GetIsObjectValid(oTeamTest) == TRUE )
    {
      if (GetLocalString(oTeamTest, "team") == "SILVER")
        {
          partyCounter.nSilverNum++;
        }
      else if (GetLocalString(oTeamTest, "team") == "GOLD")
        {
          partyCounter.nGoldNum++;
        }
     oTeamTest=GetNextPC();
    }

    //check difference
    int unsignedDifference = partyCounter.nSilverNum - partyCounter.nGoldNum ;

    if  (unsignedDifference==0)
    {
         partyCounter.biggerTeamName=TEAM_NAME_NONE;
         partyCounter.difference=0;
    }
    else if (unsignedDifference > 0)
    {
         partyCounter.biggerTeamName=TEAM_NAME_SILVER;
         partyCounter.difference=unsignedDifference;
    }
    else
    {
        partyCounter.biggerTeamName=TEAM_NAME_GOLD;
        partyCounter.difference=0 - unsignedDifference; //reverse sign

    }


    return partyCounter;
}






/** a helper function to replace one apperance of a substring.
@args:  source  - the source string
        key1    - to search and delete
        key2    - to put there instaed
returns: changed strinh  of there was a switch  , empty "" if not.
*/
string replaceString(string source, string key1,string key2)
{

    string  result;

    int start=FindSubString(source,key1);
    if (start<0)
    {
        return "REPLACE_ERROR";
    }

    //now start is the starting position of the requested string.
    //source = X-key1-Y  wp-Gold-axe  sub=3 ,size=4 source_length=9
    //so we need to concate X-key2-Y
    //x is prefix , y is end
    string prefix;
    if (start>=1)  //else prefix is empty
        prefix=GetStringLeft(source,start);

    string end=GetStringRight(source,GetStringLength(source)-GetStringLength(key1)-start);
    result=key2+end;
    return result;

}





void changeItemFromSlot(object oPc , int slot_name , string new_team)
{
  int start;
  string item_tag;
  object item=GetItemInSlot(slot_name, oPc);

  //determine old team color from the new team
  string old_team;
  if (new_team=="Silver")
    old_team="Gold";
  else if (new_team=="Gold")
    old_team="Silver";

  object new_item;
  string new_tag;
  if (GetIsObjectValid(item))
  {
        item_tag=GetTag(item) ;
        new_tag=replaceString(item_tag,old_team,new_team);

        if (new_tag!="REPLACE_ERROR")
        {
               new_item=CreateItemOnObject(new_tag,oPc);
               //if it is an armor , delay the command a bit.
               //reason: it takes time to get out of Battle state which does
               //not allow equiping armor
               if (slot_name==INVENTORY_SLOT_CHEST)
               {
                   DelayCommand(ARMOUR_EQUIP_DELAY, AssignCommand(oPc,ActionEquipItem( new_item, slot_name)));
               }
               else //regular - no delay
               {
                   AssignCommand(oPc,ActionEquipItem( new_item, slot_name));
               }



                //destroy old one
                DestroyObject(item,0.0);
         }
         //else - it is an evil/good (and not silver-gold) DO nothing
  }
}




void adjustInventoryToNewParty(object oPC)
{
   string team=GetLocalString(oPC,"team");
   string key1,key2;

   if (team=="SILVER")
   {
        key1="Gold";
        key2="Silver";

   }
   else if (team=="GOLD")
   {
        key1="Silver";
        key2="Gold";
   }




  string new_tag;
  int start;
  string old_tag;
  int num_of_stacked;
  // clear combat mode
  AssignCommand ( oPC, ClearAllActions ( TRUE ) );
  object item=GetFirstItemInInventory(oPC);
  while (GetIsObjectValid(item))
  {
        old_tag=GetTag(item) ;
        num_of_stacked=GetNumStackedItems(item);

        new_tag=replaceString(old_tag,key1,key2);
        object oLastItem = item;
        // WriteTimestampedLogEntry ( "item: " + ObjectToString ( item ) + ", old tag: " + old_tag + ", new tag: " + new_tag );
        if (new_tag!="REPLACE_ERROR")
        {
            DestroyObject(item,0.0);
            CreateItemOnObject(new_tag,oPC,num_of_stacked);
        }
        item=GetNextItemInInventory(oPC);
        // an interessting confusion in the iterator
        if ( oLastItem == item )
        {
            item=GetNextItemInInventory(oPC);
        }
        new_tag="REPLACE_ERROR";

  }

  changeItemFromSlot(oPC,INVENTORY_SLOT_CHEST,key2);
  changeItemFromSlot(oPC,INVENTORY_SLOT_ARMS,key2);
  changeItemFromSlot(oPC,INVENTORY_SLOT_RIGHTHAND,key2) ;
  changeItemFromSlot(oPC,INVENTORY_SLOT_LEFTHAND,key2);
  changeItemFromSlot(oPC,INVENTORY_SLOT_HEAD,key2);
  changeItemFromSlot(oPC,INVENTORY_SLOT_BULLETS,key2);
  changeItemFromSlot(oPC,INVENTORY_SLOT_BOLTS,key2);
  changeItemFromSlot(oPC,INVENTORY_SLOT_ARROWS,key2);

}



/* change main :
 * 1. change team variable and party.
 * 2. change inventory
 * 3. jump to the lDest with the Pc facing the fFacingDirection.
 */
void jumpPlayerByIndicator(object oPC,string teamName,int sDestPointIndicator,int whetherToRessurectPC)
{
    //check new destination by
    struct PlayerLocation playerNewLocation =
                        getPlayerNewLocation( sDestPointIndicator,
                                              getIntbyTeamName(teamName)
                                             );
        if (whetherToRessurectPC==TRUE)
        {
             ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oPC);
        }
        AssignCommand(oPC, JumpToLocation(playerNewLocation.lDest));
        AssignCommand(oPC, SetCameraFacing(playerNewLocation.fDirection));
        // Plot flag  set in nw_s0_respawn
        DelayCommand ( 2.0, SetPlotFlag ( oPC, FALSE ) );


}



void ShuffleTeams ()
{
    sendMessageToAllPlayer ( "", "Team shuffle" );
    // Debug
    // string sPartyList = CreatePartyList ();
    // WriteTimestampedLogEntry ( "** DEBUG: TEAM SHUFFLE - Old Team List:\n" + sPartyList );
    //End Debug
    object oPC = GetFirstPC ();
    string sTeam = TEAM_NAME_GOLD;
    string sCurrentTeamName;
    while ( GetIsObjectValid ( oPC ) )
    {
        sCurrentTeamName = getTeamNameByPC ( oPC );
        WriteTimestampedLogEntry ( "** DEBUG: Shuffle Player : " + GetName ( oPC ) +
                                   ", old Team : " + sCurrentTeamName +
                                   ", new Team : " + sTeam );
        if ( sCurrentTeamName != TEAM_NAME_NONE )
        {
            if ( sCurrentTeamName != sTeam )
            {
                //this change the local "team" variable
                SetLocalString ( oPC, "team", sTeam );
                //jump to new dest + resssurect
                jumpPlayerByIndicator(oPC, sTeam, DEST_POINT_INDICATOR_IN_SANC, TRUE);
                //change inventory, the silver things will be gold and vice versa. other
                //will not change
                RemoveSpecificEffect ( EFFECT_TYPE_POLYMORPH, oPC );
                DelayCommand ( 3.0, adjustInventoryToNewParty ( oPC ) );
            }
            //toggle team
            sTeam = ConstTeams_getOppositeTeamName ( sTeam );
        }
        oPC = GetNextPC ();
    }
    // Debug
    // sPartyList = CreatePartyList ();
    // WriteTimestampedLogEntry ( "** DEBUG: TEAM SHUFFLE - New Team List:\n" + sPartyList );
    // WriteTimestampedLogEntry ( "** DEBUG: END TEAM SHUFFLE \n" );
    //End Debug
    //reset like dislike and team membership for all
    SetNewTeamLeader ( TEAM_NAME_GOLD, OBJECT_INVALID );
    SetNewTeamLeader ( TEAM_NAME_SILVER, OBJECT_INVALID );
    ResetLikes ();
}


void ResetLikes ()
{
    // set like/disliek for a single player may corrupt iterator,
    // therefore mark first all player for reset. In the second
    // step search for first player "not" reseted and reset him.
    string sMarker = "SR_SET_LIKES";
    object oPC = GetFirstPC ();
    while ( GetIsObjectValid ( oPC ) )
    {
        SetLocalInt ( oPC, sMarker, TRUE );
        oPC = GetNextPC ();
    }
    oPC = GetFirstPC ();
    while ( TRUE )
    {
        object oPC = GetNextPC ();
        while ( !GetLocalInt ( oPC, sMarker ) && GetIsObjectValid ( oPC ) )
        {
            oPC = GetNextPC ();
        }
        if ( ! GetIsObjectValid ( oPC ) ) break;
        DeleteLocalInt ( oPC, sMarker );
        // setLikes destroys the iterator
        setLikes ( oPC );
        // reset iterator to make sure we get all player
        oPC = GetFirstPC ();
    }

}
