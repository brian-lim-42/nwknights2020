//::///////////////////////////////////////////////
//:: Invisibility
//:: NW_S0_Invisib.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Target creature becomes invisibility
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "nwk_dom_inc"
#include "nwk_flag"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    // End of Spell Cast Hook
    //Declare major variables
    object oTarget = GetSpellTargetObject();


    //check if he holds a ball or a flag
    object LightBall = GetHenchman (oTarget);
    if (GetIsObjectValid(LightBall))
        if (GetTag(LightBall) == "LightBall")
        {
            FloatingTextStringOnCreature("Invisibility cannot be cast on the LightBall carrier",oTarget);
            return;
        }

    if (GetHasFlag ( oTarget ))
    {
        FloatingTextStringOnCreature("Invisibility cannot be cast on the flag carrier",oTarget);
        return;
    }
    if (GetIsInDominationArea (oTarget) )
    {
        if ( GetIsDominator ( oTarget, GetDominationArea ( oTarget ) ) )
        {
            FloatingTextStringOnCreature("Invisibility cannot be cast at the dominator inside the domination area",oTarget);
            return;
        }
    }


    //effect eVis = EffectVisualEffect(VFX_DUR_INVISIBILITY);
    effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    effect eLink = EffectLinkEffects(eInvis, eDur);
    //eLink = EffectLinkEffects(eLink, eVis);

    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_INVISIBILITY, FALSE));
    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }
    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
}

