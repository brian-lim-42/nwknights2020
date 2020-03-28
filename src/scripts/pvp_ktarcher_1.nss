/*
  author: shadow_in_the_dark
  name:   pvp_ktarcher_1
  date:   05/02/28

  Creates only a archer cloak. Only used by restock chest

*/

void main()
{
    object oPC = GetPCSpeaker();

    //this script is used form "pvp_restock" too , there PC speaker
    //won`t work so we need to say it`s OBJECT_SELF
    if (!GetIsObjectValid(oPC))
        oPC=OBJECT_SELF;
    /* That's the way to change color of cloaks .. but difficult to get the right color
    object oItem1;
    oItem1 = oItem;
    oItem = CopyItemAndModify ( oItem, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_CLOTH2, 44 );
    DestroyObject ( oItem1 );
    */
    object oItem = CreateItemOnObject ("archercloak", oPC);

    AssignCommand (oPC, ActionEquipItem ( oItem, INVENTORY_SLOT_CLOAK));

    oItem = CreateItemOnObject ("medikit10", oPC, 1);
}

