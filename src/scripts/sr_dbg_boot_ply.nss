/*
  author: shadow_in_the_dark
  name:   sr_dbg_boot_ply
  date:   05/03/28

  Boot the targeted char and send message to all players

*/
#include "sr_admin_inc"
#include "nwk_constants"
void main()
{
    object oSpeaker = GetPCSpeaker ();
    object oPC = GetLocalObject ( oSpeaker, sDebugTarget );
    if ( GetIsObjectValid ( oPC ) && GetIsPC ( oPC ) )
    {
        sendMessageToAllPlayer( "", GetName ( oPC ) +" is booted by the Admin" );
        DelayCommand ( 5.0, BootPC ( oPC ) );
    }
}

