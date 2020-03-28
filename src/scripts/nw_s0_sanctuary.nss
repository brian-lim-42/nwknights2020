//::///////////////////////////////////////////////
//:: Sanctuary
//:: NW_S0_Sanctuary.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Makes the target creature invisible to hostile
    creatures unless they make a Will Save to ignore
    the Sanctuary Effect
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
                FloatingTextStringOnCreature("Sanctuary cannot be cast on the LightBall carrier",oTarget);
                return;
            }

        if ( GetHasFlag ( oTarget ) )
        {
            FloatingTextStringOnCreature("Sanctuary cannot be cast on the flag carrier",oTarget);
            return;
        }
        if (GetIsInDominationArea (oTarget) )
        {
            if ( GetIsDominator ( oTarget, GetDominationArea ( oTarget ) ) )
            {
                FloatingTextStringOnCreature("Sanctuary cannot be cast at the dominator inside the domination area",oTarget);
                return;
            }
        }


    effect eVis = EffectVisualEffect(VFX_DUR_SANCTUARY);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eSanc = EffectSanctuary(GetSpellSaveDC());

    effect eLink = EffectLinkEffects(eVis, eSanc);
    eLink = EffectLinkEffects(eLink, eDur);

    int nDuration = 1+GetCasterLevel(OBJECT_SELF)/5;
    //Enter Metamagic conditions
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SANCTUARY, FALSE));
    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
}

