//::///////////////////////////////////////////////
//:: Mass Haste
//:: NW_S0_MasHaste.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All allies in a 30 ft radius from the point of
    impact become Hasted for 1 round per caster
    level.  The maximum number of allies hasted is
    1 per caster level.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 29, 2001
//:://////////////////////////////////////////////
// [pentagon 2/10/04] fix infinite loop on ball/flag carrier
// [shadow   12/12/04 replace continue statements to avoid
//                    infinite loop if last target is flag in invalid
//#include "NW_I0_SPELLS"

//#include "pvp_nwtactics"
#include "nwk_flag"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }

    //Declare major variables
    object oTarget;
    effect eHaste;
    effect eVis = EffectVisualEffect(VFX_IMP_HASTE);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eLink;
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_NORMAL_30);
    int nMetaMagic = GetMetaMagicFeat();
    float fDelay;
    //Determine spell duration as an integer for later conversion to Rounds, Turns or Hours.
    int nDuration = 1+GetCasterLevel(OBJECT_SELF)/4;

    location lSpell = GetSpellTargetLocation();

    //Meta Magic check for extend
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration +3;   //Duration is +100%
    }

    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());

    //Declare the spell shape, size and the location.  Capture the first target object in the shape.
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lSpell);
    int nCount = 0;
    //Cycle through the targets within the spell shape until an invalid object is captured or the number of
    //targets affected is equal to the caster level.
    while(GetIsObjectValid(oTarget) && nCount != nDuration)
    {
        //Make faction check on the target
        if(GetIsFriend(oTarget))
        {
        //////////check if he holds a ball or a flag

            object LightBall = GetHenchman (oTarget);
            int bTargetValid = TRUE;
            if (GetIsObjectValid(LightBall))
            {
                if (GetTag(LightBall) == "LightBall")
                {
                    FloatingTextStringOnCreature("Haste cannot be cast on the LightBall carrier",oTarget);
                    bTargetValid = FALSE;
                }
            }
            if (GetHasFlag(oTarget))
            {
                FloatingTextStringOnCreature("Haste cannot be cast on the flag carrier",oTarget);
                bTargetValid = FALSE;
            }
            //////////////////
            // Check for speed increase
            effect eEffect = GetFirstEffect(oTarget);
            while (GetIsEffectValid(eEffect) == TRUE)
            {
                if (GetEffectType(eEffect) == EFFECT_TYPE_MOVEMENT_SPEED_INCREASE ||
                    GetEffectType(eEffect) == EFFECT_TYPE_HASTE)
                    bTargetValid = FALSE;
                eEffect=GetNextEffect(oTarget);
            }
            if ( bTargetValid )
            {
                if (! ( GetLevelByClass(CLASS_TYPE_MONK, oTarget) > 14) )
                {
                    if (GetLevelByClass(CLASS_TYPE_MONK, oTarget) > 11)
                        eHaste = EffectMovementSpeedIncrease(5);
                    else if (GetLevelByClass(CLASS_TYPE_MONK, oTarget) > 8)
                        eHaste = EffectMovementSpeedIncrease(10);
                    else if (GetLevelByClass(CLASS_TYPE_MONK, oTarget) > 5)
                        eHaste = EffectMovementSpeedIncrease(20);
                    else if (GetLevelByClass(CLASS_TYPE_MONK, oTarget) > 2 ||
                             GetLevelByClass(CLASS_TYPE_BARBARIAN, oTarget) > 0)
                        eHaste = EffectMovementSpeedIncrease(30);
                    else
                        eHaste = EffectMovementSpeedIncrease(40);
                    eLink = EffectLinkEffects(eHaste, eDur);
                    //WriteTimestampedLogEntry ( "### NWK_DEBUG: mass haste - cast spell on target " + GetName (oTarget) );
                    //                fDelay = GetRandomDelay(0.0, 1.0);
                    //Fire cast spell at event for the specified target
                    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_MASS_HASTE, FALSE));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration)));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
                    nCount++;
                }
            }
        }
        //Select the next target within the spell shape.
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lSpell);
    }

}


