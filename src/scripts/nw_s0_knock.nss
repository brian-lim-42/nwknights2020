//::///////////////////////////////////////////////
//:: Knock
//:: NW_S0_Knock
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Opens doors not locked by magical means.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 29, 2001
//:://////////////////////////////////////////////
//:: Last Updated By: Preston Watamaniuk
//:: VFX Pass By: Preston W, On: June 22, 2001
//#include "nw_i0_spells"
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    object oTarget;
    float nRadius = 10.0;
    effect eVis = EffectVisualEffect(VFX_IMP_KNOCK);
    oTarget = GetFirstObjectInShape(SHAPE_SPHERE, nRadius, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    float fDelay;
    int nOpened;
    while(GetIsObjectValid(oTarget))
    {
//        fDelay = GetRandomDelay(0.5, 1.0);
        if(GetLocked(oTarget))
        {
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            nOpened = GetLocalInt(oTarget, "open") + 30;
            SetLocalInt(oTarget, "open", nOpened);
            AssignCommand(oTarget,ActionSpeakString(IntToString(150-nOpened)));
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, nRadius, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
    }
}
