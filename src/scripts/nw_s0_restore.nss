//::///////////////////////////////////////////////
//:: Restoration
//:: NW_S0_Restore.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Removes all negative effects unless they come
    from Poison, Disease or Curses.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 22, 2001
// [shadow 13/12/04]: inserted spell hoook code
// [shadow 13/12/04]: decreased skill will not be cured if
//                    - flag carrier
//                    - king
// [shadow 06/11/30]: decresed skill / hide/ms malus wil not be cured during
//                    ownership of domination area


#include "nwk_flag"
#include "nwk_king"
#include "nwk_dom_inc"
#include "x2_inc_spellhook"

// return TRUE if the effect created by a supernatural force and can't be dispelled by spells
int GetIsSupernaturalCurse(effect eEff);

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-23 by GeorgZ
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
    effect eVisual = EffectVisualEffect(VFX_IMP_RESTORATION);
    int bValid;

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
            GetEffectType(eBad) == EFFECT_TYPE_PARALYZE ||
            GetEffectType(eBad) == EFFECT_TYPE_NEGATIVELEVEL)
        {
                RemoveEffect(oTarget, eBad);
        }
        // NWKnights
        // shifted to allow seperate processing
        if ( GetEffectType(eBad) == EFFECT_TYPE_SKILL_DECREASE )
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
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RESTORATION, FALSE));

    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oTarget);
}

int GetIsSupernaturalCurse(effect eEff)
{
    object oCreator = GetEffectCreator(eEff);
    if(GetTag(oCreator) == "q6e_ShaorisFellTemple")
        return TRUE;
    return FALSE;
}
