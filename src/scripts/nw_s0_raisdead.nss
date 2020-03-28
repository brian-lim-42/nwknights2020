//::///////////////////////////////////////////////
//:: [Raise Dead]
//:: [NW_S0_RaisDead.nss]
//:: Copyright (c) 2000 Bioware Corp.
//:://////////////////////////////////////////////
//:: Brings a character back to life with 1 HP.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 31, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk, On: April 11, 2001
//:: VFX Pass By: Preston W, On: June 22, 2001

#include "x2_inc_spellhook"
#include "NW_I0_SPELLS"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    // End of Spell Cast Hook
    //if (CanCastSpell(OBJECT_SELF))
    //{
    //Declare major variables
    string sTeamcaster = GetLocalString(OBJECT_SELF, "team");
    object oTarget = GetSpellTargetObject();
    string sTeamtarget = GetLocalString(oTarget, "team");
    if (sTeamcaster == sTeamtarget)
    {
        RemoveSpecificEffect ( EFFECT_TYPE_INVISIBILITY, OBJECT_SELF );
        effect eRaise = EffectResurrection();
        effect eVis = EffectVisualEffect(VFX_IMP_RAISE_DEAD);
        if(GetIsDead(oTarget))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_RAISE_DEAD, FALSE));
            //Apply raise dead effect and VFX impact
            ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTarget));
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eRaise, oTarget);

        }
    }

}


