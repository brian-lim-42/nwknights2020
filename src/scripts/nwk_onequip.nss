/*
  author: shadow_in_the_dark
  name:   nwk_onequip
  date:   05/03/11

  1. a hack pack exist, which allows using of large weapon in the same way as
     medium. ( large + shield )
     If a shield/weapon is equipped, check other hand.

*/
#include "war_inc_checks"
#include "nwk_constants"
#include "sr_inc_dump"

// boot player and send reason
void BootPlayer ( object oPlayer, string sMessage )
{

    SendMessageToPC ( oPlayer, "You are" + sMessage );
    WriteTimestampedLogEntry ( "OnEquipItem: Player " + GetName ( oPlayer ) + sMessage );
    if ( ! GetLocalInt ( oPlayer, MARKED_FOR_BOOT ) )
    {
        SetLocalInt ( oPlayer, MARKED_FOR_BOOT, TRUE );
        ExecuteScript ( "sr_dump_char", oPlayer );
        DelayCommand ( 20.0, BootPC ( oPlayer ) );
    }
}


void ExecuteLargeWeaponBugCheck (object oPlayer)
{
    string sMessage = "";
    if ( GetIsObjectValid ( GetItemInSlot ( INVENTORY_SLOT_LEFTHAND, oPlayer ) ) )
    {
        sMessage = " booted for using unallowed weapon combo (2handed weapon + shield/single handed weapon)";
        if ( GetCreatureSize ( oPlayer ) == CREATURE_SIZE_MEDIUM )
        {
            if ( GetIsWeaponTwoHanded ( GetItemInSlot ( INVENTORY_SLOT_RIGHTHAND, oPlayer ) ) )
            {
                BootPlayer ( oPlayer, sMessage );
            }
        } else
        {
            if ( GetIsWeaponTwoHandedForSmallCreature ( GetItemInSlot ( INVENTORY_SLOT_RIGHTHAND, oPlayer ) ) )
            {
                BootPlayer ( oPlayer, sMessage );
            }
        }
    }
    if ( GetCreatureSize ( oPlayer ) == CREATURE_SIZE_SMALL )
    {
        if ( GetIsToLargeWeaponForSmallCreature ( GetItemInSlot ( INVENTORY_SLOT_RIGHTHAND, oPlayer ) ) )
        {
            sMessage = " booted for using large weapon with creature of small size";
            BootPlayer ( oPlayer, sMessage );
        }
    }
}

// check if oItem is hold in the hand of oPlayer
int GetIsItemInHand ( object oItem, object oPlayer );

void main()
{
    object oItem = GetPCItemLastEquipped ();
    object oPlayer = GetPCItemLastEquippedBy ();
    //WriteTimestampedLogEntry ( "NWKDEBUG: Last equipped Item = " + GetName ( oItem ) );
    // removed, cause the size check on entering the game will boot them anyway
    // DelayCommand ( 3.0, ExecuteLargeWeaponBugCheck ( oPlayer ));
    if ( GetIsInCombat ( oPlayer ) )
    {
        if ( GetIsItemInHand ( oItem, oPlayer ) )
        {
            AssignCommand ( oPlayer, ClearAllActions () );
        }
    }
}


int GetIsItemInHand ( object oItem, object oPlayer )
{
    int bResult = FALSE;
    if ( GetIsObjectValid ( oItem ) )
        {
        if ( GetItemInSlot ( INVENTORY_SLOT_RIGHTHAND, oPlayer ) == oItem )
        {
            bResult = TRUE;
        }
        else if ( GetItemInSlot ( INVENTORY_SLOT_LEFTHAND, oPlayer ) == oItem )
        {
            bResult = TRUE;
        }
    }
    return bResult;
}

