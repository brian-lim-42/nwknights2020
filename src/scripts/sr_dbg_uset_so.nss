/*
  author: shadow_in_the_dark
  name:   sr_dbg_uset_so
  date:   05/06/28

  unset the spell observer object
  spells will not longer be reported to DM

*/
#include "sr_admin_inc"
void main()
{
    SendMessageToAllDMs ( "Spell Observer de-activated" );
    DeleteLocalObject ( GetModule (), sSpellObserver );
}

