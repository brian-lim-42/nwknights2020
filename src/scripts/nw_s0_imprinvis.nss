///::///////////////////////////////////////////////
//:: Improved Invisibility
//:: NW_S0_ImprInvis.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Target creature can attack and cast spells while
    invisible
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////
//Changes : dont do invisibility , just the concelment
#include "x2_inc_spellhook"
#include "nw_i0_spells"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    // End of Spell Cast Hook
    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eImpact = EffectVisualEffect(VFX_IMP_HEAD_MIND);
    effect eVis = EffectVisualEffect(VFX_DUR_INVISIBILITY);
   // effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eCover = EffectConcealment(50);
    effect eLink = EffectLinkEffects(eDur, eVis);
    eLink = EffectLinkEffects(eLink, eCover);

    // remove all concealment effects to avoid stacking
    RemoveSpecificEffect ( EFFECT_TYPE_CONCEALMENT, oTarget );

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_IMPROVED_INVISIBILITY, FALSE));
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }
    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eImpact, oTarget);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
   // ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eInvis, oTarget, RoundsToSeconds(nDuration));
}


