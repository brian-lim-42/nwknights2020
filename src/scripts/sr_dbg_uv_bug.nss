/*
  author: shadow_in_the_dark
  name:   sr_dbg_uv_bug
  date:   05/08/19

  Try to remove the ultravision bug

  Hint by Davelok:

  manually it's may possible to cast darkness, then uv, then move in darkness and
  dispell the uv.

  Attemp:

  Remove the uv-effect as long as darkness effect is applied

  add all effects of spell darkness
  add uv
  remove uv
  remove effects of spell darkness

*/

void main()
{
    object oTarget = OBJECT_SELF;
    if ( ! GetIsObjectValid ( oTarget ) )
    {
        oTarget = GetItemActivatedTarget();
    }
// from nw_s0_darknessa
    effect eInvis = EffectInvisibility(INVISIBILITY_TYPE_DARKNESS);
    effect eDark = EffectDarkness();
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
    effect eLink = EffectLinkEffects(eDark, eDur);
    effect eLink2 =  EffectLinkEffects(eInvis, eDur);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget);

// from nw_s0_darkvis
    effect eVis = EffectVisualEffect(VFX_DUR_ULTRAVISION);
    effect eVis2 = EffectVisualEffect(VFX_DUR_MAGICAL_SIGHT);
    eDur = EffectVisualEffect(VFX_DUR_CESSATE_POSITIVE);
    effect eUltra = EffectUltravision();
    eLink = EffectLinkEffects(eVis, eDur);
    eLink = EffectLinkEffects(eLink, eVis2);
    eLink = EffectLinkEffects(eLink, eUltra);
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, 10.0);

//now remove Ultravision

    effect eEffect = GetFirstEffect ( oTarget );
    while ( GetEffectType ( eEffect ) != EFFECT_TYPE_ULTRAVISION &&
            GetEffectType ( eEffect ) != EFFECT_TYPE_INVALIDEFFECT )
    {
        eEffect = GetNextEffect ( oTarget );
    }
    RemoveEffect ( oTarget, eEffect );


// and now darkness
    eEffect = GetFirstEffect ( oTarget );
    while ( GetEffectType ( eEffect ) != EFFECT_TYPE_DARKNESS  &&
            GetEffectType ( eEffect ) != EFFECT_TYPE_INVALIDEFFECT )
    {
        eEffect = GetNextEffect ( oTarget );
    }
    RemoveEffect ( oTarget, eEffect );


}

