//::///////////////////////////////////////////////
//:: Bigby's Grasping Hand
//:: [x0_s0_bigby3]
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    make an attack roll. If succesful target is held for 1 round/level
    [pentagon] change duration to 3 rounds.


*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: September 7, 2002
//:://////////////////////////////////////////////
//:: VFX Pass By:

#include "x0_i0_spells"

#include "x2_inc_spellhook"
#include "war_inc_stun"
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
    ////////////Sound Mind Cloak//////////////////
    object oCloak = GetItemInSlot (INVENTORY_SLOT_CLOAK, oTarget);
    string sCloak = GetTag (oCloak);
    //////////////////////////////////////////////
    // int nDuration = GetCasterLevel(OBJECT_SELF);
    int nDuration = 3;
    int nMetaMagic = GetMetaMagicFeat();
    effect eVis = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);

    //Check for metamagic extend
    if (nMetaMagic == METAMAGIC_EXTEND) //Duration is +100%
    {
         nDuration = nDuration * 2;
    }

    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 461, TRUE));

        // Check spell resistance
        if(!MyResistSpell(OBJECT_SELF, oTarget))
        {
            // Check caster ability vs. target's AC

            int nCasterModifier = GetCasterAbilityModifier(OBJECT_SELF);
            int nCasterRoll = d20(1)
                + nCasterModifier
                + GetCasterLevel(OBJECT_SELF) + 10 + -1;

            int nTargetRoll = GetAC(oTarget);

            ////Cloak Check
            if (sCloak != "ktSoundMindCloak")
            {
            ////Added will save with +5dc
            if(!/*Will Save*/ MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC()+5, SAVING_THROW_TYPE_SONIC))
            {
            // * bullrush succesful, knockdown target for duration of spell

            // * grapple HIT succesful,
            if (nCasterRoll >= nTargetRoll)
            {
                // * now must make a GRAPPLE check to
                // * hold target for duration of spell
                // * check caster ability vs. target's size & strength
                nCasterRoll = d20(1) + nCasterModifier
                    + GetCasterLevel(OBJECT_SELF) + 10 +4;

                nTargetRoll = GetSizeModifier(oTarget)
                    + GetAbilityModifier(ABILITY_STRENGTH);

                if (nCasterRoll >= nTargetRoll)
                {
                    // Hold the target paralyzed
                    effect eKnockdown = EffectParalyze();
                    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
                    effect eHand = EffectVisualEffect(VFX_DUR_BIGBYS_GRASPING_HAND);
                    effect eLink = EffectLinkEffects(eKnockdown, eDur);
                    eLink = EffectLinkEffects(eHand, eLink);
                    eLink = EffectLinkEffects(eVis, eLink);
                    if (GetIsImmune(oTarget, EFFECT_TYPE_PARALYZE) == FALSE)
                    {
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                                            eLink, oTarget,
                                            RoundsToSeconds(nDuration));


                        InitiateStunCheck ( oTarget, nDuration );



                        FloatingTextStrRefOnCreature(2478, OBJECT_SELF);
                    }
                }
                else
                {
                    FloatingTextStrRefOnCreature(83309, OBJECT_SELF);
                }
            }
            }
            ///else for will may be entered here -->
            }
            else
            {
                FloatingTextStringOnCreature ("Immuned - Sound Mind Cloak", OBJECT_SELF);
            }
        }
    }
}


