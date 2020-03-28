//#include "NW_I0_GENERIC"
//#include "NW_I0_TOOL"
#include "NW_I0_SPELLS"
#include "nwk_colors"
#include "sr_inc_dump"
#include "sr_charid_inc"
//void main(){}

//check class type is a prestige class
int GetIsPrestigeClass ( int nClass );

// Check if nFeat is epic Feature
int GetIsEpicFeat ( int nFeat );

// Get the lowest class position for a CLASS-TYPE_*
int GetLowestClassPostionByClass ( int nClass, object oPlayer = OBJECT_SELF );


// 0 => all fine
// 1 => will be booted
int GetIsIllegal (object oPlayer)
{
    //object oPlayer = GetPCSpeaker();
    string sPlayer = GetName(oPlayer);
    int max_level=20;
    int base_skill_points = 23;

    if (GetIsDM(oPlayer))
        return 0;

    int nSumCheck = 0;
    string sLogEntry;
    RemoveSpecificEffect(EFFECT_TYPE_MOVEMENT_SPEED_DECREASE, oPlayer);
//may occur with shifter builds (releveled)
//temp HP higher than max HP - even after stripping all effects
if ( GetCurrentHitPoints ( oPlayer ) > GetMaxHitPoints ( oPlayer ) )
{
    effect eDamage = EffectDamage ( GetCurrentHitPoints ( oPlayer ) - GetMaxHitPoints ( oPlayer ) );
    ApplyEffectToObject ( DURATION_TYPE_INSTANT, eDamage, oPlayer );
}

// wrong char id - should be booted by the mod onentry event script
if ( ! GetIsSameChar ( oPlayer ) )
{
  return 1;
}

//check weired combos , like shifter witout a druid , a arcane-acher without any
//arcane. Check if required class is select first

if ( GetLevelByClass(CLASS_TYPE_SHIFTER, oPlayer)>0 )
{
    if (GetLevelByClass(CLASS_TYPE_DRUID, oPlayer)< 4 )
    {
        sLogEntry = "<B>" + sPlayer + "</B> ilegal class combo (shifter without neccessary druid levels)> (Key " + GetPCPlayerName(oPlayer) + " IP " + GetPCIPAddress(oPlayer) + ")";
        WriteTimestampedLogEntry(sLogEntry);
        SendMessageToPC(oPlayer,"*** Illegal Character : Class combo is not allowed! Your character will be booted in few seconds!");
        ExecuteScript ( "sr_dump_char", oPlayer );
        DelayCommand(32.0, BootPC(oPlayer));
        return 1;
    }
    else if ( ( GetLowestClassPostionByClass ( CLASS_TYPE_SHIFTER, oPlayer ) <
                GetLowestClassPostionByClass ( CLASS_TYPE_DRUID, oPlayer ) ) )
    {
        sLogEntry = "<B>" + sPlayer + "</B> wrong order of classes (shifter before druid)> (Key " + GetPCPlayerName(oPlayer) + " IP " + GetPCIPAddress(oPlayer) + ")";
        WriteTimestampedLogEntry(sLogEntry);
        SendMessageToPC(oPlayer,"*** Illegal Character : Class order is not allowed! Your character will be booted in few seconds!");
        ExecuteScript ( "sr_dump_char", oPlayer );
        DelayCommand(32.0, BootPC(oPlayer));
        return 1;
    }
}
// changes: shadow_in_the_dark
// dragon-disc must have a sorc/bard. Check if required class is select first.
if  ( GetLevelByClass(CLASS_TYPE_DRAGON_DISCIPLE, oPlayer) > 0 )
{
    if ( ( GetLevelByClass ( CLASS_TYPE_SORCERER, oPlayer ) +
           GetLevelByClass(CLASS_TYPE_BARD,oPlayer ) ) == 0 )
    {
         sLogEntry = "<B>" + sPlayer + "</B> ilegal class combo (DragonD without sorc/bard)> (Key " + GetPCPlayerName(oPlayer) + " IP " + GetPCIPAddress(oPlayer) + ")";
         WriteTimestampedLogEntry(sLogEntry);
         SendMessageToPC(oPlayer,"*** Illegal Character : Class combo is not allowed! Your character will be booted in few seconds!");
         ExecuteScript ( "sr_dump_char", oPlayer );
         DelayCommand(32.0, BootPC(oPlayer));
         return 1;
    }
    else if ( ( GetLowestClassPostionByClass ( CLASS_TYPE_DRAGON_DISCIPLE, oPlayer ) <
                GetLowestClassPostionByClass ( CLASS_TYPE_SORCERER, oPlayer ) ) ||
              ( GetLowestClassPostionByClass ( CLASS_TYPE_DRAGON_DISCIPLE, oPlayer ) <
                GetLowestClassPostionByClass ( CLASS_TYPE_BARD, oPlayer ) ) )
    {
         sLogEntry = "<B>" + sPlayer + "</B> ilegal class order (DragonD before sorc/bard)> (Key " + GetPCPlayerName(oPlayer) + " IP " + GetPCIPAddress(oPlayer) + ")";
         WriteTimestampedLogEntry(sLogEntry);
         SendMessageToPC(oPlayer,"*** Illegal Character : Class order is not allowed! Your character will be booted in few seconds!");
         ExecuteScript ( "sr_dump_char", oPlayer );
         DelayCommand(32.0, BootPC(oPlayer));
         return 1;
    }
}
if  ( GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER, oPlayer) > 0 )
{
    if ( ( GetLevelByClass ( CLASS_TYPE_SORCERER, oPlayer ) +
           GetLevelByClass ( CLASS_TYPE_BARD, oPlayer ) +
           GetLevelByClass ( CLASS_TYPE_WIZARD, oPlayer ) ) == 0 )
    {
        sLogEntry = "<B>" + sPlayer + "</B> ilegal class combo (Archane Archer without sorc/bard/wizard)> (Key " + GetPCPlayerName(oPlayer) + " IP " + GetPCIPAddress(oPlayer) + ")";
        WriteTimestampedLogEntry(sLogEntry);
        SendMessageToPC(oPlayer,"*** Illegal Character : Class combo is not allowed! Your character will be booted in few seconds!");
        ExecuteScript ( "sr_dump_char", oPlayer );
        DelayCommand(32.0, BootPC(oPlayer));
        return 1;
    }
    else
    {
        int nAAClassPos = GetLowestClassPostionByClass ( CLASS_TYPE_ARCANE_ARCHER, oPlayer );
        if ( ( nAAClassPos < GetLowestClassPostionByClass ( CLASS_TYPE_SORCERER, oPlayer ) ) ||
             ( nAAClassPos < GetLowestClassPostionByClass ( CLASS_TYPE_BARD, oPlayer ) ) ||
             ( nAAClassPos < GetLowestClassPostionByClass ( CLASS_TYPE_WIZARD, oPlayer ) ) )
        {
            sLogEntry = "<B>" + sPlayer + "</B> ilegal class order (Archane Archer before sorc/bard/wizard)> (Key " + GetPCPlayerName(oPlayer) + " IP " + GetPCIPAddress(oPlayer) + ")";
            WriteTimestampedLogEntry(sLogEntry);
            SendMessageToPC(oPlayer,"*** Illegal Character : Class order is not allowed! . Your character will be booted in few seconds!");
            ExecuteScript ( "sr_dump_char", oPlayer );
            DelayCommand(32.0, BootPC(oPlayer));
            return 1;
        }
    }

}

