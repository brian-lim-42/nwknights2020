/*
  author: shadow_in_the_dark
  name:   nwk_onaquire
  date:   05/03/31

  OnAquire Event of the module

  - If a char get a heavy armor check his base tumble value. Reduce armor AC by
    2 if tumble is 20, if tumble is >= 15 by 1, else let it as it is.


*/
#include "war_inc_checks"
// check if armor is a heavy one -- only way is to compare the tags
int GetIsHeavyArmor ( object oArmor )
{
    int bResult = FALSE;

    return bResult;
}

//Get Armor malus, depending on Armor Class .. decide by tag
int GetArmorMalus ( object oArmor )
{
    int nResult = 0;
    if ( GetIsObjectValid ( oArmor ) && GetIsHeavyArmor ( oArmor ) )
    {

    }
    return nResult;
}

//get Shield Malus
int GetShieldMalus ( object oShield )
{
    int nMalus = 0;
    switch ( GetBaseItemType ( oShield ) )
    {
        case BASE_ITEM_LARGESHIELD: nMalus = 2;
            break;
        case BASE_ITEM_SMALLSHIELD: nMalus = 1;
            break;
        case BASE_ITEM_TOWERSHIELD: nMalus = 10;
            break;
        default: nMalus = 0;
    }
    return nMalus;
}

// get the base tumble value
// consider armor/shield malus and dex bonus
int GetBaseTumble ( object oPlayer )
{
    object oArmor = GetItemInSlot ( INVENTORY_SLOT_CHEST );
    object oShield = GetItemInSlot ( INVENTORY_SLOT_LEFTHAND );

    int nTumble = GetSkillRank ( SKILL_TUMBLE, oPlayer );
    nTumble -= GetAbilityModifier ( ABILITY_DEXTERITY, oPlayer );
    nTumble += GetArmorMalus ( oArmor );
    nTumble += GetShieldMalus ( oShield );


    return nTumble;

}

void main()
{
    object oItem = GetModuleItemAcquired ();
    object oPlayer = GetModuleItemAcquiredBy ();
    //WriteTimestampedLogEntry ( "* DEBUG: Player " + GetName ( oPlayer ) + " get Item " + GetTag ( oItem ) );
    if ( GetIsHeavyArmor ( oItem ) )
    {
        if ( GetBaseTumble ( oPlayer ) >= 15 )
        {
            AddItemProperty ( DURATION_TYPE_PERMANENT, ItemPropertyDecreaseAC ( IP_CONST_ACMODIFIERTYPE_ARMOR, 1 ), oItem );
        }
        if ( GetBaseTumble ( oPlayer ) >= 20 )
        {
            AddItemProperty ( DURATION_TYPE_PERMANENT, ItemPropertyDecreaseAC ( IP_CONST_ACMODIFIERTYPE_ARMOR, 2 ), oItem );
        }

    }
///////////////////////////Time Bomb explodes on pick up///////////////////////
    else if ((!GetStolenFlag (oItem)) && ((GetTag(oItem) == "TimeBomb")) && (GetItemCursedFlag(oItem)))
    {

    object oPossessor = GetItemPossessor(oItem);
    location oBombplace = GetLocation (oPossessor);
    effect ePuff;
    effect eFire;
    ePuff=EffectVisualEffect(VFX_FNF_HOWL_ODD);
    eFire=EffectVisualEffect(VFX_FNF_FIREBALL);
    effect visual_effect = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);

       ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFire, oBombplace);
       DelayCommand (1.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePuff, oBombplace));
       DelayCommand (1.0,DestroyObject (oItem));
       object oFireTarget = GetFirstObjectInShape(SHAPE_CUBE, 15.0, oBombplace, OBJECT_TYPE_CREATURE);
            while(GetIsObjectValid(oFireTarget))
            {
            AssignCommand (oFireTarget, DelayCommand(1.0, ApplyEffectToObject (DURATION_TYPE_TEMPORARY, EffectDamage(d6(17), DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_ENERGY), oFireTarget)));
            DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, visual_effect, oFireTarget));
            oFireTarget = GetNextObjectInShape(SHAPE_CUBE, 15.0, oBombplace, OBJECT_TYPE_CREATURE);
            }
           object oTarget;
           int nOpened;
           oTarget = GetFirstObjectInShape(SHAPE_CUBE, 15.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
                while(GetIsObjectValid(oTarget))
                {
                     if(GetLocked(oTarget))
                     {
                     nOpened = GetLocalInt(oTarget, "open") + 50;
                     SetLocalInt(oTarget, "open", nOpened);
                     AssignCommand(oTarget,ActionSpeakString(IntToString(150-nOpened)));
                     }
                oTarget = GetNextObjectInShape(SHAPE_SPHERE, 50.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
               }

    DelayCommand (1.5, DestroyObject (oItem));
    }
//////////////////////////////////////////////////////////////////////////////


}

