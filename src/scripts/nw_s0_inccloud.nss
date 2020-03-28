//::///////////////////////////////////////////////
//:: Incendiary Cloud
//:: NW_S0_IncCloud.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Person within the AoE take 4d6 fire damage
    per round.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 17, 2001
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    // End of Spell Cast Hook
    //Declare major variables, including the Area of Effect object.
    effect eAOE = EffectAreaOfEffect(AOE_PER_FOGFIRE);
    //Capture the spell target location so that the AoE object can be created.
    location lTarget = GetSpellTargetLocation();
    int nDuration = 1 + GetCasterLevel(OBJECT_SELF) / 10;
    effect eImpact = EffectVisualEffect(260);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lTarget);
    if(nDuration < 1)
    {
        nDuration = 1;
    }
    int nMetaMagic = GetMetaMagicFeat();
    //Check for metamagic extend
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Create the object at the location so that the objects scripts will start working.
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(nDuration));
}

