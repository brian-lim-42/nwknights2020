/*
  author: shadow_in_the_dark
  name:   sr_EGuard_OnConv
  date:   07/03/26

  OnConversation Event of the Entry Guardian.

*/
#include "sr_admin_inc"
void main()
{

    object oSpeaker = GetLastSpeaker();
//    WriteTimestampedLogEntry ( "Entry Guardian: OnConversation. Pattern = " + IntToString ( GetListenPatternNumber () ));
    string sWebSiteAddress = "";
    string sAnnouncement = "";

    switch ( GetListenPatternNumber () )
    {
        // Website change
        case nListenPatternWebsite:
            if ( GetIsAdmin ( oSpeaker ) )
            {
                // set new web site for the server.
                sWebSiteAddress = GetMatchedSubstring(1);
                if ( sWebSiteAddress != "" )
                {
                    // valid web site address
                    SetCampaignString ( sAdminDatabase, sServerWebsite, sWebSiteAddress );
                    SendMessageToPC ( oSpeaker, "New Website: " + sWebSiteAddress );
                }else
                {
                    //remove the entry
                    SetCampaignString ( sAdminDatabase, sServerWebsite, "" );
                    SendMessageToPC ( oSpeaker, "Website Removed" );
                }
            }
            break;

        // register admin
        case nListenPatternDMregistration:
            WriteTimestampedLogEntry ( "### DEBUG: sr_EGuard_OnConv - registration attemp for new administrator" );
            if ( GetIsPreregisteredAdmin ( oSpeaker ) )
            {
                WriteTimestampedLogEntry ( "### DEBUG: sr_EGuard_OnConv - new administrator" );
                SendMessageToPC ( oSpeaker, "your CD key is registered as administrator key" );
                RegisterAdmin ( oSpeaker );
            }
            break;

        // announcement
        case nListenPatternAnnouncement:
            if ( GetIsAdmin ( oSpeaker ) )
            {
                // set new announcemnet
                sAnnouncement = GetMatchedSubstring(1);
                if ( sAnnouncement != "" )
                {
                    // valid web site address
                    SetCampaignString ( sAdminDatabase, sServerAnnouncement, sAnnouncement );
                    SendMessageToPC ( oSpeaker, "New Announcement: " + sAnnouncement );
                }else
                {
                    //remove the entry
                    SetCampaignString ( sAdminDatabase, sServerAnnouncement, "" );
                    SendMessageToPC ( oSpeaker, "Announcement Removed" );
                }
            }
            break;

        default:
            // Not a match -- start an ordinary conversation
            if (GetCommandable(OBJECT_SELF))
            {
                AssignCommand ( OBJECT_SELF, ClearAllActions ());
                BeginConversation();
            }

    }

}