if  (  (GetLevelByClass(CLASS_TYPE_ARCANE_ARCHER, oPlayer)>0)
      && ! ( ( GetRacialType ( oPlayer ) == RACIAL_TYPE_ELF ) ||
             ( GetRacialType ( oPlayer ) == RACIAL_TYPE_HALFELF ) )

    )
{
     sLogEntry = "<B>" + sPlayer + "</B> illegal class/race combo (arcaner archer without (half-)elf) > (Key " + GetPCPlayerName(oPlayer) + " IP " + GetPCIPAddress(oPlayer) + ")";
     WriteTimestampedLogEntry(sLogEntry);
     SendMessageToPC(oPlayer,"*** Illegal Character : you have to be elf/halfelf for arcane archer! Your character will be booted in few seconds!");
     ExecuteScript ( "sr_dump_char", oPlayer );
     DelayCommand(32.0, BootPC(oPlayer));
     return 1;
}

// check if prestige class level >= 10
int nClass;
int nLevel;
int i;
for ( i = 1; i <= 3; i++ )
{
    nClass = GetClassByPosition ( i, oPlayer );
    nLevel = GetLevelByClass ( nClass, oPlayer );
    if ( GetIsPrestigeClass ( nClass ) && ( nLevel > 10 ) )
    {
        sLogEntry = "<B>" + sPlayer + "</B> illegal prestige class level  > (Key " + GetPCPlayerName(oPlayer) + " IP " + GetPCIPAddress(oPlayer) + ")";
        WriteTimestampedLogEntry(sLogEntry);
        SendMessageToPC(oPlayer,"*** Illegal Character : You have an illegal level in class " + ClassToString ( nClass ) + "! Your character will be booted in few seconds!");
        ExecuteScript ( "sr_dump_char", oPlayer );
        DelayCommand(32.0, BootPC(oPlayer));
        return 1;
    }
}

