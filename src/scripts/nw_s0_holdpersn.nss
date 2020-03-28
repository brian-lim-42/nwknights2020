//::///////////////////////////////////////////////
//:: Hold Person
//:: NW_S0_HoldPers
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
//:: The target freezes in place, standing helpless.
//:: He is aware and breathes normally but cannot take any physical
//:: actions, even speech. He can, however, execute purely mental actions.
//:: winged creature that is held cannot flap its wings and falls.
//:: A swimmer can't swim and may drown.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Soleski
//:: Created On: Jan 18, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 10, 2001
//:: VFX Pass By: Preston W, On: June 20, 2001

#include "NW_I0_SPELLS"
#include "war_inc_stun"
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
    int nCasterLvl = d2()+ 1;
    int nMeta = GetMetaMagicFeat();
    int nDuration = nCasterLvl;
    effect eParal = EffectParalyze();
    effect eVis = EffectVisualEffect(82);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eDur2 = EffectVisualEffect(VFX_DUR_PARALYZED);
    effect eDur3 = EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);

    effect eLink = EffectLinkEffects(eDur2, eDur);
    eLink = EffectLinkEffects(eLink, eParal);
    eLink = EffectLinkEffects(eLink, eVis);
    eLink = EffectLinkEffects(eLink, eDur3);

    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_HOLD_PERSON));
        //Make sure the target is a humanoid
        if (GetIsPlayableRacialType(oTarget) ||
            GetRacialType(oTarget) == RACIAL_TYPE_HUMANOID_GOBLINOID ||
            GetRacialType(oTarget) == RACIAL_TYPE_HUMANOID_MONSTROUS ||
            GetRacialType(oTarget) == RACIAL_TYPE_HUMANOID_ORC ||
            GetRacialType(oTarget) == RACIAL_TYPE_HUMANOID_REPTILIAN)
        {
            //Make SR Check
            if (!MyResistSpell(OBJECT_SELF, oTarget))
            {
                //Make Will save
                if (!/*Will Save*/ MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC() + 1, SAVING_THROW_TYPE_SPELL))
                {
                    //Make metamagic extend check
                    if (nMeta == METAMAGIC_EXTEND)
                    {
                        nDuration = nDuration + 1;



                    }


          //////////// DEBUG //////////////////
          //         nDuration=20;

          ///////////          ////////////////////
                    //Apply paralyze effect and VFX impact
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));

                    //put delayed checks to determine wheter pc got damaged.
                    //if duration is 3 rounds , check twice a round
                    //in (3,6) and (9,12) and 15  , no need for 18 cause it will be  gone already)
                    InitiateStunCheck (oTarget, nDuration);

                }
            }
        }
    }
}
