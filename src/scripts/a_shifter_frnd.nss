/*
  author: shadow_in_the_dark
  name:   a_shifter_frnd
  date:   2007-03-23

  re-equip all items with ability modifiers:
  - belts
  - boots
  - cloaks
  - ammulets
  - rings

*/

void ReEquipSlot ( int nSlot, object oPlayer )
{
    object oItem = GetItemInSlot ( nSlot, oPlayer );
    if ( GetIsObjectValid ( oItem ) )
    {
       AssignCommand ( oPlayer, ActionUnequipItem ( oItem ) );
       AssignCommand ( oPlayer, ActionWait ( 0.5 ) );
       AssignCommand ( oPlayer, ActionEquipItem ( oItem, nSlot ) );
    }
}

void main()
{
    object oPlayer = GetItemActivator ();
    ReEquipSlot ( INVENTORY_SLOT_BELT, oPlayer );
    ReEquipSlot ( INVENTORY_SLOT_BOOTS, oPlayer );
    ReEquipSlot ( INVENTORY_SLOT_CLOAK, oPlayer );
    ReEquipSlot ( INVENTORY_SLOT_NECK, oPlayer );
    ReEquipSlot ( INVENTORY_SLOT_LEFTRING, oPlayer );
    ReEquipSlot ( INVENTORY_SLOT_RIGHTRING, oPlayer );
}

