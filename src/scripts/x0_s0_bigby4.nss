//::///////////////////////////////////////////////
//:: Bigby's Clenched Fist
//:: [x0_s0_bigby4]
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Does an attack EACH ROUND for 1 round/level.
    If the attack hits does
     1d8 +12 points of damage

    Any creature struck must make a FORT save or
    be stunned for one round.
    [pentagon] change duration to 3 rounds. each round the DC is less by 5 .
    meaning DC , DC -5 , DC -10

    GZ, Oct 15 2003:
    Changed how this spell works by adding duration
    tracking based on the VFX added to the character.
    Makes the spell dispellable and solves some other
    issues with wrong spell DCs, checks, etc.

*/
//:://////////////////////////////////////////////
//:: Created By: Brent
//:: Created On: September 7, 2002
//:://////////////////////////////////////////////
//:: Last Updated By: Georg Zoeller October 15, 2003

#include "x0_i0_spells"
#include "x2_inc_spellhook"
#include "x2_i0_spells"
#include "war_inc_stun"

int nSpellID = 462;

void RunHandImpact(object oTarget, object oCaster,int dcModifier)
{

    ////////////Sound Mind Cloak//////////////////
    object oCloak = GetItemInSlot (INVENTORY_SLOT_CLOAK, oTarget);
    string sCloak = GetTag (oCloak);
    //////////////////////////////////////////////

    //--------------------------------------------------------------------------
    // Check if the spell has expired (check also removes effects)
    //--------------------------------------------------------------------------
    if (GZGetDelayedSpellEffectsExpired(nSpellID,oTarget,oCaster))
    {
        return;
    }

    int nCasterModifiers = GetCasterAbilityModifier(oCaster) + GetCasterLevel(oCaster);
    int nCasterRoll = d20(1) + nCasterModifiers + 11 + -1;
    int nTargetRoll = GetAC(oTarget);
    if (nCasterRoll >= nTargetRoll)
    {
       int nDC = GetLocalInt(oTarget,"XP2_L_SPELL_SAVE_DC_" + IntToString (nSpellID));

       int nDam  = MaximizeOrEmpower(8, 1, GetMetaMagicFeat(), 11);
       effect eDam = EffectDamage(nDam, DAMAGE_TYPE_BLUDGEONING);
       effect eVis = EffectVisualEffect(VFX_IMP_ACID_L);

       ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
       ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
       ////Cloak Check
       if (sCloak != "ktSoundMindCloak")
       {
       if (!MySavingThrow(SAVING_THROW_FORT, oTarget, nDC-dcModifier))
       {
           ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectStunned(), oTarget, RoundsToSeconds(1));
           InitiateStunCheck ( oTarget, 1 );
       }
       }
       else
       {
       FloatingTextStringOnCreature ("Immuned - Sound Mind Cloak", OBJECT_SELF);
       }
      DelayCommand(6.0f,RunHandImpact(oTarget,oCaster,dcModifier+5));



   }
}



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

    object oTarget = GetSpellTargetObject();

    ////////////Sound Mind Cloak//////////////////
    object oCloak = GetItemInSlot (INVENTORY_SLOT_CLOAK, oTarget);
    string sCloak = GetTag (oCloak);
    //////////////////////////////////////////////

    //--------------------------------------------------------------------------
    // This spell no longer stacks. If there is one hand, that's enough
    //--------------------------------------------------------------------------
    if (GetHasSpellEffect(nSpellID,oTarget) ||  GetHasSpellEffect(463,oTarget)  )
    {
        FloatingTextStrRefOnCreature(100775,OBJECT_SELF,FALSE);
        return;
    }

    //int nDuration = GetCasterLevel(OBJECT_SELF);
    int nDuration = 3;
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
         nDuration = nDuration * 2;
    }

    if(!GetIsReactionTypeFriendly(oTarget))
    {
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpellID, TRUE));
        int nResult = MyResistSpell(OBJECT_SELF, oTarget);

        ////Cloak Check
        if (sCloak != "ktSoundMindCloak")
        {
        if (nResult  == 0)
        {
            int nCasterModifier = GetCasterAbilityModifier(OBJECT_SELF);
            effect eHand = EffectVisualEffect(VFX_DUR_BIGBYS_CLENCHED_FIST);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eHand, oTarget, RoundsToSeconds(nDuration));

            //----------------------------------------------------------
            // GZ: 2003-Oct-15
            // Save the current save DC on the character because
            // GetSpellSaveDC won't work when delayed
            //----------------------------------------------------------
            SetLocalInt(oTarget,"XP2_L_SPELL_SAVE_DC_" + IntToString (nSpellID), GetSpellSaveDC());
            object oSelf = OBJECT_SELF;
            RunHandImpact(oTarget,OBJECT_SELF,0 );

        }
        }
        else
        {
        FloatingTextStringOnCreature ("Immuned - Sound Mind Cloak", OBJECT_SELF);
        }
    }
}

