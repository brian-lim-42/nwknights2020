/*
  author: shadow_in_the_dark
  name:   sr_dbg_restart
  date:   05/03/29

  Restarts the mod

*/
#include "nwk_admin"
void main()
{
        ExportAllCharacters();
        DelayCommand ( 5.0, sendMessageToAllPlayer ( "Restart in 5 seconds.", "" ) );
        DelayCommand ( 10.0, StartNewModule ( GetModuleName () ) );
}

