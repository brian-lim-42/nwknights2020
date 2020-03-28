// NWTACTICS By Jhenne (tallonzek@hotmail.com)
// 07/07/02

void ModifyWizardStaff ( object oStaff, object oPlayer );

void main()
{
    object oPC = GetPCSpeaker();
    string sTeam = GetLocalString(oPC, "team");
    object oItem;

    if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL)
    {
        oItem = CreateItemOnObject ("EvilWizardStaff", oPC);
    }
    else if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
    {
        oItem = CreateItemOnObject ("GoodWizardStaff", oPC);
    }
    else if ((sTeam == "GOLD") && (GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL))
    {
        oItem = CreateItemOnObject ("GoldWizardStaff", oPC);
    }
    else if ((sTeam == "SILVER") && (GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL))
    {
        oItem = CreateItemOnObject ("SilverWizardStaff", oPC);
    }

    ModifyWizardStaff ( oItem, oPC );
    AssignCommand (oPC, ActionEquipItem ( oItem, INVENTORY_SLOT_RIGHTHAND));

}


void ModifyWizardStaff ( object oStaff, object oPlayer )
{
    int nLevel = GetLevelByClass ( CLASS_TYPE_WIZARD, oPlayer );
    if ( nLevel > 16 ) nLevel = 16;
    int nMaxSpellSlot = FloatToInt ( IntToFloat ( nLevel ) / 2.0 + 0.6 );
    itemproperty ipProperty;
    ipProperty = GetFirstItemProperty ( oStaff );
    while ( GetIsItemPropertyValid ( ipProperty ) )
    {
        if ( ( GetItemPropertyType ( ipProperty ) == ITEM_PROPERTY_BONUS_SPELL_SLOT_OF_LEVEL_N ) &&
             ( GetItemPropertyCostTableValue ( ipProperty ) > nMaxSpellSlot ) )
        {
            RemoveItemProperty ( oStaff, ipProperty );
        }

        ipProperty = GetNextItemProperty ( oStaff );
    }


}
