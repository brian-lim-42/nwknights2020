/** restart the module.
    work only if the name of the player PC (not the character) is according to
    administrators.
*/
#include "nwk_admin"

void main()
{
    string moduleFileName= GetModuleName();
    object oPC= GetLastUsedBy();
    if  (isPlayerAdmin(oPC)==TRUE)
    {
        forceAllPlayersSaveToLocalVault();
        DelayCommand(5.0, sendMessageToAllPlayer("Restart in 5 seconds.",""));
        SendMessageToPC(oPC,"Trying to start file name: " + moduleFileName);
        DelayCommand(10.0,StartNewModule(moduleFileName));
    }

}
