//::///////////////////////////////////////////////
//:: True Seeing
//:: NW_S0_TrueSee.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The creature gets +10 to spot and listen skills
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: [date]
//:://////////////////////////////////////////////
#include "NW_I0_SPELLS"

#include "x2_inc_spellhook"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!X2PreSpellCastCode())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    object oTarget = OBJECT_SELF;
    effect eSight = EffectSeeInvisible();
    effect eVis = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
    int nMetaMagic = GetMetaMagicFeat();

    effect eListen = EffectSkillIncrease(SKILL_LISTEN, 10);
    effect eSpot = EffectSkillIncrease(SKILL_SPOT, 10);

    effect eDur = EffectVisualEffect(VFX_DUR_MAGICAL_SIGHT);
    effect eLink = EffectLinkEffects(eSpot, eListen);

    eLink = EffectLinkEffects(eLink, eDur);

    int nDuration = GetCasterLevel(OBJECT_SELF); // * Duration 1 hour/level
     if (nMetaMagic == METAMAGIC_EXTEND)    //Duration is +100%
    {
         nDuration = nDuration * 2;
    }

    //Fire spell cast at event for target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 420, FALSE));
    //Apply VFX impact and bonus effects
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSight, oTarget, TurnsToSeconds(nDuration));

}
