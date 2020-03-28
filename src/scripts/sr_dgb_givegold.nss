/*
  author: shadow_in_the_dark
  name:   sr_dg_givegold
  date:   2006-01-15

  Give 1 000 000 Gold to PC

*/
#include "sr_mny_trade_inc"
void main()
{
   object oPlayer = GetPCSpeaker();
   GiveGoldToCreature ( oPlayer, 1000000 );
   adjustAllowedMoney ( oPlayer, 1000000 );
}

