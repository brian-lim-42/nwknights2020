/*
  author: shadow_in_the_dark
  name:   equ_inc_books
  date:   2007-08-26

  Functionality for the Knight Shop Book Shelf

*/
#include "sr_mny_trade_inc"

void SellBook( object oPC, string sBook, int nCosts)
{
    if ( ! adjustAndCheck ( oPC, nCosts ) )
    {
        SpeakString ("you cannot afford this book", TALKVOLUME_TALK);
    }
    else
    {
        CreateItemOnObject ( sBook, oPC );
        TakeGoldFromCreature ( nCosts, oPC, TRUE );
        adjustAllowedMoney ( oPC, GetGold(oPC) - nCosts );
    }
}

