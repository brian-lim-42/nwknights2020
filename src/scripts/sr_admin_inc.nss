/*
  author: shadow_in_the_dark
  name:   sr_admin_inc
  date:   07/03/26

  provides gloabal definitions for the administration of administrators

  authentification of admins:
    # DM can register himself as "admin" at the Entry Guardian
    # cd-key will be stored in a database (NWN)
    # in game authentification compare if cd-key is registered
    # benefits:
        - each server provider becomes the special "admin" rights
        - no account name depending authentification
        - no mod change to introduce "new" admin

*/


//name of the database file
const string sAdminDatabase = "NWKNIGHTS_ADMINS";

//listening pattern for server website
const string sListenPatternWebSite = "Web:";

//web listenig pattern number
const int nListenPatternWebsite = 1001;

//database entry for server web site
const string sServerWebsite = "SR_SERVER_WEB_SITE";

//dm registration pattern number
const int nListenPatternDMregistration = 1002;

#include "_readme"

//anouncement pattern number
const int nListenPatternAnnouncement = 1003;

//anouncement listening pattern
const string sListenPatternAnnouncement = "Ann:";

// database entry for additional annuncements
const string sServerAnnouncement = "SR_SERVER_ANNOUNCEMENT";

//database entry for pre-registered admin
const string sAdminPreRegister = "SR_PRE_ADMIN_KEY";

//SpellObserver Variable
const string sSpellObserver = "spellobserver";

//debug target
const string sDebugTarget = "SR_DEBUG_TARGET";

//Register a administrator
void RegisterAdmin ( object oDM );

//Check for administration rights
int GetIsAdmin ( object oPlayer );


void RegisterAdmin ( object oDM )
{
    SetCampaignInt ( sAdminDatabase, GetPCPublicCDKey ( oDM, TRUE ), 1 );
}

int GetIsAdmin ( object oPlayer )
{
    return GetCampaignInt ( sAdminDatabase, GetPCPublicCDKey ( oPlayer, TRUE ));
}


void StorePreAdminKey ( object oDM )
{
    if (! GetIsDM ( oDM ) )
    {
        WriteTimestampedLogEntry ( "###ALERT NWK Admin: Non DM  (" +
                                    GetName ( oDM ) + ", " +
                                    GetPCIPAddress ( oDM ) + ", " +
                                    GetPCPublicCDKey ( oDM ) +
                                    ") tried to register for administration" );
    }
    else
    {
        WriteTimestampedLogEntry ( "### NWK Admin: Pre register DM  (" +
                                    GetName ( oDM ) + ", " +
                                    GetPCIPAddress ( oDM ) + ", " +
                                    GetPCPublicCDKey ( oDM ) +
                                    ") for administration" );
        SetCampaignString ( sAdminDatabase, sAdminPreRegister, GetPCPublicCDKey ( oDM, TRUE ) );
    }

}

int GetIsPreregisteredAdmin ( object oPlayer )
{
    return  GetPCPublicCDKey ( oPlayer, TRUE ) == GetCampaignString ( sAdminDatabase, sAdminPreRegister );
}
