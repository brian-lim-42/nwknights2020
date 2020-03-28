//::///////////////////////////////////////////////
//:: Storm of Vengeance
//:: NW_S0_StormVeng.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Creates an AOE that decimates the enemies of
    the cleric over a 30ft radius around the caster
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 8, 2001
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 25, 2001
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    // End of Spell Cast Hook
    //Declare major variables including Area of Effect Object
    effect eAOE = EffectAreaOfEffect(AOE_PER_STORM);
    effect eVis = EffectVisualEffect(VFX_FNF_STORM);
    location lTarget = GetSpellTargetLocation();
    int nDuration = 1+GetCasterLevel(OBJECT_SELF)/5;

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lTarget);
    //Create an instance of the AOE Object using the Apply Effect function
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(nDuration));
}


