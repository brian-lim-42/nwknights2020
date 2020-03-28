/*
  author: shadow_in_the_dark
  name:   sr_on_clse_store
  date:   2007-06-15

  check the amount of gold the player spent for trading and adjust the
  allowed money of the player.

*/
#include "sr_mny_trade_inc"
void main()
{
    object oPlayer = GetLastClosedBy ();
    int nGold = GetGold ( oPlayer );
    int nOldGold = GetLocalInt ( oPlayer, sPlayerGold );
    DeleteLocalInt( oPlayer, sPlayerGold );
    adjustAllowedMoney ( oPlayer, nGold - nOldGold );
    // WriteTimestampedLogEntry ( "DEBUG: On Close Store: " + GetName ( oPlayer ) +
    //                           " spent " + IntToString ( nOldGold - nGold ) + " Gold" );
}