//check for epic feature
int nFeat;
for ( nFeat = 0; nFeat <= 1071; nFeat++ )
{
    if ( GetHasFeat ( nFeat, oPlayer ) && GetIsEpicFeat ( nFeat ) )
    {
        // work around for wrong feat feedback
        int bExit = FALSE;
        if ( GetLevelByClass ( CLASS_TYPE_ROGUE, oPlayer ) > 18 )
        {
            if ( nFeat >= 1004 && nFeat <= 1006 ) bExit = TRUE;
            if ( nFeat >= 1019 && nFeat <= 1030 ) bExit = TRUE;
        }
        if ( ! bExit )
        {
            sLogEntry = "<B>" + sPlayer + "</B> Epic Feature No. " +  IntToString ( nFeat ) + " detected  > (Key " + GetPCPlayerName(oPlayer) + " IP " + GetPCIPAddress(oPlayer) + ")";
            WriteTimestampedLogEntry(sLogEntry);
            SendMessageToPC(oPlayer,"*** Illegal Character : You have an illegal Feature! Your character will be booted in few seconds!");
            ExecuteScript ( "sr_dump_char", oPlayer );
            DelayCommand(32.0, BootPC(oPlayer));
            return 1;
        }
    }
}


// assumption of max possible hit points
// barbarian lvl 20        : 240
// endurance               :  20
// const 25 (dwarf) 7 * 20 : 140
// ------------------------------
//                           400
// ==============================
if (GetMaxHitPoints(oPlayer) > 400)
  {
    sLogEntry = "<B>" + sPlayer + "</B> HP > 400 (Key " + GetPCPlayerName(oPlayer) + " IP " + GetPCIPAddress(oPlayer) + ")";
    WriteTimestampedLogEntry(sLogEntry);
    SendMessageToPC(oPlayer,"*** Illegal Character! . Your character will be booted in few seconds!");
    ExecuteScript ( "sr_dump_char", oPlayer );
    DelayCommand(32.0, BootPC(oPlayer));
    return 1;
  }

//Anti-Skin -  work
     int racialType = GetRacialType(oPlayer);
    int appearanceType ;

    if      (racialType ==  RACIAL_TYPE_DWARF)
        appearanceType = APPEARANCE_TYPE_DWARF;
    else if (racialType  == RACIAL_TYPE_ELF)
        appearanceType = APPEARANCE_TYPE_ELF;
    else if (racialType  == RACIAL_TYPE_GNOME)
        appearanceType = APPEARANCE_TYPE_GNOME;
    else if (racialType  == RACIAL_TYPE_HALFELF)
        appearanceType = APPEARANCE_TYPE_HALF_ELF;
    else if (racialType  == RACIAL_TYPE_HALFLING)
        appearanceType = APPEARANCE_TYPE_HALFLING;
    else if (racialType  == RACIAL_TYPE_HALFORC)
        appearanceType = APPEARANCE_TYPE_HALF_ORC ;
    else if (racialType  == RACIAL_TYPE_HUMAN)
        appearanceType =  APPEARANCE_TYPE_HUMAN ;
    SetCreatureAppearanceType(oPlayer,appearanceType);


