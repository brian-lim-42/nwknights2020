//::///////////////////////////////////////////////
//:: [Ressurection]
//:: [NW_S0_Ressurec.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Brings a character back to life with full
//:: health.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 31, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 11, 2001
//:: VFX Pass By: Preston W, On: June 22, 2001
//[pentagon 2/10/04] hp is (max_hp/6)+10
#include "x2_inc_spellhook"
#include "NW_I0_SPELLS"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    // End of Spell Cast Hook
    //Get the spell target
    object oTarget = GetSpellTargetObject();
    //Check to make sure the target is dead first
    string sTeamcaster = GetLocalString(OBJECT_SELF, "team");
    string sTeamtarget = GetLocalString(oTarget, "team");
    if (sTeamcaster == sTeamtarget)
    {
        RemoveSpecificEffect ( EFFECT_TYPE_INVISIBILITY, OBJECT_SELF );
        if (GetIsDead(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RESURRECTION, FALSE));
            //Declare major variables
            int nHealed = GetCasterLevel (OBJECT_SELF) * 5;
            effect eRaise = EffectResurrection();
            effect eHeal = EffectHeal(nHealed);
            effect eVis = EffectVisualEffect(VFX_IMP_RAISE_DEAD);
            //Apply the heal, raise dead and VFX impact effect
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eRaise, oTarget);
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eHeal, oTarget);
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTarget));
        }
    }
}

