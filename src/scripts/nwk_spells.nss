//nwk_spell


#include "x0_i0_spells"
#include "nwk_const_teams"








int min(int x,int y)
{
    if (x>y)
        return x;
    else
        return y;
}


void destroyEffectsOfDamagingShields(object oTarget)
{
    int spell_id =SPELL_ELEMENTAL_SHIELD ;
    if (GetHasSpellEffect(spell_id,oTarget))
    {
         RemoveSpellEffects(spell_id, OBJECT_SELF, oTarget);
         FloatingTextStringOnCreature("Current elemental shield is disabled",oTarget,FALSE);
    }

    spell_id=  SPELL_MESTILS_ACID_SHEATH;
    if (GetHasSpellEffect(spell_id,oTarget))
    {
        RemoveSpellEffects(spell_id, OBJECT_SELF, oTarget);
        FloatingTextStringOnCreature("Current Acid Sheath is disabled",oTarget,FALSE);
    }
}