// level check -Good to GO
    if (GetHitDice(oPlayer) != max_level)
    {
         sLogEntry = "<B>" + sPlayer + "</B> Invalid level (Key " + GetPCPlayerName(oPlayer) + " IP " + GetPCIPAddress(oPlayer) + ")";
         WriteTimestampedLogEntry(sLogEntry);
         SendMessageToPC(oPlayer,"Your character level is not allowed in this mod. As we want to establish a fair fighting ground for everybody, your character will be booted!");
         ExecuteScript ( "sr_dump_char", oPlayer );
         DelayCommand(32.0, BootPC(oPlayer));
         return 1;
    }


//checks that the current effects on the players are all valid.
//all removeable effects are already removed by the calling script
    effect eEffect = GetFirstEffect(oPlayer);
    while ( GetIsEffectValid(eEffect) == TRUE )
    {
        nSumCheck ++;
        eEffect = GetNextEffect(oPlayer);
    }

    if (nSumCheck > 0)
    {
         sLogEntry = "<B>" + sPlayer + "</B> Invalid effects identified (Key " + GetPCPlayerName(oPlayer) + " IP " + GetPCIPAddress(oPlayer) + ")";
         WriteTimestampedLogEntry(sLogEntry);
         SendMessageToPC(oPlayer,"Your character has abnormal effects. As we want to establish a fair fighting ground for everybody, your character will be booted!");
         ExecuteScript ( "sr_dump_char", oPlayer );
         DelayCommand(32.0, BootPC(oPlayer));
         return 1;

    }

//check name
     if (  ( FindSubString(sPlayer,"summoned")>0)
        || (GetStringLowerCase(GetStringLeft(sPlayer, 1)) == " ")
        || ( FindSubString(sPlayer,"Summoned") > 0)
        || ( GetStringLength ( sPlayer ) < 3 )
        || ( GetStringRight ( sPlayer, 1 ) == ";")
        || ( FindSubString(sPlayer,"</c") > 0)
        )
    {
         sLogEntry = "<B>" + sPlayer + "</B> Invalid character name (Key " + GetPCPlayerName(oPlayer) + " IP " + GetPCIPAddress(oPlayer) + ")";
         WriteTimestampedLogEntry(sLogEntry);
         SendMessageToPC(oPlayer,"Your character name is not allowed in this mod. As we want to establish a fair fighting ground for everybody, your character will be booted!");
         ExecuteScript ( "sr_dump_char", oPlayer );
         DelayCommand(32.0, BootPC(oPlayer));
         return 1;

    }

// check AC - negative AC is possible but noted as sign for a hacked char
    if ( GetAC ( oPlayer ) < 1 )
    {
         sLogEntry = "<B>" + sPlayer + "</B> Invalid Armor Class (Key " + GetPCPlayerName(oPlayer) + " IP " + GetPCIPAddress(oPlayer) + ")";
         WriteTimestampedLogEntry(sLogEntry);
         SendMessageToPC(oPlayer,"Your character name is not allowed in this mod. As we want to establish a fair fighting ground for everybody, your character will be booted!");
         ExecuteScript ( "sr_dump_char", oPlayer );
         DelayCommand(32.0, BootPC(oPlayer));
         return 1;
    }

// negative money gives unlimated money
    if ( GetGold ( oPlayer ) < 0 )
    {
         sLogEntry = "<B>" + sPlayer + "</B> Negative Gold (Key " + GetPCPlayerName(oPlayer) + " IP " + GetPCIPAddress(oPlayer) + ")";
         WriteTimestampedLogEntry(sLogEntry);
         SendMessageToPC(oPlayer,"Your character owns negative money which is only possible after a hack of the bic-file, your character will be booted!");
         ExecuteScript ( "sr_dump_char", oPlayer );
         DelayCommand(32.0, BootPC(oPlayer));
         return 1;
    }

