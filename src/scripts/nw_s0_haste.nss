//::///////////////////////////////////////////////
//:: Haste
//:: NW_S0_Haste.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Gives the targeted creature one extra partial
    action per round.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 29, 2001
//:://////////////////////////////////////////////
#include "nwk_flag"
#include "x2_inc_spellhook"
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
                FloatingTextStringOnCreature("Haste cannot be cast on the LightBall carrier",oTarget);
                return;
            }

        if (GetHasFlag(oTarget))
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

            effect eVis = EffectVisualEffect(VFX_IMP_HASTE);
            effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
            effect eLink = EffectLinkEffects(eHaste, eDur);



            int nDuration = 1+GetCasterLevel(OBJECT_SELF)/4;

            int nMetaMagic = GetMetaMagicFeat();
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HASTE, FALSE));
            //Check for metamagic extension
            if (nMetaMagic == METAMAGIC_EXTEND)
            {
                nDuration = nDuration + 3;
            }
            // Apply effects to the currently selected target.
            effect eEffect = GetFirstEffect(oTarget);
            while (GetIsEffectValid(eEffect) == TRUE)
            {
                if (GetEffectType(eEffect) == EFFECT_TYPE_MOVEMENT_SPEED_INCREASE || GetEffectType(eEffect) == EFFECT_TYPE_HASTE)
                    return;
                eEffect=GetNextEffect(oTarget);
            }
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
//    }
}
