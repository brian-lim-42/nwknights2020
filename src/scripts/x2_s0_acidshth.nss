//::///////////////////////////////////////////////
//:: Mestil's Acid Sheath
//:: X2_S0_AcidShth
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This spell creates an acid shield around your
    person. Any creature striking you with its body
    does normal damage, but at the same time the
    attacker takes 1d6 points +2 points per caster
    level of acid damage. Weapons with exceptional
    reach do not endanger thier uses in this way.
*/
//[pentagon 21/10/04] 1. does not stack with elemental shield
//2. dmg isd6 points +ONE POINT per caster level of acid damage
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:: 2003-07-07: Stacking Spell Pass, Georg Zoeller
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
//#include "x0_i0_spells"
#include "nwk_spells"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-07-07 by Georg Zoeller
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
    effect eVis = EffectVisualEffect(448);
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nDamage = nDuration ;
    int nMetaMagic = GetMetaMagicFeat();
    object oTarget = OBJECT_SELF;
    effect eShield = EffectDamageShield(nDamage, DAMAGE_BONUS_1d6, DAMAGE_TYPE_ACID);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    //Link effects
    effect eLink = EffectLinkEffects(eShield, eDur);
    eLink = EffectLinkEffects(eLink, eVis);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, GetSpellId(), FALSE));

    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }

    destroyEffectsOfDamagingShields(oTarget);

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
}

