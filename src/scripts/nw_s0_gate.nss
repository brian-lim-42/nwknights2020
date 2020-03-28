//::///////////////////////////////////////////////
//:: Gate
//:: NW_S0_Gate.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
//:: Summons a Balor to fight for the caster.
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: April 12, 2001
//:://////////////////////////////////////////////
/* changes: unfriendly balor is created NEAR the caster and being destroys after
 * two rounds (12 seconds)
 */

void CreateBalor();
#include "x2_inc_spellhook"
void main()
{
    if (!X2PreSpellCastCode())
    {
        return;
    }
    // End of Spell Cast Hook

    //Declare major variables
    int nMetaMagic = GetMetaMagicFeat();
    int nCasterLevel = GetCasterLevel(OBJECT_SELF);
    int nDuration = GetCasterLevel(OBJECT_SELF)/ 2;
    effect eSummon;
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_GATE);
    //Make metamagic extend check
    if (nMetaMagic == METAMAGIC_EXTEND)
    {
        nDuration = nDuration *2;   //Duration is +100%
    }
    //Summon the Balor and apply the VFX impact
    //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetSpellTargetLocation());
    object balor;
    if(GetHasSpellEffect(SPELL_PROTECTION_FROM_EVIL) ||
       GetHasSpellEffect(SPELL_MAGIC_CIRCLE_AGAINST_EVIL) ||
       GetHasSpellEffect(SPELL_HOLY_AURA))
    {
        int nRandom = Random ( 100 );
        if ( nRandom < 20 )
        {
            eSummon = EffectSummonCreature("NW_S_BALOR",VFX_FNF_SUMMON_GATE,3.0);
        }
        else if ( nRandom < 50 )
        {
            eSummon = EffectSummonCreature("NW_S_VROCK",VFX_FNF_SUMMON_GATE,3.0);
        } else
        {
            eSummon = EffectSummonCreature("NW_S_SUCCUBUS",VFX_FNF_SUMMON_GATE,3.0);
        }

        DelayCommand(3.0, ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, eSummon, GetSpellTargetLocation(), RoundsToSeconds(nDuration)));

    }
    else
    {
       // ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, GetLocation(OBJECT_SELF));
        //DelayCommand(3.0, CreateBalor());
        balor=CreateObject(OBJECT_TYPE_CREATURE, "NW_S_BALOR_EVIL", GetLocation(OBJECT_SELF));
        DestroyObject(balor,12.0);
    }
}

void CreateBalor()
{
     CreateObject(OBJECT_TYPE_CREATURE, "NW_S_BALOR_EVIL", GetSpellTargetLocation());
}

