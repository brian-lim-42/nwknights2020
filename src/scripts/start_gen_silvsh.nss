#include "NW_I0_GENERIC"
#include "nw_i0_spells"

void main()
{
    object oGeneral = OBJECT_SELF;
    object oTarget = GetObjectByTag ("GoldShootMe");
//    string sTag = GetTag (oTarget);
//    SpeakString ("I'm suppose to shoot" +sTag+ "right now");
//    int nLightning = SPELL_LIGHTNING_BOLT;
    effect eLightning = EffectBeam(VFX_BEAM_LIGHTNING, oTarget , BODY_NODE_CHEST);
//    DelayCommand(2.0, AssignCommand (oGeneral,ActionCastFakeSpellAtObject (nLightning, oTarget, PROJECTILE_PATH_TYPE_DEFAULT)));
    DelayCommand(4.0, AssignCommand (oTarget, (ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLightning, oGeneral, 1.0))));

//    effect visual_effect = EffectVisualEffect(VFX_IMP_HEALING_X);
//    DelayCommand(6.0, AssignCommand (oTarget, (ApplyEffectToObject(DURATION_TYPE_INSTANT, visual_effect, oTarget))));


}
