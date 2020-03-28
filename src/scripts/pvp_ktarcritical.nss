// NWTACTICS By Jhenne (tallonzek@hotmail.com)
// 07/07/02

#include "pvp_emptykt"

void ChangeKit ( object oPC )
{
    DestroyKit ( oPC );
    object oItem = CreateItemOnObject ("archercloak", oPC);
    /* That's the way to change color of cloaks .. but difficult to get the right color
    object oItem1;
    oItem1 = oItem;
    oItem = CopyItemAndModify ( oItem, ITEM_APPR_TYPE_ARMOR_COLOR, ITEM_APPR_ARMOR_COLOR_CLOTH2, 44 );
    DestroyObject ( oItem1 );
    */
    AssignCommand (oPC, ActionEquipItem ( oItem, INVENTORY_SLOT_CLOAK));

    SetLocalInt(oPC,"kit_arrows",4);
    oItem = CreateItemOnObject ("criticalarrows", oPC, 10);
    oItem = CreateItemOnObject ("medikit10", oPC, 1);
}

void main()
{
    object oPC = GetPCSpeaker();
    //this script is used form "pvp_restock" too , there PC speaker
    //won`t work so we need to say it`s OBJECT_SELF
    if (!GetIsObjectValid(oPC))
        oPC=OBJECT_SELF;
    DelayCommand (1.5, ChangeKit ( oPC ));
}
