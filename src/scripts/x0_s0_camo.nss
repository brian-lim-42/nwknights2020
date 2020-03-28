//::///////////////////////////////////////////////
//:: Camoflage
//:: x0_s0_camo.nss
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
 bonus +10 to Hide checks
*/
//:://////////////////////////////////////////////
//:: Created By: Brent Knowles
//:: Created On: July 19, 2002
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

//check if he holds a ball or a flag
    object oTarget = OBJECT_SELF;
    object LightBall = GetHenchman (oTarget);
    if (GetIsObjectValid(LightBall))
        if (GetTag(LightBall) == "LightBall")
        {
            FloatingTextStringOnCreature("Camoflage cannot be cast on the LightBall carrier",oTarget);
            return;
        }

    if ((GetLocalInt(oTarget,"hasgoldflag")==1)||
        (GetLocalInt(oTarget,"hassilverflag")==1))
    {
        FloatingTextStringOnCreature("Camoflage cannot be cast on the flag carrier",oTarget);
        return;
    }
    if (GetIsInDominationArea (oTarget) )
    {
        if ( GetIsDominator ( oTarget, GetDominationArea ( oTarget ) ) )
        {
            FloatingTextStringOnCreature("Camoflage cannot be cast at the dominator inside the domination area",oTarget);
            return;
        }
    }
    DoCamoflage(OBJECT_SELF);

}





