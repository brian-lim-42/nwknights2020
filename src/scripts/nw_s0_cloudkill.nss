//::///////////////////////////////////////////////
//:: Cloudkill
//:: NW_S0_CloudKill.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    All creatures with 3 or less HD die, those with
    4 to 6 HD must make a save Fortitude Save or die.
    Those with more than 6 HD take 1d10 Poison damage
    every round.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: May 17, 2001
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
    effect eAOE = EffectAreaOfEffect(AOE_PER_FOGKILL);
    location lTarget = GetSpellTargetLocation();
    int nDuration = 1 + GetCasterLevel(OBJECT_SELF) / 10;
    effect eImpact = EffectVisualEffect(258);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eImpact, lTarget);
    if(nDuration < 1)
    {
        nDuration = 1;
    }
    int nMetaMagic = GetMetaMagicFeat();
        //Metamagic checks for entend
        if (nMetaMagic == METAMAGIC_EXTEND)
        {
            nDuration = nDuration *2;   //Duration is +100%
        }
    //Apply the AOE object to the specified location
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(nDuration));
}
