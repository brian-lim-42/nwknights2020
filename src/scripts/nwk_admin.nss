//nwk_admin
#include "nwk_constants"
#include "sr_admin_inc"
const int BOOT_CHARACTER_INT = 2001;
const string BOOT_CHARACTER_PREFIX = "Boot "; //including one space!
const int DUMP_CHARACTER_INT = 2002;
const string DUMP_CHARACTER_PREFIX = "dump "; //including one space!
const int ABUSE_CHARACTER_INT = 2003;
const string ABUSE_CHARACTER_PREFIX = "abuse "; //including one space!




/** TRUE or FALSE
*/
int isPlayerAdmin(object oPC)
{
    string pcName= GetPCPlayerName(oPC);
    SendMessageToPC(oPC,"Your user name is:"+pcName);
    if ( GetIsAdmin( oPC ) )
    {
        SendMessageToPC(oPC,"You have administrator rights");
        return TRUE;
    }
    else
    {
        SendMessageToPC(oPC,"You do not have administrator rights . action canceled");
        return FALSE;
    }
}
/** forces all the players to save the characters. it is recommnened to give
it some time to work, cause Im not sure how much time it takes
*/
void forceAllPlayersSaveToLocalVault()
{
    ExportAllCharacters ();
}



