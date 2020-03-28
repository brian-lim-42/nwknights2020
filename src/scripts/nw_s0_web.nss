//::///////////////////////////////////////////////
//:: Web
//:: NW_S0_Web.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Creates a mass of sticky webs that cling to
    and entangle target who fail a Reflex Save
    Those caught can make a new save every
    round.  Movement in the web is 1/6 normal.
    The higher the creatures Strength the faster
    they move out of the web.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 8, 2001
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    // End of Spell Cast Hook
    //Declare major variables including Area of Effect Object
    effect eAOE = EffectAreaOfEffect(AOE_PER_WEB);

    location lTarget = GetSpellTargetLocation();
    int nDuration = 1 + GetCasterLevel(OBJECT_SELF) / 10;
    int nMetaMagic = GetMetaMagicFeat();
    //Make sure duration does no equal 0
    if (nDuration < 1)
    {
        nDuration = 1;
    }
    //Check Extend metamagic feat.
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
       nDuration = nDuration *2;    //Duration is +100%
    }
    //Create an instance of the AOE Object using the Apply Effect function
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(nDuration));
}

