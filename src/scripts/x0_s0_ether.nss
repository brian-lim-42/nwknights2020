//::///////////////////////////////////////////////
//:: Etherealness
//:: x0_s0_ether.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Like sanctuary except almost always guaranteed
    to work.
    Lasts one turn per level.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Jan 7, 2002
//:://////////////////////////////////////////////

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

    //Declare major variables
    object oTarget = GetSpellTargetObject();
    effect eVis = EffectVisualEffect(VFX_DUR_SANCTUARY);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eSanc = EffectEthereal();

    //check if he holds a ball or a flag
        object LightBall = GetHenchman (oTarget);
        if (GetIsObjectValid(LightBall))
            if (GetTag(LightBall) == "LightBall")
            {
                FloatingTextStringOnCreature("Sanctuary cannot be cast on the LightBall carrier",oTarget);
                return;
            }

        if ((GetLocalInt(oTarget,"hasgoldflag")==1)||
            (GetLocalInt(oTarget,"hassilverflag")==1))
        {
            FloatingTextStringOnCreature("Sanctuary cannot be cast on the flag carrier",oTarget);
            return;
        }
        if (GetIsInDominationArea (oTarget) )
        {
            if ( GetIsDominator ( oTarget, GetDominationArea ( oTarget ) ) )
            {
                FloatingTextStringOnCreature("Sanctuary cannot be cast at the dominator inside the domination area",oTarget);
                return;
            }
        }

    effect eLink = EffectLinkEffects(eVis, eSanc);
    eLink = EffectLinkEffects(eLink, eDur);

    int nDuration = 1+GetCasterLevel(OBJECT_SELF)/5;
    //Enter Metamagic conditions
    int nMetaMagic = GetMetaMagicFeat();
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2; //Duration is +100%
    }
    //Fire cast spell at event for the specified target
    SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELL_ETHEREALNESS, FALSE));
    //Apply the VFX impact and effects
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(nDuration));
}



