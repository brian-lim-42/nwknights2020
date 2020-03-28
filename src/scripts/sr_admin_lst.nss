/*
  author: shadow_in_the_dark
  name:   sr_admin_lst
  date:   07/03/26

  Activate listening mode to set server forum side, announcements and
  password yuthentification for admins.

  To be called in a conversation
*/
#include "sr_admin_inc"
void main()
{
    object oListener = OBJECT_SELF;
    WriteTimestampedLogEntry ( "sr_admin_lst: " + GetName ( oListener )+ " wait for new website");
    SetListening ( oListener, TRUE);
    SetListenPattern (  oListener, sListenPatternWebSite + "**", nListenPatternWebsite );
    SetListenPattern (  oListener, sListenPatternDMregistration + "**", nListenPatternDMregistration );
    SetListenPattern (  oListener, sListenPatternAnnouncement + "**", nListenPatternAnnouncement );

}

