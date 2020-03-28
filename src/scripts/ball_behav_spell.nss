#include "NW_I0_GENERIC"
#include "nw_i0_spells"

void main()
{
    int eSpell = GetLastSpell ();
    if (eSpell == SPELL_INVISIBILITY)
    {
    RemoveSpecificEffect(EFFECT_TYPE_INVISIBILITY, OBJECT_SELF);
    }
    else if (eSpell == SPELL_SANCTUARY)
    {
    RemoveSpecificEffect(EFFECT_TYPE_SANCTUARY, OBJECT_SELF);
    }
    else if (eSpell == SPELL_INVISIBILITY_SPHERE)
    {
    RemoveSpecificEffect(EFFECT_TYPE_INVISIBILITY, OBJECT_SELF);
    }
    else if (eSpell == SPELL_IMPROVED_INVISIBILITY)
    {
    RemoveSpecificEffect(EFFECT_TYPE_IMPROVEDINVISIBILITY, OBJECT_SELF);
    RemoveSpecificEffect(EFFECT_TYPE_INVISIBILITY, OBJECT_SELF);
    }else if (eSpell == SPELL_ETHEREALNESS)
    {
        RemoveSpecificEffect(EFFECT_TYPE_ETHEREAL, OBJECT_SELF);
    }


if (GetTag (OBJECT_SELF) == "LightBall")
{
object oMaster = GetMaster ();
if (GetIsObjectValid (oMaster) == TRUE)
{
ActionForceFollowObject (oMaster);
}
}

}
