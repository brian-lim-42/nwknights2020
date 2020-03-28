/*
  author: shadow_in_the_dark
  name:   nwk_onlevelup
  date:   2008-05-06

  maintain the char id during level up.

*/
#include "sr_charid_inc"
void main()
{
    object oPlayer = GetPCLevellingUp ();
    SetNewCharId ( oPlayer );
    effect eLevelUp = EffectVisualEffect ( VFX_DUR_GLOW_ORANGE );
    ApplyEffectToObject ( DURATION_TYPE_TEMPORARY, eLevelUp, oPlayer, 5.0f);
}
