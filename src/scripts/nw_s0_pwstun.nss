//::///////////////////////////////////////////////
//:: [Power Word Stun]
//:: [NW_S0_PWStun.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
/*
    The creature is stunned for a certain number of
    rounds depending on its HP.  No save.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Feb 4, 2001
//:://////////////////////////////////////////////
//:: VFX Pass By: Preston W, On: June 22, 2001

/*
bugfix by Kovi 2002.07.28
- =151HP stunned for 4d4 rounds
- >151HP sometimes stunned for indefinit duration
*/


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
    int nHP =  GetCurrentHitPoints(oTarget);
    effect eStun = EffectStunned();
    effect eMind = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
    effect eLink = EffectLinkEffects(eMind, eStun);
    effect eVis = EffectVisualEffect(VFX_IMP_STUN);
    effect eWord = EffectVisualEffect(VFX_FNF_PWSTUN);
    int nDuration;
    int nMetaMagic = GetMetaMagicFeat();
    int nMeta;
    //Apply the VFX impact
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eWord, GetSpellTargetLocation());

    //Make a Will roll to avoid being stunned
    if(!/*Will Save*/ MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC()+5, SAVING_THROW_TYPE_SONIC))
    {
    //Determine the number rounds the creature will be stunned
    if (nHP >= 151)
    {
        nDuration = 3;
        nMeta = 3;
    }
    else if (nHP >= 101 && nHP <= 150)
    {
        nDuration = 3;
        nMeta = 3;
    }
    else if (nHP >= 51  && nHP <= 100)
    {
        nDuration = 3;
        nMeta = 3;
    }
    else
    {
        nDuration = 3;
        nMeta = 3;
    }
    }

    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_MAXIMIZE)
    {
        nDuration = nMeta;//Damage is at max
    }
    else if (nMetaMagic == METAMAGIC_EMPOWER)
    {
        nDuration = nDuration + (nDuration/2); //Damage/Healing is +50%
    }
    else if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration * 2;  //Duration is +100%
    }

    if(!GetIsReactionTypeFriendly(oTarget))
    {
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_POWER_WORD_STUN));
        //Make an SR check
        if(!MyResistSpell(OBJECT_SELF, oTarget))
        {
            //Apply linked effect and the VFX impact
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
            InitiateStunCheck (oTarget, nDuration);
        }
    }
}