// check for hacked creature size
    switch ( GetCreatureSize ( oPlayer ) )
    {
        case CREATURE_SIZE_HUGE:
        case CREATURE_SIZE_INVALID:
        case CREATURE_SIZE_LARGE:
        case CREATURE_SIZE_TINY:
            // hack
            sLogEntry = "<B>" + sPlayer + "</B> Invalid Creature Size (Key " + GetPCPlayerName(oPlayer) + " IP " + GetPCIPAddress(oPlayer) + ")";
            WriteTimestampedLogEntry(sLogEntry);
            SendMessageToPC(oPlayer,"Your creature size is not allowed in this mod. As we want to establish a fair fighting ground for everybody, your character will be booted!");
            ExecuteScript ( "sr_dump_char", oPlayer );
            DelayCommand(32.0, BootPC(oPlayer));
            return 1;
        case CREATURE_SIZE_MEDIUM:
            // only hacked if race is halfling or gnome
            switch ( racialType )
            {
                case RACIAL_TYPE_GNOME:
                case RACIAL_TYPE_HALFLING:
                    // hack
                    sLogEntry = "<B>" + sPlayer + "</B> Invalid Creature Size for racial type (Key " + GetPCPlayerName(oPlayer) + " IP " + GetPCIPAddress(oPlayer) + ")";
                    WriteTimestampedLogEntry(sLogEntry);
                    SendMessageToPC(oPlayer,"Your creature size is not allowed for your race. As we want to establish a fair fighting ground for everybody, your character will be booted!");
                    ExecuteScript ( "sr_dump_char", oPlayer );
                    DelayCommand(32.0, BootPC(oPlayer));
                    return 1;
                default: // all ok
            }
        default: // all ok
    }

//7//check alignment restrictions

    nSumCheck = 0;
    if (GetLevelByClass(CLASS_TYPE_BARBARIAN, oPlayer) > 0 && GetAlignmentLawChaos(oPlayer) == ALIGNMENT_LAWFUL)
        nSumCheck++;
    if (GetLevelByClass(CLASS_TYPE_BARD, oPlayer) > 0 && GetAlignmentLawChaos(oPlayer) == ALIGNMENT_LAWFUL)
        nSumCheck++;
    if (GetLevelByClass(CLASS_TYPE_DRUID, oPlayer) > 0 && !(GetAlignmentLawChaos(oPlayer) == ALIGNMENT_NEUTRAL || GetAlignmentGoodEvil(oPlayer) == ALIGNMENT_NEUTRAL || GetAlignmentGoodEvil(oPlayer) == ALIGNMENT_NEUTRAL))
        nSumCheck++;
    if (GetLevelByClass(CLASS_TYPE_MONK, oPlayer) > 0 && (GetAlignmentLawChaos(oPlayer) == ALIGNMENT_NEUTRAL || GetAlignmentLawChaos(oPlayer) == ALIGNMENT_CHAOTIC))
        nSumCheck++;
    if (GetLevelByClass(CLASS_TYPE_PALADIN, oPlayer) > 0 && (GetAlignmentLawChaos(oPlayer) != ALIGNMENT_LAWFUL || GetAlignmentGoodEvil(oPlayer) != ALIGNMENT_GOOD))
        nSumCheck++;
    if (GetLevelByClass(CLASS_TYPE_ASSASSIN, oPlayer) > 0 && (GetAlignmentGoodEvil(oPlayer) != ALIGNMENT_EVIL ) )
        nSumCheck++;
    if (GetLevelByClass(CLASS_TYPE_BLACKGUARD, oPlayer) > 0 && (GetAlignmentGoodEvil(oPlayer) != ALIGNMENT_EVIL ) )
        nSumCheck++;
    if (GetLevelByClass(CLASS_TYPE_DWARVEN_DEFENDER, oPlayer) > 0 && (GetAlignmentLawChaos(oPlayer) != ALIGNMENT_LAWFUL ))
        nSumCheck++;
    if (GetLevelByClass(CLASS_TYPE_DWARVENDEFENDER, oPlayer) > 0 && (GetAlignmentLawChaos(oPlayer) != ALIGNMENT_LAWFUL ))
        nSumCheck++;
    if (GetLevelByClass(CLASS_TYPE_DIVINECHAMPION, oPlayer) > 0 && ( GetAlignmentGoodEvil(oPlayer) == ALIGNMENT_EVIL ) )
        nSumCheck++;
    if (GetLevelByClass(CLASS_TYPE_PALE_MASTER, oPlayer) > 0 && ( GetAlignmentGoodEvil(oPlayer) == ALIGNMENT_GOOD ) )
        nSumCheck++;
    if (GetLevelByClass(CLASS_TYPE_PALE_MASTER, oPlayer) > 0 && ( GetAlignmentGoodEvil(oPlayer) == ALIGNMENT_GOOD ) )
        nSumCheck++;


    if (nSumCheck > 0)
    {
       sLogEntry = "<B>" + sPlayer + "</B> Alignement alteration abuse (Key " + GetPCPlayerName(oPlayer) + " IP " + GetPCIPAddress(oPlayer) + ")";
       WriteTimestampedLogEntry(sLogEntry);
       SendMessageToPC(oPlayer,"Your character Alignement is not compatible with the classes used. As we want to establish a fair fighting ground for everybody, your character will be booted!");
       ExecuteScript ( "sr_dump_char", oPlayer );
       DelayCommand(32.0, BootPC(oPlayer));
       return 1;
    }

    return 0;

}


