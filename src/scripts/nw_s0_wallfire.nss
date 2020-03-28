//::///////////////////////////////////////////////
//:: Wall of Fire
//:: NW_S0_WallFire.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Creates a wall of fire that burns any creature
    entering the area around the wall.  Those moving
    through the AOE are burned for 4d6 fire damage
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: July 17, 2001
//:://////////////////////////////////////////////

#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    // End of Spell Cast Hook

    //Declare Area of Effect object using the appropriate constant
    effect eAOE = EffectAreaOfEffect(AOE_PER_WALLFIRE);
    //Get the location where the wall is to be placed.
    location lTarget = GetSpellTargetLocation();
    int nDuration = 1 + GetCasterLevel(OBJECT_SELF) / 10;
    if(nDuration == 0)
    {
        nDuration = 1;
    }
    int nMetaMagic = GetMetaMagicFeat();

        //Check fort metamagic
        if (nMetaMagic == METAMAGIC_EXTEND)
        {
            nDuration = nDuration *2;   //Duration is +100%
        }
    //Create the Area of Effect Object declared above.
    ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eAOE, lTarget, RoundsToSeconds(nDuration));
}
