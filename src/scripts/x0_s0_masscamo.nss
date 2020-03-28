//::///////////////////////////////////////////////
//:: Mass Camoflage
//:: x0_s0_masscamo.nss
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    +10 hide bonus to all allies in area
*/
//:://////////////////////////////////////////////
//:: Created By: Brent Knowles
//:: Created On: July 24, 2002
//:://////////////////////////////////////////////
//:: VFX Pass By:
#include "X0_I0_SPELLS"

#include "x2_inc_spellhook"
#include "nwk_dom_inc"
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



    // * now setup benefits for allies
        //Apply Impact
    effect eImpact = EffectVisualEffect(VFX_FNF_LOS_HOLY_30);
    float fDelay = 0.0;
    effect eVis = EffectVisualEffect(VFX_IMP_HEAD_HOLY);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, GetSpellTargetLocation());

    //Get the first target in the radius around the caster
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oTarget))
    {
        int bTargetValid = TRUE;

        //////////check if he holds a ball or a flag

        //check if he holds a ball or a flag
        object LightBall = GetHenchman (oTarget);
        if (GetIsObjectValid(LightBall))
            if (GetTag(LightBall) == "LightBall")
            {
                FloatingTextStringOnCreature("Camoflage cannot be cast on the LightBall carrier",oTarget);
                bTargetValid = FALSE;
            }

        if ((GetLocalInt(oTarget,"hasgoldflag")==1)||
            (GetLocalInt(oTarget,"hassilverflag")==1))
        {
            FloatingTextStringOnCreature("Camoflage cannot be cast on the flag carrier",oTarget);
            bTargetValid = FALSE;
        }
        if (GetIsInDominationArea (oTarget) )
        {
            if ( GetIsDominator ( oTarget, GetDominationArea ( oTarget ) ) )
            {
                FloatingTextStringOnCreature("Camoflage cannot be cast at the dominator inside the domination area",oTarget);
                bTargetValid = FALSE;
            }
        }

        //////////////////

        if ( bTargetValid )
        {
            if(GetIsReactionTypeFriendly(oTarget) || GetFactionEqual(oTarget))
            {
                // fDelay = GetRandomDelay(0.4, 1.1);
                //Fire spell cast at event for target
                // SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, 454, FALSE));
                DoCamoflage(oTarget);
            }
        }
        //Get the next target in the specified area around the caster
        oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, GetLocation(OBJECT_SELF));
    }

}