int GetIsPrestigeClass ( int nClass )
{
    int bResult = FALSE;

    switch ( nClass )
    {
        case CLASS_TYPE_ARCANE_ARCHER:
        case CLASS_TYPE_ASSASSIN:
        case CLASS_TYPE_BLACKGUARD:
        case CLASS_TYPE_DIVINE_CHAMPION:
        case CLASS_TYPE_DRAGON_DISCIPLE:
        case CLASS_TYPE_DWARVEN_DEFENDER:
        case CLASS_TYPE_HARPER:
        case CLASS_TYPE_PALE_MASTER:
        case CLASS_TYPE_SHADOWDANCER:
        case CLASS_TYPE_SHAPECHANGER:
        case CLASS_TYPE_SHIFTER:
        case CLASS_TYPE_WEAPON_MASTER:
            bResult = TRUE;
            break;
        default: bResult = FALSE;
    }
    return bResult;
}

// Check if nFeat is epic Feature
int GetIsEpicFeat ( int nFeat )
{
// Values derived from LETO
    int bResult = FALSE;

    if ( nFeat == 488 )
    {
        bResult = TRUE;
    }
    if ( nFeat >= 490 && nFeat <= 865 )
    {
        bResult = TRUE;
    }
    if ( nFeat >= 870 && nFeat <= 870 )
    {
        bResult = TRUE;
    }
    if ( nFeat >= 872 && nFeat <= 878 )
    {
        bResult = TRUE;
    }
    if ( nFeat >= 917 && nFeat <= 918 )
    {
        bResult = TRUE;
    }
    if ( nFeat >= 955 && nFeat <= 958 )
    {
        bResult = TRUE;
    }
    if ( nFeat >= 966 && nFeat <= 992 )
    {
        bResult = TRUE;
    }
    if ( nFeat >= 996 && nFeat <= 999 )
    {
        bResult = TRUE;
    }
    if ( nFeat >= 1001 && nFeat <= 1006 )
    {
        bResult = TRUE;
    }
    if ( nFeat >= 1060 && nFeat <= 1061 )
    {
        bResult = TRUE;
    }
    if ( nFeat >= 1065 && nFeat <= 1071 )
    {
        bResult = TRUE;
    }
    return bResult;
}

int GetLowestClassPostionByClass ( int nClass, object oPlayer = OBJECT_SELF )
{
    int nResult = 0;
    int nPosition;
    for ( nPosition = 1; nPosition <= 3; nPosition++ )
    {
        if ( GetClassByPosition ( nPosition, oPlayer ) == nClass )
        {
            nResult = nPosition;
            break;
        }
    }

    return nResult;

}



