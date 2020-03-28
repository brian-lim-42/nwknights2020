/*
  author: shadow_in_the_dark
  name:   war_inc_checks
  date:   05/03/11

  anti cheat checks during war.

*/
// ----------------------------------------------------------------------------
// Returns TRUE if oItem is atwo handed weapon
// ----------------------------------------------------------------------------
int GetIsWeaponTwoHanded (object oItem)
{
    //Declare major variables
    int nItem = GetBaseItemType(oItem);

    if((nItem == BASE_ITEM_DOUBLEAXE) ||
      (nItem == BASE_ITEM_GREATAXE) ||
      (nItem == BASE_ITEM_GREATSWORD) ||
      (nItem == BASE_ITEM_HALBERD) ||
      (nItem == BASE_ITEM_SCYTHE) ||
      (nItem == BASE_ITEM_TWOBLADEDSWORD) ||
      (nItem == BASE_ITEM_HEAVYFLAIL) ||
      (nItem == BASE_ITEM_QUARTERSTAFF) ||
      (nItem == BASE_ITEM_LONGBOW) ||
      (nItem == BASE_ITEM_SHORTBOW) ||
      (nItem == BASE_ITEM_HEAVYCROSSBOW) ||
      (nItem == BASE_ITEM_LIGHTCROSSBOW))

   {
        return TRUE;
   }
   return FALSE;
}

// ----------------------------------------------------------------------------
// Returns TRUE if oItem is atwo handed weapon
// ----------------------------------------------------------------------------
int GetIsShield (object oItem)
{
    //Declare major variables
    int nItem = GetBaseItemType(oItem);

    if((nItem == BASE_ITEM_LARGESHIELD) ||
      (nItem == BASE_ITEM_SMALLSHIELD) ||
      (nItem == BASE_ITEM_TOWERSHIELD))

   {
        return TRUE;
   }
   return FALSE;
}



// ----------------------------------------------------------------------------
// Returns TRUE if oItem is a to large weapon for a small creature
// ----------------------------------------------------------------------------
int GetIsToLargeWeaponForSmallCreature ( object oItem )
{
    //Declare major variables
    int nItem = GetBaseItemType(oItem);

    if((nItem == BASE_ITEM_DOUBLEAXE) ||
      (nItem == BASE_ITEM_GREATAXE) ||
      (nItem == BASE_ITEM_GREATSWORD) ||
      (nItem == BASE_ITEM_HALBERD) ||
      (nItem == BASE_ITEM_SCYTHE) ||
      (nItem == BASE_ITEM_TWOBLADEDSWORD) ||
      (nItem == BASE_ITEM_HEAVYFLAIL) ||
      (nItem == BASE_ITEM_LONGBOW))

   {
        return TRUE;
   }
   return FALSE;
}

// ----------------------------------------------------------------------------
// Returns TRUE if oItem is a two handed weapon for a small creature
// ----------------------------------------------------------------------------
int GetIsWeaponTwoHandedForSmallCreature (object oItem)
{
    //Declare major variables
    int nItem = GetBaseItemType(oItem);

    if((nItem == BASE_ITEM_BASTARDSWORD) ||
      (nItem == BASE_ITEM_BATTLEAXE) ||
      (nItem == BASE_ITEM_CLUB) ||
      (nItem == BASE_ITEM_KATANA) ||
      (nItem == BASE_ITEM_LONGSWORD) ||
      (nItem == BASE_ITEM_MORNINGSTAR) ||
      (nItem == BASE_ITEM_RAPIER) ||
      (nItem == BASE_ITEM_SHORTSPEAR) ||
      (nItem == BASE_ITEM_WARHAMMER) ||
      (nItem == BASE_ITEM_DWARVENWARAXE) ||
      (nItem == BASE_ITEM_QUARTERSTAFF) ||
      (nItem == BASE_ITEM_LONGBOW) ||
      (nItem == BASE_ITEM_SHORTBOW) ||
      (nItem == BASE_ITEM_LIGHTCROSSBOW)||
      (nItem == BASE_ITEM_HEAVYCROSSBOW))

   {
        return TRUE;
   }
   return FALSE;
}
