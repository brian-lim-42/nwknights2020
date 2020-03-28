/*
  author: shadow_in_the_dark
  name:   nwk_lord
  date:   05/02/28

  handle the special lord abilities

*/
#include "x2_inc_itemprop"

// checks if oPC wears Lord Helm and Armor
int GetIsLord ( object oPC );

// add the special abilities to the Lord.
// if oPC is not a Lord nothing happens
void AddLordProperties ( object oPC );

int GetIsLord ( object oPC )
{
    object oHelmet = GetItemInSlot (INVENTORY_SLOT_HEAD, oPC);
    object oArmor = GetItemInSlot (INVENTORY_SLOT_CHEST, oPC);
    string sHelmetTag = GetTag (oHelmet);
    string sArmorTag = GetTag (oArmor);
    return ((GetStringLeft (sHelmetTag,2)=="kl") && (GetStringLeft (sArmorTag,2)=="kl"));
}


void AddLordProperties ( object oPC )
{
    if ( GetIsLord (oPC ) )
    {
        string team= GetLocalString(oPC,"team");

        // team depending properties
        int nVisualEffect;
        int nDamageType;

        if ( team == "SILVER" )
        {
            nVisualEffect = ITEM_VISUAL_ELECTRICAL;
            nDamageType = IP_CONST_DAMAGETYPE_ELECTRICAL;
        } else if ( team == "GOLD" )
        {
            nVisualEffect = ITEM_VISUAL_ACID;
            nDamageType = IP_CONST_DAMAGETYPE_ACID;
        } else
        {
            //error
            WriteTimestampedLogEntry ( "nwk_lord::AddLordProperties | ERROR: Invalid team " );
            return;
        }

        itemproperty ipAdd = ItemPropertyVisualEffect(nVisualEffect);
        itemproperty ipAdda = ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_OUTSIDER, nDamageType, IP_CONST_DAMAGEBONUS_2);
        itemproperty ipAddb = ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ELEMENTAL, nDamageType, IP_CONST_DAMAGEBONUS_2);
        itemproperty ipAddc = ItemPropertyDamageBonusVsRace(IP_CONST_RACIALTYPE_ANIMAL, nDamageType, IP_CONST_DAMAGEBONUS_2);

        // search for weapon in inventory
        string  sTag;
        object oWeapon = GetFirstItemInInventory(oPC);
        while(GetIsObjectValid(oWeapon))
        {
            sTag = GetTag(oWeapon);
            if (GetStringLeft(sTag,2)=="wp")
            {
                IPRemoveMatchingItemProperties ( oWeapon, ITEM_PROPERTY_VISUALEFFECT, DURATION_TYPE_PERMANENT );
                IPSafeAddItemProperty(oWeapon, ipAdd);
                IPSafeAddItemProperty(oWeapon, ipAdda);
                IPSafeAddItemProperty(oWeapon, ipAddb);
                IPSafeAddItemProperty(oWeapon, ipAddc);
            }
            oWeapon = GetNextItemInInventory(oPC);
        }

        // weapon in right hand
        oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
        sTag = GetTag(oWeapon);
        if (GetStringLeft(sTag,2)=="wp")
        {
            IPRemoveMatchingItemProperties ( oWeapon, ITEM_PROPERTY_VISUALEFFECT, DURATION_TYPE_PERMANENT );
            IPSafeAddItemProperty(oWeapon, ipAdd);
            IPSafeAddItemProperty(oWeapon, ipAdda);
            IPSafeAddItemProperty(oWeapon, ipAddb);
            IPSafeAddItemProperty(oWeapon, ipAddc);

        }
        // weapon in left hand
        oWeapon=GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
        sTag = GetTag(oWeapon);
        if (GetStringLeft(sTag,2)=="wp")
        {
            IPRemoveMatchingItemProperties ( oWeapon, ITEM_PROPERTY_VISUALEFFECT, DURATION_TYPE_PERMANENT );
            IPSafeAddItemProperty(oWeapon, ipAdd);
            IPSafeAddItemProperty(oWeapon, ipAdda);
            IPSafeAddItemProperty(oWeapon, ipAddb);
            IPSafeAddItemProperty(oWeapon, ipAddc);
        }

        // bolts
        oWeapon=GetItemInSlot(INVENTORY_SLOT_BOLTS, oPC);
        sTag = GetTag(oWeapon);
        if (GetStringLeft(sTag,2)=="wp")
        {
            IPRemoveMatchingItemProperties ( oWeapon, ITEM_PROPERTY_VISUALEFFECT, DURATION_TYPE_PERMANENT );
            IPSafeAddItemProperty(oWeapon, ipAdd);
            IPSafeAddItemProperty(oWeapon, ipAdda);
            IPSafeAddItemProperty(oWeapon, ipAddb);
            IPSafeAddItemProperty(oWeapon, ipAddc);
        }

        // arrows (only normal)
        oWeapon=GetItemInSlot(INVENTORY_SLOT_ARROWS, oPC);
        sTag = GetTag(oWeapon);
        if (GetStringLeft(sTag,2)=="wp")
        {
            IPRemoveMatchingItemProperties ( oWeapon, ITEM_PROPERTY_VISUALEFFECT, DURATION_TYPE_PERMANENT );
            IPSafeAddItemProperty(oWeapon, ipAdd);
            IPSafeAddItemProperty(oWeapon, ipAdda);
            IPSafeAddItemProperty(oWeapon, ipAddb);
            IPSafeAddItemProperty(oWeapon, ipAddc);
        }

        // bullets
        oWeapon=GetItemInSlot(INVENTORY_SLOT_BULLETS, oPC);
        sTag = GetTag(oWeapon);
        if (GetStringLeft(sTag,2)=="wp")
        {
            IPRemoveMatchingItemProperties ( oWeapon, ITEM_PROPERTY_VISUALEFFECT, DURATION_TYPE_PERMANENT );
            IPSafeAddItemProperty(oWeapon, ipAdd);
            IPSafeAddItemProperty(oWeapon, ipAdda);
            IPSafeAddItemProperty(oWeapon, ipAddb);
            IPSafeAddItemProperty(oWeapon, ipAddc);
        }

    }
}





