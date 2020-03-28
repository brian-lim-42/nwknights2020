// NWTACTICS By Jhenne (tallonzek@hotmail.com)
// 07/07/02

#include "pvp_emptykt"

void ChangeKit ( object oPC )
{
    DestroyKit ( oPC );
    object oItem = CreateItemOnObject ("archercloak", oPC);
    AssignCommand (oPC, ActionEquipItem ( oItem, INVENTORY_SLOT_CLOAK));

    SetLocalInt(oPC,"kit_arrows",1);
    oItem = CreateItemOnObject ("dispelarrows", oPC, 10);
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

