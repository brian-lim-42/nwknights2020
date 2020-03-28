/*
  author: shadow_in_the_dark
  name:   nwk_enter_team
  date:   2005-02-03

  Join the smaller team. If both teams are of same size join one of them randomly.

  Before a team can be joined, the players has to be level 20.
  Anti Cheat Script is executed before team select.

*/


#include "nwk_party"
#include "start_anticheat"
#include "start_prep_inv"
#include "sr_inc_dd"


void main()
{

    PlaySound("as_cv_gongring2");
    object oPC = GetLastUsedBy();

    // mutex to avoid double invocation
    if ( GetLocalInt ( oPC, sMutex) ) return;
    SetLocalInt ( oPC, sMutex, TRUE );

    if (GetHitDice(oPC) != 20)
    {
        SpeakString("You need to build up your character to level 20 first!");
        return ;
    }


    // remove all effects before start of anti cheat code
    effect eEffect;
    int wait = 0;

    eEffect = GetFirstEffect(oPC);

    while ( GetIsEffectValid(eEffect))
    {
        if (GetEffectDurationType(eEffect) == DURATION_TYPE_TEMPORARY ||
            GetEffectDurationType(eEffect) == DURATION_TYPE_PERMANENT ||
            GetEffectType(eEffect) == EFFECT_TYPE_POLYMORPH)
        {
            if (GetEffectType(eEffect) != EFFECT_TYPE_DISEASE)
            {
                RemoveEffect(oPC,eEffect);
            }
            if (GetEffectType(eEffect) == EFFECT_TYPE_POLYMORPH)
            {
                wait = 1;
            }
        }

        eEffect = GetNextEffect(oPC);
    }
    // allow polymorphie to disappear.
    if (wait == 1) ActionWait(7.0);

    // move anti cheat code after removing of effects
    if ( GetIsIllegal ( oPC ) ) return;

    // avoid a lost associate
    if (GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC) != OBJECT_INVALID)
        DestroyObject(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC), 0.5);
    if (GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC) != OBJECT_INVALID)
        DestroyObject(GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC), 0.5);
    if (GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC) != OBJECT_INVALID)
        DestroyObject(GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC), 0.5);


    // DD AC increase exploit - store start AC
    SetStartAC ( oPC );



    // join smaller team
    string sTeam = checkSmallTeam();
    if ( sTeam == "SAME" )
    {
        // even teams, select one randomly
        if (d2() == 1)
        {
            sTeam = TEAM_NAME_SILVER;
        }
        else
        {
            sTeam = TEAM_NAME_GOLD;
        }

    }


    // remove the PC from his group if someone has invited him already.
    // and join him to the silver party
    RemoveFromParty(oPC);
    joinParty(sTeam,oPC);
    //move the player to his team start point at the sanctuary
    // get the waypoints in each base
    object oGoldDest = GetObjectByTag ("GOLDSTART");
    object oSilverDest = GetObjectByTag ("SILVERSTART");
    // define the destination location variable
    location lDest;
    if (sTeam == TEAM_NAME_SILVER)
           lDest = GetLocation(oSilverDest);
    else if (sTeam == TEAM_NAME_GOLD)
           lDest = GetLocation(oGoldDest);
    //give base equipement
    prepareInventory(oPC);


    // jump the pc to the  base
    SetLocalInt(oPC,"pc_registered",1);
    DelayCommand ( 1.0, AssignCommand ( oPC, JumpToLocation (lDest)));

}


