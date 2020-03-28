/*
  author: shadow_in_the_dark
  name:   sr_on_open_store
  date:   2009-02-20

  - remove all gold from the area
  - adjust the allowed money of a player and
  store the amount of gold the player had before trading

*/
#include "sr_mny_trade_inc"
void main()
{
    object oPlayer = GetLastOpenedBy ();
    int nGold = GetGold ( oPlayer );
    int nAllowedGold = GetAllowedMoney ( oPlayer );

    SearchAndDestroyGold ();
    if ( nGold > nAllowedGold )
    {
        TakeGoldFromCreature ( nGold - nAllowedGold, oPlayer, TRUE );
        WriteTimestampedLogEntry ( "DEBUG: On Open Store: removed " +
                                   IntToString ( nGold - nAllowedGold ) +
                                   " Gold from" + GetName ( oPlayer ) );
    }
    nGold = GetGold ( oPlayer );
    SetLocalInt ( oPlayer, sPlayerGold, nGold );
    WriteTimestampedLogEntry ( "DEBUG: On Open Store: " + GetName ( oPlayer ) +
                               " owned " + IntToString ( nGold ) + " Gold" );
}

