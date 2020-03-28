#include "nwk_constants"
#include "sr_mny_trade_inc"
void GetMoney ( object oPC, location lDest )
{
    SetLocalInt ( oPC, sMutex, TRUE );
    PlaySound("as_cv_lute1");
    AssignCommand(oPC, ActionJumpToLocation(lDest));
    JumpHenchmen(oPC, lDest, 6);
    object oEquip = GetFirstItemInInventory(oPC);
    while(GetIsObjectValid(oEquip))
    {
        if (GetTag(oEquip) == "Trophy")
        {
        DestroyObject(oEquip);
        GiveGoldToCreature(oPC, 10000);
        adjustAllowedMoney ( oPC, 10000 );

        }
        else if (GetTag(oEquip) == "Skull")
        {
        DestroyObject(oEquip);
        GiveGoldToCreature (oPC ,1000);
        adjustAllowedMoney ( oPC, 1000 );
        }

    oEquip = GetNextItemInInventory(oPC);
    }
}

void main()
{
    object oPC=GetClickingObject();

    if ( GetLocalInt ( oPC, sMutex ) ) return;

    string team= GetLocalString(oPC,"team");
    object oHelmet = GetItemInSlot (INVENTORY_SLOT_HEAD, oPC);
    object oArmor = GetItemInSlot (INVENTORY_SLOT_CHEST, oPC);
    string sHelmetTag = GetTag (oHelmet);
    string sArmorTag = GetTag (oArmor);
    location lDest;


   if (team=="SILVER")
   {
      lDest = GetLocation(GetObjectByTag("SILVER_KNIGHT_IN"));

      if (((GetStringLeft (sHelmetTag,2)=="kn") && (GetStringLeft (sArmorTag,2)=="kn"))||((GetStringLeft (sHelmetTag,2)=="kl") && (GetStringLeft (sArmorTag,2)=="kl"))||((GetStringLeft (sHelmetTag,2)=="kn") && (GetStringLeft (sArmorTag,2)=="kl"))||((GetStringLeft (sHelmetTag,2)=="kl") && (GetStringLeft (sArmorTag,2)=="kn")))
        {
            GetMoney ( oPC, lDest );
        }
      else
        {
        SpeakString ("Only a Silvery Knight may enter this door");
        }
    }
    else if (team=="GOLD")
    {
      lDest = GetLocation(GetObjectByTag("GOLD_KNIGHT_IN"));

      if (((GetStringLeft (sHelmetTag,2)=="kn") && (GetStringLeft (sArmorTag,2)=="kn"))||((GetStringLeft (sHelmetTag,2)=="kl") && (GetStringLeft (sArmorTag,2)=="kl"))||((GetStringLeft (sHelmetTag,2)=="kn") && (GetStringLeft (sArmorTag,2)=="kl"))||((GetStringLeft (sHelmetTag,2)=="kl") && (GetStringLeft (sArmorTag,2)=="kn")))
      {
            GetMoney ( oPC, lDest );
      }
      else
      {
      SpeakString ("Only a Golden Knight may enter this door");
      }
    }

}
