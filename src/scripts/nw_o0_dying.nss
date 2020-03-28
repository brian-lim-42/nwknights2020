//::///////////////////////////////////////////////
//:: Dying Script
//:: NW_O0_DEATH.NSS
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script handles the default behavior
    that occurs when a player is dying.
    DEFAULT CAMPAIGN: player dies automatically
*/
//:://////////////////////////////////////////////
//:: Created By: Brent Knowles
//:: Created On: November 6, 2001
//:://////////////////////////////////////////////

#include "nwk_dom_inc"
#include "sr_inc_shifter"
void main()
{
    object oPlayer = GetLastPlayerDying();

    // kick him on floor, to avoid lich on thrown
    effect eKnockDown = EffectKnockdown ();
    effect eRessurect = EffectResurrection ();
    effect eDeath = EffectDeath(TRUE, TRUE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eRessurect, oPlayer);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockDown, oPlayer, 3.0);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oPlayer);

    KillUndeadPlayer ( oPlayer );
// domination area issues
    if ( GetIsInDominationArea ( GetLastPlayerDying() ) )
    {
        HandleOnExitDominationAreaEvent ( GetLastPlayerDying(), GetDominationArea ( GetLastPlayerDying() ) );
    }
}
