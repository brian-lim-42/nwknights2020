 /** on sancturay door
    1. check if the player team is valid ,if not create new one.
    2. count players , if teams are totally unbalanced(on little number of
        players , differ in 1  , in larger number , differ in more than 1 ,
        dont allow player to go out to the battle field.
*/
#include "nwk_party"
#include "nwk_constants"
//#include "x2_inc_itemprop"
#include "nwk_lord"

void main()
{

    object oPC = GetClickingObject();
    if ( ! GetIsObjectValid ( oPC ) )
    { // Portal
        oPC = GetLastUsedBy ();
    }
    string team= GetLocalString(oPC,"team");


    DeleteLocalInt ( oPC, sMutex );

/* removed shadow_in_the_dark: no auto balancing by door re-quired
    //join him to the party
    joinParty(team,oPC);

    //count players
    int nSilverNum = 0;
    int nGoldNum = 0;

    object oTeamTest;
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

    //check imbalance
    if (abs(nSilverNum-nGoldNum)>1)
    {
        ActionStartConversation(oPC, "balancedoor");
    }
    else */
    {

        location lDest;
        if (team=="SILVER")
        {
            lDest = GetLocation(GetObjectByTag(mapFullTagName("SANC_SILVER")));
            if (GetIsLord (oPC))
            {
                AddLordProperties ( oPC );
                DelayCommand (2.0, AssignCommand (oPC, PlaySound("as_cv_ta-da1")));
                FloatingTextStringOnCreature ("Hail to the Knight Lord", oPC);
            }
        }
        else if (team=="GOLD")
        {
            lDest = GetLocation(GetObjectByTag(mapFullTagName("SANC_GOLD")));
            if (GetIsLord (oPC))
            {
                AddLordProperties ( oPC );
                DelayCommand (2.0, AssignCommand (oPC, PlaySound("as_cv_ta-da1")));
                FloatingTextStringOnCreature ("Hail to the Knight Lord", oPC);
            }
        }


        AssignCommand(oPC, ActionJumpToLocation(lDest));
        JumpHenchmen(oPC, lDest, 6);
    }
 }

