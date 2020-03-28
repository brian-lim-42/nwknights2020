/*
  author: shadow_in_the_dark
  name:   a_toggle_respawn
  date:   05/08/18

  OnActivateItem Script of Item toggle_respawn.
  Respawn Position of owner toggle between class dependent default and
  alternative position.

*/
#include "nwk_constants"
void main()
{
    object oOwner = GetItemActivator ();
    SetRespawnDirective ( oOwner, ! GetIsAlternativeRespawn ( oOwner ) );
    string sMessage = "Your respawn location has been toggled to ";
    if ( GetIsAlternativeRespawn ( oOwner ) )
    {
        sMessage += "alternative location";
    }
    else
    {
        sMessage += "default location";
    }
    SendMessageToPC( oOwner, sMessage);
}

