/*
  author: shadow_in_the_dark
  name:   2008-05-06
  date:   sr_dbg_entry_1

  Check conditions which may disallow joining teams and try to solve (if recommended)

*/
#include "nwk_constants"
#include "sr_charid_inc"
void main()
{
    object oPlayer = GetPCSpeaker();
        // mutex to avoid double invocation
    if ( GetLocalInt ( oPlayer, sMutex) )
    {
        DeleteLocalInt ( oPlayer, sMutex );
        WriteTimestampedLogEntry ( "NWK DEBUG: Entry Guardian: removed mutex block from player: " +
                                    GetName ( oPlayer ) + "[" + GetPCPlayerName ( oPlayer ) + "]" );
    }
    if ( ! GetIsSameChar ( oPlayer ) )
    {
        WriteTimestampedLogEntry ( "NWK CHEATER: Entry Guardian: Player blocked but not booted for re-use of char name " +
                                    GetName ( oPlayer ) + "[" + GetPCPlayerName ( oPlayer ) + "]" );
    }
}
