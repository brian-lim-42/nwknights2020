//::///////////////////////////////////////////////
//:: Invisibility Sphere
//:: NW_S0_InvSph.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All allies within 30ft are rendered invisible.
    [shadow} changed to a mass invis effect
             if anyone know who to disable the area in case the mage
             cast a spell or is attacked, it should be changed.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
#include "nwk_dom_inc"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    // End of Spell Cast Hook
    object oTarget;
    location lSpell = GetLocation (OBJECT_SELF);
    //Declare major variables including Area of Effect Object

    //effect eVis = EffectVisualEffect(VFX_DUR_INVISIBILITY);
    effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);

    effect eLink = EffectLinkEffects(eInvis, eDur);
    //eLink = EffectLinkEffects(eLink, eVis);

    int nDuration = GetCasterLevel(OBJECT_SELF);
    int nMetaMagic = GetMetaMagicFeat();
    //Enter Metamagic conditions
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }



        oTarget = GetFirstObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lSpell);
        //Cycle through the targets within the spell shape until an invalid object is captured or the number of
        //targets affected is equal to the caster level.
        int nCount = 0;
        while(GetIsObjectValid(oTarget) && nCount != nDuration)
        {
            //Make faction check on the target
            if(GetIsFriend(oTarget))
            {
                int bTargetValid = TRUE;

                //////////check if he holds a ball or a flag

                //check if he holds a ball or a flag
                object LightBall = GetHenchman (oTarget);
                if (GetIsObjectValid(LightBall))
                    if (GetTag(LightBall) == "LightBall")
                    {
                        FloatingTextStringOnCreature("Invisibility cannot be cast on the LightBall carrier",oTarget);
                        bTargetValid = FALSE;
                    }

                if ((GetLocalInt(oTarget,"hasgoldflag")==1)||
                    (GetLocalInt(oTarget,"hassilverflag")==1))
                {
                    FloatingTextStringOnCreature("Invisibility cannot be cast on the flag carrier",oTarget);
                    bTargetValid = FALSE;
                }
                if (GetIsInDominationArea (oTarget) )
                {
                    if ( GetIsDominator ( oTarget, GetDominationArea ( oTarget ) ) )
                    {
                        FloatingTextStringOnCreature("Invisibility cannot be cast at the dominator inside the domination area",oTarget);
                        bTargetValid = FALSE;
                    }
                }

                //////////////////

                if ( bTargetValid )
                {
                    //Apply the VFX impact and effects
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
                    //Fire cast spell at event for the specified target
                    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_INVISIBILITY, FALSE));
                    nCount++;
                }
            }
            //Select the next target within the spell shape.
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, RADIUS_SIZE_COLOSSAL, lSpell);
        }

}
