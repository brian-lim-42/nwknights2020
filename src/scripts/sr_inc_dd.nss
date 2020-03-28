/*
  author: shadow_in_the_dark
  name:   sr_inc_dd
  date:   2007-08-10

  Dwarven Defender AC Exploit

  Stop stance at low HP to be killed by decrease of constitution - that will increase
  your AC permanently by +4. It will work at least for +8 total AC bonus.

*/

#include "sr_inc_dump"

const string DD_START_AC = "SR_DD_START_AC";

// Store the AC of oPlayer
void SetStartAC ( object oPlayer );

// returns the AC previously stored with SetStartAC()
int GetStartAC ( object oPlayer );

// Total AC Bonus from all equipped Items
int GetEquipedItemACBonus ( object oPlayer );


void SetStartAC ( object oPlayer )
{
    SetLocalInt ( oPlayer, DD_START_AC, GetAC ( oPlayer ) );
}

int GetStartAC ( object oPlayer )
{
    return GetLocalInt ( oPlayer, DD_START_AC );
}


int GetEquipedItemACBonus ( object oPlayer )
{
    int nResult = 0;
    nResult += GetItemACValue ( GetItemInSlot ( INVENTORY_SLOT_ARMS, oPlayer ) );
    nResult += GetItemACValue ( GetItemInSlot ( INVENTORY_SLOT_ARROWS, oPlayer ) );
    nResult += GetItemACValue ( GetItemInSlot ( INVENTORY_SLOT_BELT, oPlayer ) );
    nResult += GetItemACValue ( GetItemInSlot ( INVENTORY_SLOT_BOLTS, oPlayer ) );
    nResult += GetItemACValue ( GetItemInSlot ( INVENTORY_SLOT_BOOTS, oPlayer ) );
    nResult += GetItemACValue ( GetItemInSlot ( INVENTORY_SLOT_BULLETS, oPlayer ) );
    nResult += GetItemACValue ( GetItemInSlot ( INVENTORY_SLOT_CHEST, oPlayer ) );
    nResult += GetItemACValue ( GetItemInSlot ( INVENTORY_SLOT_CLOAK, oPlayer ) );
    nResult += GetItemACValue ( GetItemInSlot ( INVENTORY_SLOT_HEAD, oPlayer ) );
    nResult += GetItemACValue ( GetItemInSlot ( INVENTORY_SLOT_LEFTHAND, oPlayer ) );
    nResult += GetItemACValue ( GetItemInSlot ( INVENTORY_SLOT_LEFTRING, oPlayer ) );
    nResult += GetItemACValue ( GetItemInSlot ( INVENTORY_SLOT_NECK, oPlayer ) );
    nResult += GetItemACValue ( GetItemInSlot ( INVENTORY_SLOT_RIGHTHAND, oPlayer ) );
    nResult += GetItemACValue ( GetItemInSlot ( INVENTORY_SLOT_RIGHTRING, oPlayer ) );
    nResult += GetItemACValue ( GetItemInSlot ( INVENTORY_SLOT_CARMOUR, oPlayer ) );
    nResult += GetItemACValue ( GetItemInSlot ( INVENTORY_SLOT_CWEAPON_B, oPlayer ) );
    nResult += GetItemACValue ( GetItemInSlot ( INVENTORY_SLOT_CWEAPON_L, oPlayer ) );
    nResult += GetItemACValue ( GetItemInSlot ( INVENTORY_SLOT_CWEAPON_R, oPlayer ) );

    // now the dex bonus based on Items
    int nDexAC;
    int nDexMod = GetAbilityModifier ( ABILITY_DEXTERITY, oPlayer );
    if ( nDexMod < ( GetAbilityScore ( oPlayer, ABILITY_DEXTERITY, FALSE ) -10 ) / 2 )
    {
        nDexAC = nDexMod;
    }
    else
    {
        nDexAC = GetAbilityScore ( oPlayer, ABILITY_DEXTERITY, FALSE ) / 2 -
                 GetAbilityScore ( oPlayer, ABILITY_DEXTERITY, TRUE ) / 2;
    }
    // The Dex based AC is only valid under the assumption that the players
    // armor makes the modifier effective.

    return nResult + nDexAC;
}


void SolveIncreasedAC ( object oPlayer = OBJECT_SELF )
{
    // Check if the AC of a DD is to high
    if ( ( GetAC ( oPlayer ) - GetEquipedItemACBonus ( oPlayer ) ) > GetStartAC ( oPlayer ) )
    {
        WriteTimestampedLogEntry ( "NWN DEBUG: DD AC exploit: \n" +
                                   "Current AC     = " + IntToString ( GetAC ( oPlayer ) ) + "\n" +
                                   "Start AC       = " + IntToString ( GetStartAC ( oPlayer ) ) + "\n" +
                                   "Total Armor AC = " + IntToString ( GetEquipedItemACBonus ( oPlayer ) ) + "\n" +
                                   CreateDumpMessage ( oPlayer ) );
        // Adjust AC
        int nStanceACBonus = GetAC ( oPlayer ) - GetEquipedItemACBonus ( oPlayer ) - GetStartAC ( oPlayer );
        effect eACDecrease = SupernaturalEffect ( EffectACDecrease ( nStanceACBonus, AC_DODGE_BONUS ) );
        ApplyEffectToObject ( DURATION_TYPE_PERMANENT, eACDecrease, oPlayer );
        WriteTimestampedLogEntry ( "NWN DEBUG: AC after modifcation = " + IntToString ( GetAC ( oPlayer ) ) );
    }
}
