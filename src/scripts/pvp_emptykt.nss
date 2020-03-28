#include "start_prep_inv"

void destroyKitFromSlot(object oPC , int slotNumber)
{
  object oEquip=GetItemInSlot(slotNumber, oPC);
  string sTag = GetTag(oEquip);
  if (GetStringLeft(sTag,2)=="kt")
      DestroyObject(oEquip);
}

void DestroyKit ( object oPC )
{

    // empty the PC's Inventory
    string  sTag;

    //destroy special arrows
    SetLocalInt(oPC,"kit_arrows",0);


    //destroy items which are not in a special slot , but are stached in the inventory space
    object oEquip = GetFirstItemInInventory(oPC);
    while(GetIsObjectValid(oEquip))
    {
        sTag = GetTag(oEquip);
        if (GetStringLeft(sTag,2)=="kt")
        {
            DestroyObject(oEquip);
        }

          oEquip = GetNextItemInInventory(oPC);
    }
    int i;
    // destroy equiped items
    for (i=0;i<NUM_INVENTORY_SLOTS;i++)
    {
        destroyKitFromSlot(oPC,i);
    }

    // create new Knight Belt, if necessary
    object oBelt = GetItemPossessedBy ( oPC, "NWKnightsBelt" );
    if ( ! GetIsObjectValid ( oBelt ) )
    {
        GiveBeltTo (oPC);
    }
}





