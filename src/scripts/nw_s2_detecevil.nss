//::///////////////////////////////////////////////
//:: Detect_Evil
//:: NW_S2_DetecEvil.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All creatures of Evil Alignment within LOS of
    the Paladin glow for a few seconds.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Aug 14, 2001
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    // End of Spell Cast Hook
    //Declare major variables
    object oTarget;
    int nEvil;
    effect eVis = EffectVisualEffect(VFX_COM_SPECIAL_RED_WHITE);
    effect eVis2 = EffectVisualEffect(VFX_DUR_TENTACLE);

    //Get first target in spell area
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        //Check the current target's alignment
        nEvil = GetAlignmentGoodEvil(OBJECT_SELF);
        if(nEvil == ALIGNMENT_EVIL)
        {
            //Apply the VFX
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis, oTarget, 3.0);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eVis2, oTarget, 3.0);

        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }
}

