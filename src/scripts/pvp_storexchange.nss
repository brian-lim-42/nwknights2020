#include "sr_mny_trade_inc"
void main()
{
    object oPC = GetPCSpeaker();
    object oEquip = GetFirstItemInInventory(oPC);
    while(GetIsObjectValid(oEquip))
    {
      if (GetTag(oEquip) == "Trophy")
      {
          DestroyObject(oEquip);
          GiveGoldToCreature(oPC, 10000);
          adjustAllowedMoney ( oPC, 10000 );
      }

      else if (GetTag(oEquip) == "Skull")
      {
         DestroyObject(oEquip);
         GiveGoldToCreature (oPC ,1000);
         adjustAllowedMoney ( oPC, 1000 );
      }

    oEquip = GetNextItemInInventory(oPC);
    }
}
