//::///////////////////////////////////////////////
//:: Greater Restoration
//:: NW_S0_GrRestore.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Removes all negative effects of a temporary nature
    and all permanent effects of a supernatural nature
    from the character. Does not remove the effects
    relating to Mind-Affecting spells or movement alteration.
    Heals target for 5d8 + 1 point per caster level.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 20, 2001
// [shadow 13/12/04]: inserted spell hoook code
// [shadow 13/12/04]: decreased skill / speed will not be cured if
//                    - flag carrier
//                    - king
// [shadow 06/11/30]: decresed skill / hide/ms malus wil not be cured during
//                    ownership of domination area


#include "nwk_flag"
#include "nwk_king"
#include "nwk_dom_inc"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    // End of Spell Cast Hook

      //if the caster has invisibility(any type) on it, it will be removed.
  removeInvisibilitySpell(OBJECT_SELF);

    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION_GREATER);

    effect eBad = GetFirstEffect(oTarget);
    //Search for negative effects
    while(GetIsEffectValid(eBad))
    {
        if (GetEffectType(eBad) == EFFECT_TYPE_ABILITY_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_AC_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_ATTACK_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_DAMAGE_IMMUNITY_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SAVING_THROW_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_SPELL_RESISTANCE_DECREASE ||
            GetEffectType(eBad) == EFFECT_TYPE_BLINDNESS ||
            GetEffectType(eBad) == EFFECT_TYPE_DEAF ||
            GetEffectType(eBad) == EFFECT_TYPE_CURSE ||
            GetEffectType(eBad) == EFFECT_TYPE_DISEASE ||
            GetEffectType(eBad) == EFFECT_TYPE_POISON ||
            GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_CHARMED ||
            GetEffectType(eBad) == EFFECT_TYPE_DOMINATED ||
            GetEffectType(eBad) == EFFECT_TYPE_DAZED ||
            GetEffectType(eBad) == EFFECT_TYPE_CONFUSED ||
            GetEffectType(eBad) == EFFECT_TYPE_FRIGHTENED ||
            GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL ||
            GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_STUNNED)
        {

            //Remove effect if it is negative.
            RemoveEffect(oTarget, eBad);
        }
        // NWKnights
        // shifted to allow seperate processing
        if (GetEffectType(eBad)== EFFECT_TYPE_SLOW ||
            GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE )
        {
            // find out, if sitting on thrown
            object oThrown = GetNearestObjectByTag ( TAG_THROWN, oTarget );
            int bIsSitting = FALSE;
            if ( GetIsObjectValid ( oThrown ) )
            {
                if ( GetSittingCreature ( oThrown ) == oTarget ) bIsSitting = TRUE;
            }
            if ( ! ( GetLocalInt ( oTarget, VARNAME_FLAG_TAKEN_SILVER ) ||
                     GetLocalInt ( oTarget, VARNAME_FLAG_TAKEN_GOLD ) ||
                     bIsSitting ||
                     GetIsActiveDominator ( oTarget ) ) )
            {
                RemoveEffect(oTarget, eBad);
            }
        }
        eBad = GetNextEffect(oTarget);
    }
    if(GetRacialType(oTarget) != RACIAL_TYPE_UNDEAD)
    {
        //Apply the VFX impact and effects
        int nHeal = GetCasterLevel (OBJECT_SELF) * 5;
        effect eHeal = EffectHeal(nHeal);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
    }
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_GREATER_RESTORATION, FALSE));

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget);
}

