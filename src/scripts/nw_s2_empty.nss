//::///////////////////////////////////////////////
//:: Empty Body
//:: NW_S2_Empty.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Target creature can attack and cast spells while
    invisible
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////

/*
bugfix by Kovi 2002.07.28
- was not a supernatual effect
*/
#include "nw_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    // End of Spell Cast Hook
  //  SpeakString("WOW nothing happans");

   //Declare major variables
/*    int nSpell = GetSpellId();
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_IMP_POLYMORPH);
    effect ePoly;
    int nPoly;
    int nMetaMagic = GetMetaMagicFeat();
    int nDuration = 20;

          nPoly = POLYMORPH_TYPE_WERECAT;

    ePoly = EffectPolymorph(nPoly);
    //Fire cast spell at event for the specified target
  //  SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_WILD_SHAPE, FALSE));

    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, ePoly, OBJECT_SELF, HoursToSeconds(nDuration));
     */

    if(!GetHasFeatEffect(FEAT_EMPTY_BODY))
    {

        //Declare major variables
        object oTarget = OBJECT_SELF;
        effect eVis = EffectVisualEffect(VFX_DUR_INVISIBILITY);
        effect eCover = EffectConcealment(50);
        effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
        effect eLink = EffectLinkEffects(eCover, eVis);
        eLink = EffectLinkEffects(eLink, eDur);

        eLink = SupernaturalEffect(eLink);
        // remove all concealment effects to avoid stacking
        RemoveSpecificEffect ( EFFECT_TYPE_CONCEALMENT, oTarget );
        //Fire cast spell at event for the specified target
        SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_EMPTY_BODY, FALSE));
        int nDuration = GetLevelByClass(CLASS_TYPE_MONK)/2;

        //Apply the VFX impact and effects
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
    }
       //Declare major variables
  /*
    int nEvil;
    eVis = EffectVisualEffect(VFX_DUR_LIGHT_RED_10);

    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, 3.0);
    //Get first target in spell area
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        //Check the current target's alignment
  //      nEvil = GetAlignmentGoodEvil(OBJECT_SELF);
  //      if(nEvil == ALIGNMENT_EVIL)
  //      {
            //Apply the VFX
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, 3.0);
  //      }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    } */
}
