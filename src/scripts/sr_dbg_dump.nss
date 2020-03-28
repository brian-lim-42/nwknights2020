/*
  author: shadow_in_the_dark
  name:   sr_dbg_dump
  date:   05/03/28

  dump the target stats to logfile and send as message to user

*/
#include "sr_inc_dump"
#include "sr_admin_inc"
void main()
{
    object oSpeaker = GetPCSpeaker ();
    object oPC = GetLocalObject ( oSpeaker, sDebugTarget );
    if ( GetIsObjectValid ( oPC ) )
    {
        string sMessage = CreateDumpMessage ( oPC );
        WriteTimestampedLogEntry ( sMessage );
        SendMessageToPC ( oSpeaker, sMessage );
    } else
    {
        SendMessageToPC ( oSpeaker, "no valid target" );
    }
}

