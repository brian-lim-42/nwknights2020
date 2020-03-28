void main()
{
object oPC = GetPCSpeaker();
object oEquip = GetFirstItemInInventory(oPC);

// empty the PC's Inventory
 string  sTag;

  while(GetIsObjectValid(oEquip))
  {
    sTag = GetTag(oEquip);
    if (GetStringLeft(sTag,2)=="rm")
         DestroyObject(oEquip);

      oEquip = GetNextItemInInventory(oPC);
    }



   oEquip=GetItemInSlot(INVENTORY_SLOT_CHEST, oPC);
    sTag = GetTag(oEquip);
    if (GetStringLeft(sTag,2)=="rm")
         DestroyObject(oEquip);

   oEquip=GetItemInSlot(INVENTORY_SLOT_CARMOUR, oPC);
 sTag = GetTag(oEquip);
    if (GetStringLeft(sTag,2)=="rm")
         DestroyObject(oEquip);


  oEquip=GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
sTag = GetTag(oEquip);
    if (GetStringLeft(sTag,2)=="rm")
         DestroyObject(oEquip);



   oEquip=GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
sTag = GetTag(oEquip);
    if (GetStringLeft(sTag,2)=="rm")
         DestroyObject(oEquip);




}
/*
oEquip = GetItemPossessedBy (oPC, "GoodGreataxe");
DestroyObject(oEquip);
oEquip = GetItemPossessedBy (oPC, "SilverGreatAxe");
DestroyObject(oEquip);
*/
    //AssignCommand (oPC, ActionEquipItem (oEquip, INVENTORY_SLOT_RIGHTHAND));
      //oEquip = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);

    //if (GetBaseItemType(oEquip)!=BASE_ITEM_CSLASHWEAPON)
    //    DestroyObject(oEquip);

