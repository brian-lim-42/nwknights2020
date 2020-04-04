#include "nwk_constants"
#include "nwk_colors"
#include "nwk_flag"

void main()
{
    object oItem = GetItemActivated();
    string sItemTag = GetTag(oItem);
    object oPC = GetItemActivator();

    if (sItemTag == "ktOffenseCloak") {
        object oTarget = GetItemActivatedTarget();
        ActionCastSpellAtObject(SPELL_BULLS_STRENGTH, oTarget, METAMAGIC_MAXIMIZE);
    }
    else if (sItemTag == "ktArcherCloak") {
        object oTarget = GetItemActivatedTarget();
        ActionCastSpellAtObject(SPELL_CATS_GRACE, oTarget, METAMAGIC_MAXIMIZE);
    }
    else if (sItemTag == "ktDefenseCloak") {
        object oTarget = GetItemActivatedTarget();
        ActionCastSpellAtObject(SPELL_ENDURANCE, oTarget, METAMAGIC_MAXIMIZE);
    }
    else if (sItemTag == "ktHealingKit" || sItemTag == "ktHealingKit")
    {
        //Declare major variables
        object oTarget = GetItemActivatedTarget();
        effect eDam;
        effect eHeal;
        effect eVis = EffectVisualEffect(VFX_IMP_HEALING_L);
        effect eVis2 = EffectVisualEffect(VFX_IMP_HEAD_HEAL);
        int nToHeal;
        if (GetIsInCombat(oPC))
            nToHeal = GetSkillRank(SKILL_HEAL, oPC) + 10 + d20();
        else
            nToHeal = GetSkillRank(SKILL_HEAL, oPC) + 30;
        if (GetRacialType(oTarget) == RACIAL_TYPE_UNDEAD)
        {
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CURE_LIGHT_WOUNDS));
//            if (!MyResistSpell(OBJECT_SELF, oTarget))
//            {
                //Make will save for half damage
//                if (MySavingThrow(SAVING_THROW_WILL, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_POSITIVE))
//                   {
//                   nToHeal /= 2;
//                   }
                //Apply VFX impact and damage
                eDam = EffectDamage(nToHeal,DAMAGE_TYPE_POSITIVE);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eDam, oTarget);
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis2, oTarget);
//            }
        }
        else
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_CURE_LIGHT_WOUNDS, FALSE));
            //Apply VFX impact and heal effect
            eHeal = EffectHeal(nToHeal);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget);
        }
    }
    else if (sItemTag == "RecallStone" || sItemTag == "RecallStone")
    {
      if (! GetHasFlag (oPC ))
      {
      string team= GetLocalString(oPC,"team");
      location lDest;
      effect eEffect = EffectVisualEffect(VFX_IMP_UNSUMMON,FALSE);
      ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,oPC,1.0);
          if (team=="SILVER")
          {
          lDest = GetLocation(GetObjectByTag(mapFullTagName("SANC_SILVER")));
          }
          else if (team=="GOLD")
          {
          lDest = GetLocation(GetObjectByTag(mapFullTagName("SANC_GOLD")));
          }
      AssignCommand(oPC, ActionJumpToLocation(lDest));
      JumpHenchmen(oPC, lDest, 6);
      }
      else
      {
      FloatingTextStringOnCreature ("Recall failed - Flag Carrier", oPC);
      }
    }
    ExecuteScript ( "a_" + sItemTag, oPC );

}
