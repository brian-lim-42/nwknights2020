#include "nwk_constants"
#include "start_anticheat"
// give the correct Belt to the player
void GiveBeltTo (object oPC);



/** should be called on entering the sanctuary in the forst time(or clicking on the transition
gongs in the starting point.
it does the following:
1. destroy scrolls (identified by the starting "NW_I" string)
2. gives to all : boots and belt
3. if oPC is half-elf gives him specail ring
4. if oPC is a legacy warrier , gives him an amulet
*/
void prepareInventory(object oPC)
{

    // Destory Scrolls-------------------------------------------------------
    RemoveAllItems ( oPC );

//Create NWKnights Items--------------------------------------------------

object oItem = CreateItemOnObject ("playgroundboots", oPC);
AssignCommand (oPC, ActionEquipItem ( oItem, INVENTORY_SLOT_BOOTS));

GiveBeltTo (oPC);

////race check

if (GetRacialType(oPC) == RACIAL_TYPE_HALFELF)
{
oItem = CreateItemOnObject ("halfelfring", oPC);
AssignCommand (oPC, ActionEquipItem ( oItem, INVENTORY_SLOT_RIGHTRING));
}

oItem =  CreateItemOnObject ("toggle_respawn", oPC);


oItem = CreateItemOnObject ("sr_shifter_frnd", oPC);


////legacy warrior check

 SendMessageToPC(oPC,"testing if you are a legacy warrior");
 if ( (GetLevelByClass(CLASS_TYPE_BARBARIAN, oPC) +
        GetLevelByClass(CLASS_TYPE_RANGER , oPC) +
        GetLevelByClass(CLASS_TYPE_FIGHTER , oPC) >= 15)
        &&
        ( ! ( GetIsPrestigeClass (GetClassByPosition (1, oPC)) ||
              GetIsPrestigeClass (GetClassByPosition (2, oPC)) ||
              GetIsPrestigeClass (GetClassByPosition (3, oPC))
            )
        )
     )
  {
    SendMessageToPC(oPC,"You are a legacy warrior. You've recieved a magic amulet");
    oItem = CreateItemOnObject ("legacywarrioramu", oPC);
    AssignCommand (oPC, ActionEquipItem ( oItem, INVENTORY_SLOT_NECK));
  }
}


// give the correct Belt to the player
void GiveBeltTo (object oPC)
{
////expertise check
    object oItem;
    if ((GetHasFeat (FEAT_EXPERTISE, oPC)) && (GetHasFeat (FEAT_IMPROVED_EXPERTISE, oPC) == FALSE))
    {
        oItem = CreateItemOnObject ("playgroundbeltex", oPC);
        AssignCommand (oPC, ActionEquipItem ( oItem, INVENTORY_SLOT_BELT));
    }
    else if (GetHasFeat (FEAT_IMPROVED_EXPERTISE, oPC))
    {
        oItem = CreateItemOnObject ("playgroundbeliex", oPC);
        AssignCommand (oPC, ActionEquipItem ( oItem, INVENTORY_SLOT_BELT));
    }
    else
    {
        oItem = CreateItemOnObject ("playgroundbelt", oPC);
        AssignCommand (oPC, ActionEquipItem ( oItem, INVENTORY_SLOT_BELT));
    }

}
