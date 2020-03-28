//::///////////////////////////////////////////////
//:: Expeditious retreat
//:: x0_s0_exretreat.nss
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
 Increases movement rate to the max, allowing
 the spell-caster to flee.
 Also gives + 2 AC bonus
*/
//:://////////////////////////////////////////////
//:: Created By: Brent Knowles
//:: Created On: September 6, 2002
//:://////////////////////////////////////////////
//:: Last Update By: Andrew Nobbs May 01, 2003
// [shadow 12/12/04]changed to haste rules

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
    object oTarget = GetSpellTargetObject();

    if (GetHasSpellEffect(SPELL_HASTE, oTarget) == TRUE)
    {
        return ; // does nothing if caster already has haste
    }
    if (GetHasSpellEffect(SPELL_EXPEDITIOUS_RETREAT, oTarget) == TRUE)
    {
        return ; // does nothing if caster already has expeditious retreat
    }

    // NWKnights
    //check if he holds a ball or a flag
    object LightBall = GetHenchman (oTarget);
    if (GetIsObjectValid(LightBall))
        if (GetTag(LightBall) == "LightBall")
        {
            FloatingTextStringOnCreature("Haste cannot be cast on the LightBall carrier",oTarget);
            return;
        }

    if ((GetLocalInt(oTarget,"hasgoldflag")==1)||
        (GetLocalInt(oTarget,"hassilverflag")==1))
    {
        FloatingTextStringOnCreature("Haste cannot be cast on the flag carrier",oTarget);
        return;
    }

    effect eHaste;

    if (GetLevelByClass(CLASS_TYPE_MONK, oTarget) > 14)
        return;
    if (GetLevelByClass(CLASS_TYPE_MONK, oTarget) > 11)
        eHaste = EffectMovementSpeedIncrease(5);
    else if (GetLevelByClass(CLASS_TYPE_MONK, oTarget) > 8)
        eHaste = EffectMovementSpeedIncrease(10);
    else if (GetLevelByClass(CLASS_TYPE_MONK, oTarget) > 5)
        eHaste = EffectMovementSpeedIncrease(20);
    else if (GetLevelByClass(CLASS_TYPE_MONK, oTarget) > 2 || GetLevelByClass(CLASS_TYPE_BARBARIAN, oTarget) > 0)
        eHaste = EffectMovementSpeedIncrease(30);
    else
        eHaste = EffectMovementSpeedIncrease(40);

    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink = EffectLinkEffects(eHaste, eDur);

    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = 1+GetCasterLevel(OBJECT_SELF)/4;
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 455, FALSE));

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
}
