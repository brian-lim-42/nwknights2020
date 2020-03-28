//::///////////////////////////////////////////////
//:: Shapechange
//:: NW_S0_ShapeChg.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 22, 2002
//:://////////////////////////////////////////////
//[pentagon] changed to point to NWK polymorph values
    //and also , made the poly effect undelayed (because of monk ac check)
#include "nwk_polymorph"

#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    // End of Spell Cast Hook
    //Declare major variables
    int nSpell = GetSpellId();
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_3);
    effect ePoly;
    int nPoly;
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = GetCasterLevel(OBJECT_SELF);
    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }

    //Determine Polymorph subradial type
    if(nSpell == 392)
    {
       // nPoly = POLYMORPH_TYPE_RED_DRAGON;
       nPoly = getDragonPolymorphConstAccordingToTeam(OBJECT_SELF);
    }
    else if (nSpell == 393)
    {
        nPoly = NWK_POLYMORPH_TYPE_FIRE_GIANT;
    }
    else if (nSpell == 394)
    {
        nPoly = NWK_POLYMORPH_TYPE_BALOR;
    }
    else if (nSpell == 395)
    {
        nPoly = NWK_POLYMORPH_TYPE_DEATH_SLAAD;
    }
    else if (nSpell == 396)
    {
        nPoly = NWK_POLYMORPH_TYPE_IRON_GOLEM;
    }
    ePoly = EffectPolymorph(nPoly);
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_SHAPECHANGE, FALSE));

    //Apply the VFX impact and effects
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(oTarget));
   // DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oTarget, RoundsToSeconds(nDuration)));
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, oTarget, RoundsToSeconds(nDuration));

    addPolymoprhAbilitiesToPC(oTarget,nPoly);
    addACDecreaseIfPCIsMonk(oTarget);

}
