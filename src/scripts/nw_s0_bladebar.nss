//::///////////////////////////////////////////////
//:: Blade Barrier
//:: NW_S0_BladeBar.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Creates a wall 10m long and 2m thick of whirling
    blades that hack and slice anything moving into
    them.  Anything caught in the blades takes
    2d6 per caster level.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: July 20, 2001
//:://////////////////////////////////////////////
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }
    //Declare major variables including Area of Effect Object
    effect eAOE = EffectAreaOfEffect(AOE_PER_WALLBLADE);
    location lTarget = GetSpellTargetLocation();
    // shadow_in_the_dark: still to long => extend means 36 seconds
    // duration calculated in seconds instead of rounds
    // maximum duration 22 sec, now
    float nDuration = 1.0 + IntToFloat ( GetCasterLevel(OBJECT_SELF)/2 );
    int nMetaMagic = GetMetaMagicFeat();

    //Check Extend metamagic feat.
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
       nDuration = nDuration *2;    //Duration is +100%
    }
    //Create an instance of the AOE Object using the Apply Effect function
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, nDuration );
}

