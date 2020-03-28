/*
  author: shadow_in_the_dark
  name:   sr_mny_trade_inc
  date:   2009-02-20

  Anti Money trading system



*/

// the amount of Gold a player may earn by other means like stealing
const int nBonus = 2000;

// money a player owned before trading in a shop
const string sPlayerGold = "SR_PLAYER_GOLD";

// money a player is allowed to spent at next trading
const string sAllowedGold = "SR_ALLOWED_GOLD";
// ##GetVarInt SR_ALLOWED_GOLD

// adjust the allowed amount of gold for a player
void adjustAllowedMoney ( object oPlayer, int nMoney );

// access function to the allowed money a player can spent
int GetAllowedMoney ( object oPlayer );

// Search and destroy all gold lying on the floor in the area of OBJECT_SELF
void SearchAndDestroyGold ();




void adjustAllowedMoney ( object oPlayer, int nMoney )
{
    /* WriteTimestampedLogEntry ( "NWK DEBUG: adjustAllowedMoney : Player: " + GetName ( oPlayer ) +
                               "; old " + IntToString ( GetLocalInt ( oPlayer, sAllowedGold ) ) +
                               "; add " + IntToString ( nMoney ) );
    */
    SetLocalInt ( oPlayer, sAllowedGold, GetLocalInt ( oPlayer, sAllowedGold ) + nMoney );
}

int GetAllowedMoney ( object oPlayer )
{
    return GetLocalInt ( oPlayer, sAllowedGold ) + nBonus;
}

int adjustAndCheck ( object oPlayer, int nNeededGold )
{

    int nGold = GetGold ( oPlayer );
    int nAllowedGold = GetAllowedMoney ( oPlayer );
    if ( nGold > nAllowedGold )
    {
        TakeGoldFromCreature ( nGold - nAllowedGold, oPlayer, TRUE );
        WriteTimestampedLogEntry ( "DEBUG: adjustAndCheck: removed " +
                                   IntToString ( nGold - nAllowedGold ) +
                                   " Gold from" + GetName ( oPlayer ) );
    }
    nGold = GetGold ( oPlayer );
    return ( nGold >= nNeededGold );

}


void SearchAndDestroyGold ()
{
    object oItem = GetFirstObjectInArea ();
    while ( GetIsObjectValid ( oItem ) )
    {
        if ( GetBaseItemType ( oItem ) == BASE_ITEM_GOLD )
        {
            DestroyObject ( oItem );
        }
        oItem = GetNextObjectInArea ();
    }


}
