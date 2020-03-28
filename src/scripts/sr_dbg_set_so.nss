/*
  author: shadow_in_the_dark
  name:   sr_dbg_set_so
  date:   05/06/28

  set the spell observer object to the last target
  all spells casted by the target will be reported to
  the DM's

*/
#include "sr_admin_inc"
void main()
{
    object oSpeaker = GetPCSpeaker ();
    object oPC = GetLocalObject ( oSpeaker, sDebugTarget );
    if ( GetIsObjectValid ( oPC ) )
    {
        SendMessageToAllDMs ( "Spell Observer set to " + GetName ( oPC ) );
        SetLocalObject ( GetModule (), sSpellObserver, oPC );
    } else
    {
        SendMessageToAllDMs ( "No valid target for Spell Observer" );
    }
}

