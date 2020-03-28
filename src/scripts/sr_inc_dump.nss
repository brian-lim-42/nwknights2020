/*
  author: shadow_in_the_dark
  name:   sr_inc_dump
  date:   05/03/08

  dump the char information to the logfile.

*/

// convert FEAT_* in a string
// Epic Features not implemented yet
string FeatureToString ( int nFeat );
// convert Racial_Type_* to string
string RaceToString ( int nRace );
// convert CLASS_TYPE_* to string
string ClassToString ( int nClass );
// convert SKILL_TYPE_* to string
string SkillToString ( int nSkill );
//convert CREATURE_SIZE_* to string
string CreatureSizeToString ( int nSize );


// walk through all skills of a player and create for each skill a line
// "* skillname : Rank
string CreateSkillMessage ( object oPlayer );
// walk through all features of a player and create for each featue a line
// "* Featurename
string CreateFeatureMessage ( object oPlayer );
//converts SPELL_* to string
string SpellToString ( int nSpellId );

// Create a dump message with releveant char information
string CreateDumpMessage ( object oTarget = OBJECT_SELF );

string CreateDumpMessage ( object oTarget = OBJECT_SELF )
{
    string sClass1 = ClassToString ( GetClassByPosition ( 1, oTarget ) );
    string sClass2 = ClassToString ( GetClassByPosition ( 2, oTarget ) );
    string sClass3 = ClassToString ( GetClassByPosition ( 3, oTarget ) );
    string sLevel1 = IntToString ( GetLevelByPosition ( 1, oTarget ) );
    string sLevel2 = IntToString ( GetLevelByPosition ( 2, oTarget ) );
    string sLevel3 = IntToString ( GetLevelByPosition ( 3, oTarget ) );
    string sALignGoodEvil = IntToString ( GetGoodEvilValue ( oTarget ) );
    string sALignLawChaos = IntToString ( GetLawChaosValue ( oTarget ) );
    string sRace = RaceToString ( GetRacialType ( oTarget ) );
    string sSubRace = GetSubRace ( oTarget );
    string sStrength = IntToString ( GetAbilityScore ( oTarget, ABILITY_STRENGTH ) );
    string sDexterity = IntToString ( GetAbilityScore ( oTarget, ABILITY_DEXTERITY ) );
    string sConstitution = IntToString ( GetAbilityScore ( oTarget, ABILITY_CONSTITUTION ) );
    string sIntelligence = IntToString ( GetAbilityScore ( oTarget, ABILITY_INTELLIGENCE ) );
    string sWisdom = IntToString ( GetAbilityScore ( oTarget, ABILITY_WISDOM ) );
    string sCharisma = IntToString ( GetAbilityScore ( oTarget, ABILITY_CHARISMA ) );
    string sAC = IntToString ( GetAC ( oTarget ) );
    string sBaseAttackBonus = IntToString ( GetBaseAttackBonus ( oTarget ) );
    string sMovementRate = IntToString ( GetMovementRate ( oTarget ) );
    string sPlotFlag = IntToString ( GetPlotFlag ( oTarget ) );
    string sFeatures = CreateFeatureMessage ( oTarget );
    string sSkills = CreateSkillMessage ( oTarget );
    string sSize = CreatureSizeToString ( GetCreatureSize ( oTarget ) );
    string sGold = IntToString ( GetGold ( oTarget ) );
    string sMessage =
              "***********************************************"
    + "\n" +  "*                  Char Dump"
    + "\n" +  "***********************************************"
    + "\n" +  "* Name       : " + GetName ( oTarget )
    + "\n" +  "* Account    : " + GetPCPlayerName ( oTarget )
    + "\n" +  "* CD-Key     : " + GetPCPublicCDKey ( oTarget )
    + "\n" +  "* IP-Address : " + GetPCIPAddress ( oTarget )
    + "\n" +  "*"
    + "\n" +  "* Class 1    : " + sClass1 + " / " + sLevel1
    + "\n" +  "* Class 2    : " + sClass2 + " / " + sLevel2
    + "\n" +  "* Class 3    : " + sClass3 + " / " + sLevel3
    + "\n" +  "*"
    + "\n" +  "* Alignment  : " + sALignGoodEvil + "/" + sALignLawChaos
    + "\n" +  "*"
    + "\n" +  "* Race       : " + sRace
    + "\n" +  "* SubRace    : " + sSubRace
    + "\n" +  "* Size       : " + sSize
    + "\n" +  "*"
    + "\n" +  "* Abilities"
    + "\n" +  "* Strength   : " + sStrength
    + "\n" +  "* Dexterity  : " + sDexterity
    + "\n" +  "* Const.     : " + sConstitution
    + "\n" +  "* Intel.     : " + sIntelligence
    + "\n" +  "* Wisdom     : " + sWisdom
    + "\n" +  "* Charisma   : " + sCharisma
    + "\n" +  "*"
    + "\n" +  "* Ac         : " + sAC
    + "\n" +  "* Base Attack: " + sBaseAttackBonus
    + "\n" +  "* Movement Rt: " + sMovementRate
    + "\n" +  "*"
    + "\n" +  "* Plot Flag  : " + sPlotFlag
    + "\n" +  "*"
    + "\n" +  "* Features"
    + "\n" +  sFeatures
    + "\n" +  "*"
    + "\n" +  "* Skills"
    + "\n" +  sSkills
    + "\n" +  "*"
    + "\n" +  "* Gold       : " + sGold
    + "\n" +  "***********************************************";
    return sMessage;
}
// walk through all features of a player and create for each featue a line
// "* Featurename
string CreateFeatureMessage ( object oPlayer )
{
    string sMessage = "";
    int nFeat;
    // number of skills from LETO
    for ( nFeat = 0; nFeat <= 1071; nFeat++ )
    {
        if ( GetHasFeat ( nFeat, oPlayer ) )
        {
            sMessage += "* " + FeatureToString ( nFeat ) + "\n";
        }
    }
    //remove last "\n"
    sMessage = GetStringLeft ( sMessage, GetStringLength ( sMessage )- 1 );
    return sMessage;
}

string FillString ( string sString, int nLength )
{
    if ( GetStringLength ( sString ) < nLength )
    {
        int i;
        int nOldLength = GetStringLength ( sString );
        for ( i = 0; i < ( nLength - nOldLength ); i++  )
        {
            sString += " ";
        }

    }
    return sString;
}

// walk through all skills of a player and create for each skill a line
// "* skillname : Rank
string CreateSkillMessage ( object oPlayer )
{
    string sMessage = "";
    string sSkillName;
    int nSkill;
    for ( nSkill = 0; nSkill <= 30; nSkill++ )
    {
        if ( GetHasSkill ( nSkill, oPlayer ) )
        {
            sSkillName = SkillToString ( nSkill );
            int nSkillRank = GetSkillRank ( nSkill, oPlayer );
            string sSkillRank = IntToString ( nSkillRank );

            if ( nSkillRank < 10 && nSkillRank >= 0 )
            {
                sSkillRank = "  " + sSkillRank;
            } else if ( nSkillRank < 100 && nSkillRank >= 10 )
            {
                sSkillRank = " " + sSkillRank;
            }else  if ( nSkillRank < 0 && nSkillRank > -10 )
            {
                sSkillRank = " " + sSkillRank;
            }

            sMessage += "* " + FillString ( sSkillName, 15 ) + " : " +
                        sSkillRank + "\n";
        }
    }
    //remove last "\n"
    sMessage = GetStringLeft ( sMessage, GetStringLength ( sMessage )- 1 );
    return sMessage;
}

string ClassToString ( int nClass )
{
    string sClass;
    switch ( nClass )
    {
        case CLASS_TYPE_ABERRATION: sClass = "Aberration";
            break;
        case CLASS_TYPE_ANIMAL: sClass = "Animal";
            break;
        case CLASS_TYPE_ARCANE_ARCHER: sClass = "Arcane Archer";
            break;
        case CLASS_TYPE_ASSASSIN: sClass = "Assassin";
            break;
        case CLASS_TYPE_BARBARIAN: sClass = "Barbarian";
            break;
        case CLASS_TYPE_BARD: sClass = "Bard";
            break;
        case CLASS_TYPE_BEAST: sClass = "Beast";
            break;
        case CLASS_TYPE_BLACKGUARD: sClass = "Blackguard";
            break;
        case CLASS_TYPE_CLERIC: sClass = "Cleric";
            break;
        case CLASS_TYPE_COMMONER: sClass = "Commoner";
            break;
        case CLASS_TYPE_CONSTRUCT: sClass = "Construct";
            break;
        case CLASS_TYPE_DIVINE_CHAMPION: sClass = "Divine Champion";
            break;
        case CLASS_TYPE_DRAGON: sClass = "Dragon";
            break;
        case CLASS_TYPE_DRAGON_DISCIPLE: sClass = "Red Dragon Disciple";
            break;
        case CLASS_TYPE_DRUID: sClass = "Druid";
            break;
        case CLASS_TYPE_DWARVEN_DEFENDER: sClass = "Dwarfen Defender";
            break;
        case CLASS_TYPE_ELEMENTAL: sClass = "Elemental";
            break;
        case CLASS_TYPE_FEY: sClass = "Fey";
            break;
        case CLASS_TYPE_FIGHTER: sClass = "Fighter";
            break;
        case CLASS_TYPE_GIANT: sClass = "Giant";
            break;
        case CLASS_TYPE_HARPER: sClass = "Harper";
            break;
        case CLASS_TYPE_HUMANOID: sClass = "Human";
            break;
        case CLASS_TYPE_INVALID: sClass = "";
            break;
        case CLASS_TYPE_MAGICAL_BEAST: sClass = "Magical Beast";
            break;
        case CLASS_TYPE_MONK: sClass = "Monk";
            break;
        case CLASS_TYPE_MONSTROUS: sClass = "Monstrous";
            break;
        case CLASS_TYPE_OOZE: sClass = "Ooze";
            break;
        case CLASS_TYPE_OUTSIDER: sClass = "Outsider";
            break;
        case CLASS_TYPE_PALADIN: sClass = "Paladin";
            break;
        case CLASS_TYPE_PALE_MASTER: sClass = "Pale Master";
            break;
        case CLASS_TYPE_RANGER: sClass = "Ranger";
            break;
        case CLASS_TYPE_ROGUE: sClass = "Rouge";
            break;
        case CLASS_TYPE_SHADOWDANCER: sClass = "Shadow Dancer";
            break;
        case CLASS_TYPE_SHAPECHANGER: sClass = "Shapechanger";
            break;
        case CLASS_TYPE_SHIFTER: sClass = "Shifter";
            break;
        case CLASS_TYPE_SORCERER: sClass = "Sorcerer";
            break;
        case CLASS_TYPE_UNDEAD: sClass = "Undead";
            break;
        case CLASS_TYPE_VERMIN: sClass = "Vermin";
            break;
        case CLASS_TYPE_WEAPON_MASTER: sClass = "Weapon Master";
            break;
        case CLASS_TYPE_WIZARD: sClass = "Wizard";
            break;
        default: sClass = IntToString ( nClass );
    }

    return sClass;
}

string RaceToString ( int nRace )
{
    string sRace;
    switch ( nRace )
    {
        case RACIAL_TYPE_ABERRATION: sRace = "Aberration";
            break;
        case RACIAL_TYPE_ANIMAL: sRace = "Animal";
            break;
        case RACIAL_TYPE_BEAST: sRace = "Beast";
            break;
        case RACIAL_TYPE_CONSTRUCT: sRace = "Construct";
            break;
        case RACIAL_TYPE_DRAGON: sRace = "Dragon";
            break;
        case RACIAL_TYPE_DWARF: sRace = "Dwarf";
            break;
        case RACIAL_TYPE_ELEMENTAL: sRace = "Elemental";
            break;
        case RACIAL_TYPE_ELF: sRace = "Elf";
            break;
        case RACIAL_TYPE_FEY: sRace = "Fey";
            break;
        case RACIAL_TYPE_GIANT: sRace = "Giant";
            break;
        case RACIAL_TYPE_GNOME: sRace = "Gnome";
            break;
        case RACIAL_TYPE_HALFELF: sRace = "Half Elf";
            break;
        case RACIAL_TYPE_HALFLING: sRace = "Halfling";
            break;
        case RACIAL_TYPE_HALFORC: sRace = "Half Orc";
            break;
        case RACIAL_TYPE_HUMAN: sRace = "Human";
            break;
        case RACIAL_TYPE_HUMANOID_GOBLINOID: sRace = "Goblin";
            break;
        case RACIAL_TYPE_HUMANOID_MONSTROUS: sRace = "Monstrous";
            break;
        case RACIAL_TYPE_HUMANOID_ORC: sRace = "Orc";
            break;
        case RACIAL_TYPE_HUMANOID_REPTILIAN: sRace = "Reptilian";
            break;
        case RACIAL_TYPE_MAGICAL_BEAST: sRace = "Magical Beast";
            break;
        case RACIAL_TYPE_OOZE: sRace = "Ooze";
            break;
        case RACIAL_TYPE_OUTSIDER: sRace = "Outsider";
            break;
        case RACIAL_TYPE_SHAPECHANGER: sRace = "Shapechanger";
            break;
        case RACIAL_TYPE_UNDEAD: sRace = "Undead";
            break;
        case RACIAL_TYPE_VERMIN: sRace = "Vermin";
            break;
        default: sRace = IntToString ( nRace );
    }

    return sRace;
}

string FeatureToString ( int nFeat )
{
    string sFeat;
    switch ( nFeat )
    {
        case FEAT_AIR_DOMAIN_POWER : sFeat = "Air Domain Power";
            break;
        case FEAT_ALERTNESS : sFeat = "Alertness";
            break;
        case FEAT_AMBIDEXTERITY : sFeat = "Ambidexterity";
            break;
        case FEAT_ANIMAL_DOMAIN_POWER : sFeat = "Animal Domain Power";
            break;
        case FEAT_ANIMATE_DEAD : sFeat = "Animate Dead";
            break;
        case FEAT_ARCANE_DEFENSE_ABJURATION :
        case FEAT_ARCANE_DEFENSE_CONJURATION :
        case FEAT_ARCANE_DEFENSE_DIVINATION :
        case FEAT_ARCANE_DEFENSE_ENCHANTMENT :
        case FEAT_ARCANE_DEFENSE_EVOCATION :
        case FEAT_ARCANE_DEFENSE_ILLUSION :
        case FEAT_ARCANE_DEFENSE_NECROMANCY :
        case FEAT_ARCANE_DEFENSE_TRANSMUTATION :sFeat = "Arcane Defence " + IntToString ( nFeat );
            break;
        case FEAT_ARMOR_PROFICIENCY_HEAVY : sFeat = "Armor Proficiency Heavy";
            break;
        case FEAT_ARMOR_PROFICIENCY_LIGHT : sFeat = "Armor Proficiency Light";
            break;
        case FEAT_ARMOR_PROFICIENCY_MEDIUM : sFeat = "Armor Proficiency Medium";
            break;
        case FEAT_ARTIST : sFeat = "Artist";
            break;
        case FEAT_AURA_OF_COURAGE : sFeat = "Aura of Courage";
            break;
        case FEAT_BARBARIAN_ENDURANCE : sFeat = "Babarian Endurance";
            break;
        case FEAT_BARBARIAN_RAGE : sFeat = "Barbarian Rage";
             break;
        case 326 : sFeat = "Barbarian Rage 2xDay";
             break;
        case 327 : sFeat = "Barbarian Rage 3xDay";
             break;
        case 328 : sFeat = "Barbarian Rage 4xDay";
             break;
        case 329 : sFeat = "Greater Rage 4xDay";
             break;
        case 330 : sFeat = "Greater Rage 5xDay";
             break;
        case 331 : sFeat = "Greater Rage 6xDay";
             break;
        case 332 : sFeat = "Damage Reduction 2";
             break;
        case 333 : sFeat = "Damage Reduction 3";
             break;
        case 334 : sFeat = "Damage Reduction 4";
             break;
        case 355 :
        case 356 :
        case 357 :
        case 358 :
        case 359 :
        case 360 :
        case 361 :
        case 362 :
        case 363 :
        case 364 :
        case 365 :
        case 366 :
        case 367 :
        case 368 :
        case 369 :
        case 370 :
        case 371 :
        case 372 :
        case 373 :
        case FEAT_BARD_SONGS : sFeat = "Bard Song";
            break;
        case FEAT_BARDIC_KNOWLEDGE : sFeat = "Bardic Knowledge";
            break;
        case FEAT_BATTLE_TRAINING_VERSUS_GIANTS :
        case FEAT_BATTLE_TRAINING_VERSUS_GOBLINS :
        case FEAT_BATTLE_TRAINING_VERSUS_ORCS :
        case FEAT_BATTLE_TRAINING_VERSUS_REPTILIANS : sFeat = "Battle Training versus Race" + IntToString ( nFeat );
            break;
        case FEAT_BLACKGUARD_SNEAK_ATTACK_10D6 : sFeat = "Black Guard Sneak Attack 10D6";
            break;
        case FEAT_BLACKGUARD_SNEAK_ATTACK_11D6 : sFeat = "Black Guard Sneak Attack 11D6";
            break;
        case FEAT_BLACKGUARD_SNEAK_ATTACK_12D6 : sFeat = "Black Guard Sneak Attack 12D6";
            break;
        case FEAT_BLACKGUARD_SNEAK_ATTACK_13D6 : sFeat = "Black Guard Sneak Attack 13D6";
            break;
        case FEAT_BLACKGUARD_SNEAK_ATTACK_14D6 : sFeat = "Black Guard Sneak Attack 14D6";
            break;
        case FEAT_BLACKGUARD_SNEAK_ATTACK_15D6 : sFeat = "Black Guard Sneak Attack 15D6";
            break;
        case FEAT_BLACKGUARD_SNEAK_ATTACK_1D6 : sFeat = "Black Guard Sneak Attack 1D6";
            break;
        case FEAT_BLACKGUARD_SNEAK_ATTACK_2D6 : sFeat = "Black Guard Sneak Attack 2D6";
            break;
        case FEAT_BLACKGUARD_SNEAK_ATTACK_3D6 : sFeat = "Black Guard Sneak Attack 3D6";
            break;
        case FEAT_BLACKGUARD_SNEAK_ATTACK_4D6 : sFeat = "Black Guard Sneak Attack 4D6";
            break;
        case FEAT_BLACKGUARD_SNEAK_ATTACK_5D6 : sFeat = "Black Guard Sneak Attack 5D6";
            break;
        case FEAT_BLACKGUARD_SNEAK_ATTACK_6D6 : sFeat = "Black Guard Sneak Attack 6D6";
            break;
        case FEAT_BLACKGUARD_SNEAK_ATTACK_7D6 : sFeat = "Black Guard Sneak Attack 7D6";
            break;
        case FEAT_BLACKGUARD_SNEAK_ATTACK_8D6 : sFeat = "Black Guard Sneak Attack 8D6";
            break;
        case FEAT_BLACKGUARD_SNEAK_ATTACK_9D6 : sFeat = "Black Guard Sneak Attack 9D6";
            break;
        case FEAT_BLIND_FIGHT : sFeat = "Blind Fight";
            break;
        case FEAT_BLOODED : sFeat = "Blooded";
            break;
        case FEAT_BONE_SKIN_2 : sFeat = "Bone Skin 2";
            break;
        case FEAT_BONE_SKIN_4 : sFeat = "Bone Skin 4";
            break;
        case FEAT_BONE_SKIN_6 : sFeat = "Bone Skin 6";
            break;
        case FEAT_BREW_POTION : sFeat = "Brew Potion";
            break;
        case FEAT_BULLHEADED : sFeat = "Bull Headed";
            break;
        case FEAT_BULLS_STRENGTH : sFeat = "Bull Strenght";
            break;
        case FEAT_CALLED_SHOT : sFeat = "Called Shot";
            break;
        case FEAT_CIRCLE_KICK : sFeat = "Circle Cick";
            break;
        case FEAT_CLEAVE : sFeat = "Cleave";
            break;
        case FEAT_COMBAT_CASTING : sFeat = "Combat Casting";
            break;
        case FEAT_CONTAGION : sFeat = "Contagion";
            break;
        case FEAT_COURTLY_MAGOCRACY : sFeat = "Courtly Magocracy";
            break;
        case FEAT_CRAFT_HARPER_ITEM : sFeat = "Craft Harper Item";
            break;
        case FEAT_CRAFT_WAND : sFeat = "Craft Wand";
            break;
        case FEAT_CRIPPLING_STRIKE : sFeat = "Crippling Strike";
            break;
        case FEAT_CURSE_SONG : sFeat = "Curse Song";
            break;
        case FEAT_DAMAGE_REDUCTION : sFeat = "Damage Reduction";
            break;
        case FEAT_DAMAGE_REDUCTION_6 : sFeat = "Dwarfen Defender Damage Reduction 3/6";
            break;
        case FEAT_DARKVISION : sFeat = "Darkvision";
            break;
        case FEAT_DEATH_DOMAIN_POWER : sFeat = "Death Domain Power";
            break;
        case FEAT_DEATHLESS_MASTER_TOUCH : sFeat = "Deathless Master Touch";
            break;
        case FEAT_DEATHLESS_MASTERY : sFeat = "Deathless Mastery";
            break;
        case FEAT_DEATHLESS_VIGOR : sFeat = "Deathless Vigor";
            break;
        case FEAT_DEFENSIVE_ROLL : sFeat = "Defensive Roll";
            break;
        case FEAT_DEFLECT_ARROWS : sFeat = "Deflext Arrows";
            break;
        case FEAT_DENEIRS_EYE : sFeat = "Deneirs Eye";
            break;
        case FEAT_DESTRUCTION_DOMAIN_POWER : sFeat = "Destruction Domain Power";
            break;
        case FEAT_DIAMOND_BODY : sFeat = "Diamond Body";
            break;
        case FEAT_DIAMOND_SOUL : sFeat = "Diamond Soul";
            break;
        case FEAT_DIRTY_FIGHTING : sFeat = "Dirty Fighting";
            break;
        case FEAT_DISARM : sFeat = "Disarm";
            break;
        case FEAT_DIVINE_GRACE : sFeat = "Divine Grace";
            break;
        case FEAT_DIVINE_HEALTH : sFeat = "Divine Health";
            break;
        case FEAT_DIVINE_MIGHT : sFeat = "Divine Might";
            break;
        case FEAT_DIVINE_SHIELD : sFeat = "Divine Shield";
            break;
        case FEAT_DIVINE_WRATH : sFeat = "Divine Wraith";
            break;
        case FEAT_DODGE : sFeat = "Dogde";
            break;
        case FEAT_DRAGON_ABILITIES : sFeat = "Dragon Abilities";
            break;
        case FEAT_DRAGON_ARMOR : sFeat = "Dragon Armor";
            break;
        case FEAT_DRAGON_DIS_BREATH : sFeat = "Dragon Disciple Breath";
            break;
        case FEAT_DRAGON_HDINCREASE_D10 : sFeat = "DD Hit Dice Increase D10";
            break;
        case FEAT_DRAGON_HDINCREASE_D6 : sFeat = "DD Hit Dice Increase D6";
            break;
        case FEAT_DRAGON_HDINCREASE_D8 : sFeat = "DD Hit Dice Increase D8";
            break;
        case FEAT_DRAGON_IMMUNE_FIRE : sFeat = "DD Immune Fire";
            break;
        case FEAT_DRAGON_IMMUNE_PARALYSIS : sFeat = "DD Immune Paralysis";
            break;
        case FEAT_DWARVEN_DEFENDER_DEFENSIVE_STANCE : sFeat = "Dwarfen Defender Defence Stance";
            break;
        case FEAT_EARTH_DOMAIN_POWER : sFeat = "Earth Domain Power";
            break;
        case FEAT_ELEMENTAL_SHAPE : sFeat = "Elemental Shape";
            break;
        case FEAT_EMPOWER_SPELL : sFeat = "Empower Spell";
            break;
        case FEAT_EMPTY_BODY : sFeat = "Empty Body";
            break;
        case FEAT_EPIC_ARCANE_ARCHER :
        case FEAT_EPIC_ASSASSIN :
        case FEAT_EPIC_BARBARIAN :
        case FEAT_EPIC_BARD :
        case FEAT_EPIC_BLACKGUARD :
        case FEAT_EPIC_CLERIC :
        case FEAT_EPIC_DIVINE_CHAMPION :
        case FEAT_EPIC_DRUID :
        case FEAT_EPIC_DWARVEN_DEFENDER :
        case FEAT_EPIC_FIGHTER :
        case FEAT_EPIC_HARPER_SCOUT :
        case FEAT_EPIC_MONK :
        case FEAT_EPIC_PALADIN :
        case FEAT_EPIC_PALE_MASTER :
        case FEAT_EPIC_RANGER :
        case FEAT_EPIC_RED_DRAGON_DISC :
        case FEAT_EPIC_ROGUE :
        case FEAT_EPIC_SHADOWDANCER :
        case FEAT_EPIC_SHIFTER :
        case FEAT_EPIC_SORCERER :
        case FEAT_EPIC_WIZARD : sFeat = "Epic Class";
            break;
        case FEAT_EVASION : sFeat = "Evasion";
            break;
        case FEAT_EVIL_DOMAIN_POWER : sFeat = "Evil Domain Power";
            break;
        case FEAT_EXPERTISE : sFeat = "Expertise";
            break;
        case FEAT_EXTEND_SPELL : sFeat = "Extend Spell";
            break;
        case FEAT_EXTRA_MUSIC : sFeat = "Extra Music";
            break;
        case FEAT_EXTRA_SMITING : sFeat = "Extra Smiting";
            break;
        case FEAT_EXTRA_STUNNING_ATTACK : sFeat = "Extra Stunning Attack";
            break;
        case FEAT_EXTRA_TURNING : sFeat = "Extra Turning";
            break;
        case FEAT_FAVORED_ENEMY_ABERRATION : sFeat = "Favored Enemy Aberration";
            break;
        case FEAT_FAVORED_ENEMY_ANIMAL : sFeat = "Favored Enemy Animal";
            break;
        case FEAT_FAVORED_ENEMY_BEAST : sFeat = "Favored Enemy Beast";
            break;
        case FEAT_FAVORED_ENEMY_CONSTRUCT : sFeat = "Favored Enemy Construct";
            break;
        case FEAT_FAVORED_ENEMY_DRAGON : sFeat = "Favored Enemy Dragon";
            break;
        case FEAT_FAVORED_ENEMY_DWARF : sFeat = "Favored Enemy Dwarf";
            break;
        case FEAT_FAVORED_ENEMY_ELEMENTAL : sFeat = "Favored Enemy Elemental";
            break;
        case FEAT_FAVORED_ENEMY_ELF : sFeat = "Favored Enemy Elf";
            break;
        case FEAT_FAVORED_ENEMY_FEY : sFeat = "Favored Enemy Fey";
            break;
        case FEAT_FAVORED_ENEMY_GIANT : sFeat = "Favored Enemy Giant";
            break;
        case FEAT_FAVORED_ENEMY_GNOME : sFeat = "Favored Enemy Gnome";
            break;
        case FEAT_FAVORED_ENEMY_GOBLINOID : sFeat = "Favored Enemy Goblonoid";
            break;
        case FEAT_FAVORED_ENEMY_HALFELF : sFeat = "Favored Enemy Halfelf";
            break;
        case FEAT_FAVORED_ENEMY_HALFLING : sFeat = "Favored Enemy Halfling";
            break;
        case FEAT_FAVORED_ENEMY_HALFORC : sFeat = "Favored Enemy Halforc";
            break;
        case FEAT_FAVORED_ENEMY_HUMAN : sFeat = "Favored Enemy Human";
            break;
        case FEAT_FAVORED_ENEMY_MAGICAL_BEAST : sFeat = "Favored Enemy Magical Beast";
            break;
        case FEAT_FAVORED_ENEMY_MONSTROUS : sFeat = "Favored Enemy Monstrous";
            break;
        case FEAT_FAVORED_ENEMY_ORC : sFeat = "Favored Enemy Orc";
            break;
        case FEAT_FAVORED_ENEMY_OUTSIDER : sFeat = "Favored Enemy Outsider";
            break;
        case FEAT_FAVORED_ENEMY_REPTILIAN : sFeat = "Favored Enemy Reptilian";
            break;
        case FEAT_FAVORED_ENEMY_SHAPECHANGER : sFeat = "Favored Enemy Shapechanger";
            break;
        case FEAT_FAVORED_ENEMY_UNDEAD : sFeat = "Favored Enemy Undead";
            break;
        case FEAT_FAVORED_ENEMY_VERMIN : sFeat = "Favored Enemy Vermin";
            break;
        case FEAT_FEARLESS : sFeat = "Fearless";
            break;
        case FEAT_FIRE_DOMAIN_POWER : sFeat = "Fire Domain Power";
            break;
        case FEAT_FLURRY_OF_BLOWS : sFeat = "Flurry of Blows";
            break;
        case FEAT_GOOD_AIM : sFeat = "Good Aim";
            break;
        case FEAT_GOOD_DOMAIN_POWER : sFeat = "Good Domain Power";
            break;
        case FEAT_GREAT_CLEAVE : sFeat = "Great Cleave";
            break;
        case FEAT_GREAT_FORTITUDE : sFeat = "Great Fortitude";
            break;
        case FEAT_GREATER_SPELL_FOCUS_ABJURATION :
        case FEAT_GREATER_SPELL_FOCUS_CONJURATION :
        case FEAT_GREATER_SPELL_FOCUS_DIVINATION :
        case FEAT_GREATER_SPELL_FOCUS_ENCHANTMENT :
        case FEAT_GREATER_SPELL_FOCUS_EVOCATION :
        case FEAT_GREATER_SPELL_FOCUS_ILLUSION :
        case FEAT_GREATER_SPELL_FOCUS_NECROMANCY :
        case FEAT_GREATER_SPELL_FOCUS_TRANSMUTATION : sFeat = "Greater Spell Focus" + IntToString ( nFeat );
            break;
        case FEAT_GREATER_SPELL_PENETRATION : sFeat = "Greater Spell Penetration";
            break;
        case FEAT_GREATER_WILDSHAPE_1 : sFeat = "Greater Wildshape 1";
            break;
        case FEAT_GREATER_WILDSHAPE_2 : sFeat = "Greater Wildshape 2";
            break;
        case FEAT_GREATER_WILDSHAPE_3 : sFeat = "Greater Wildshape 3";
            break;
        case FEAT_GREATER_WILDSHAPE_4 : sFeat = "Greater Wildshape 4";
            break;
        case FEAT_HARDINESS_VERSUS_ENCHANTMENTS : sFeat = "Hardiness versus Enchantement";
            break;
        case FEAT_HARDINESS_VERSUS_ILLUSIONS : sFeat = "Hardiness versus Illusions";
            break;
        case FEAT_HARDINESS_VERSUS_POISONS : sFeat = "Hardiness versus Poision";
            break;
        case FEAT_HARDINESS_VERSUS_SPELLS : sFeat = "Hardiness versus Spells";
            break;
        case FEAT_HARPER_CATS_GRACE : sFeat = "Harper Cats Grace";
            break;
        case FEAT_HARPER_EAGLES_SPLENDOR : sFeat = "Eagles Splendor";
            break;
        case FEAT_HARPER_INVISIBILITY : sFeat = "Harper Invisibility";
            break;
        case FEAT_HARPER_SLEEP : sFeat = "Harper Sleep";
            break;
        case FEAT_HEALING_DOMAIN_POWER : sFeat = "Healing Domain Power";
            break;
        case FEAT_HIDE_IN_PLAIN_SIGHT : sFeat = "Hide in Plain Sight";
            break;
        case FEAT_HUMANOID_SHAPE : sFeat = "Humanoid Shape";
            break;
        case FEAT_IMMUNITY_TO_SLEEP : sFeat = "Immunity to Sleep";
            break;
        case FEAT_IMPROVED_CRITICAL_BASTARD_SWORD : sFeat = "Improved Critical Bastard";
            break;
        case FEAT_IMPROVED_CRITICAL_BATTLE_AXE : sFeat = "Improved Critical Battle Axe";
            break;
        case FEAT_IMPROVED_CRITICAL_CLUB : sFeat = "Improved Critical Club";
            break;
        case FEAT_IMPROVED_CRITICAL_CREATURE : sFeat = "Improved Critical Creature";
            break;
        case FEAT_IMPROVED_CRITICAL_DAGGER : sFeat = "Improved Critical Dagger";
            break;
        case FEAT_IMPROVED_CRITICAL_DART : sFeat = "Improved Critical Dart";
            break;
        case FEAT_IMPROVED_CRITICAL_DIRE_MACE : sFeat = "Improved Critical Dire Mace";
            break;
        case FEAT_IMPROVED_CRITICAL_DOUBLE_AXE : sFeat = "Improved Critical Double Axe";
            break;
        case FEAT_IMPROVED_CRITICAL_DWAXE : sFeat = "Improved Critical Dwarfen Axe";
            break;
        case FEAT_IMPROVED_CRITICAL_GREAT_AXE : sFeat = "Improved Critical Great Axe";
            break;
        case FEAT_IMPROVED_CRITICAL_GREAT_SWORD : sFeat = "Improved Critical Great Sword";
            break;
        case FEAT_IMPROVED_CRITICAL_HALBERD : sFeat = "Improved Critical Halberd";
            break;
        case FEAT_IMPROVED_CRITICAL_HAND_AXE : sFeat = "Improved Critical Hand Axe";
            break;
        case FEAT_IMPROVED_CRITICAL_HEAVY_CROSSBOW : sFeat = "Improved Critical Heavy Crossbow";
            break;
        case FEAT_IMPROVED_CRITICAL_HEAVY_FLAIL : sFeat = "Improved Critical Heavy Flail";
            break;
        case FEAT_IMPROVED_CRITICAL_KAMA : sFeat = "Improved Critical Kama";
            break;
        case FEAT_IMPROVED_CRITICAL_KATANA : sFeat = "Improved Critical Katana";
            break;
        case FEAT_IMPROVED_CRITICAL_KUKRI : sFeat = "Improved Critical Kukri";
            break;
        case FEAT_IMPROVED_CRITICAL_LIGHT_CROSSBOW : sFeat = "Improved Critical Light Crossbow";
            break;
        case FEAT_IMPROVED_CRITICAL_LIGHT_FLAIL : sFeat = "Improved Critical Light Flail";
            break;
        case FEAT_IMPROVED_CRITICAL_LIGHT_HAMMER : sFeat = "Improved Critical Light Hammer";
            break;
        case FEAT_IMPROVED_CRITICAL_LIGHT_MACE : sFeat = "Improved Critical Light Mace";
            break;
        case FEAT_IMPROVED_CRITICAL_LONG_SWORD : sFeat = "Improved Critical Long Sword";
            break;
        case FEAT_IMPROVED_CRITICAL_LONGBOW : sFeat = "Improved Critical Long Bow";
            break;
        case FEAT_IMPROVED_CRITICAL_MORNING_STAR : sFeat = "Improved Critical Morning Star";
            break;
        case FEAT_IMPROVED_CRITICAL_RAPIER : sFeat = "Improved Critical Rapier";
            break;
        case FEAT_IMPROVED_CRITICAL_SCIMITAR : sFeat = "Improved Critical Scimitar";
            break;
        case FEAT_IMPROVED_CRITICAL_SCYTHE : sFeat = "Improved Critical Scythe";
            break;
        case FEAT_IMPROVED_CRITICAL_SHORT_SWORD : sFeat = "Improved Critical Short Sword";
            break;
        case FEAT_IMPROVED_CRITICAL_SHORTBOW : sFeat = "Improved Critical Shortbow";
            break;
        case FEAT_IMPROVED_CRITICAL_SHURIKEN : sFeat = "Improved Critical Shuriken";
            break;
        case FEAT_IMPROVED_CRITICAL_SICKLE : sFeat = "Improved Critical Sickle";
            break;
        case FEAT_IMPROVED_CRITICAL_SLING : sFeat = "Improved Critical Sling";
            break;
        case FEAT_IMPROVED_CRITICAL_SPEAR : sFeat = "Improved Critical Spear";
            break;
        case FEAT_IMPROVED_CRITICAL_STAFF : sFeat = "Improved Critical Staff";
            break;
        case FEAT_IMPROVED_CRITICAL_THROWING_AXE : sFeat = "Improved Critical Throwing Axe";
            break;
        case FEAT_IMPROVED_CRITICAL_TWO_BLADED_SWORD : sFeat = "Improved Critical Two Bladed Sword";
            break;
        case FEAT_IMPROVED_CRITICAL_UNARMED_STRIKE : sFeat = "Improved Critical Unarmed Strike";
            break;
        case FEAT_IMPROVED_CRITICAL_WAR_HAMMER : sFeat = "Improved Critical War Hammer";
            break;
        case FEAT_IMPROVED_CRITICAL_WHIP : sFeat = "Improved Critical Whip";
            break;
        case FEAT_IMPROVED_DISARM : sFeat = "Improved Disarm";
            break;
        case FEAT_IMPROVED_EVASION : sFeat = "Improved Evasion";
            break;
        case FEAT_IMPROVED_EXPERTISE : sFeat = "Improved Expertise";
            break;
        case FEAT_IMPROVED_INITIATIVE : sFeat = "Improved Initiative";
            break;
        case FEAT_IMPROVED_KNOCKDOWN : sFeat = "Improved Knockdown";
            break;
        case FEAT_IMPROVED_PARRY : sFeat = "Improved Parry";
            break;
        case FEAT_IMPROVED_POWER_ATTACK : sFeat = "Improved Power Attack";
            break;
        case FEAT_IMPROVED_TWO_WEAPON_FIGHTING : sFeat = "Improved Two Weapon Fighting";
            break;
        case FEAT_IMPROVED_UNARMED_STRIKE : sFeat = "Improved Unarmed Strike";
            break;
        case FEAT_IMPROVED_WHIRLWIND : sFeat = "Improved Whirlwind";
            break;
        case FEAT_INCREASE_MULTIPLIER : sFeat = "Increase Multiplier";
            break;
        case FEAT_INFLICT_CRITICAL_WOUNDS : sFeat = "Inflict Critical Wounds";
            break;
        case FEAT_INFLICT_LIGHT_WOUNDS : sFeat = "Inflict Light Wounds";
            break;
        case FEAT_INFLICT_MODERATE_WOUNDS : sFeat = "Inflict Moderate Wounds";
            break;
        case FEAT_INFLICT_SERIOUS_WOUNDS : sFeat = "Inflict Serious Wounds";
            break;
        case FEAT_IRON_WILL : sFeat = "Iron Will";
            break;
        case FEAT_KEEN_SENSE : sFeat = "Keen Sense";
            break;
        case FEAT_KI_CRITICAL : sFeat = "KI Critical";
            break;
        case FEAT_KI_DAMAGE : sFeat = "KI Damage";
            break;
        case FEAT_KI_STRIKE : sFeat = "KI Strike";
            break;
        case 343 : sFeat = "KI Strike 2xDay";
            break;
        case 344 : sFeat = "KI Strike 3xDay";
            break;
        case FEAT_KNOCKDOWN : sFeat = "Knockdown";
            break;
        case FEAT_KNOWLEDGE_DOMAIN_POWER : sFeat = "Knowledge Domain Power";
            break;
        case FEAT_LAY_ON_HANDS : sFeat = "Lay on Hands";
            break;
        case FEAT_LIGHTNING_REFLEXES : sFeat = "Lightining Reflexes";
            break;
        case FEAT_LINGERING_SONG : sFeat = "Lingering Song";
            break;
        case FEAT_LLIIRAS_HEART : sFeat = "Lliiras Heart";
            break;
        case FEAT_LOWLIGHTVISION : sFeat = "Low Light Vision";
            break;
        case FEAT_LUCK_DOMAIN_POWER : sFeat = "Luck Domain Power";
            break;
        case FEAT_LUCK_OF_HEROES : sFeat = "Luck of Heros";
            break;
        case FEAT_LUCKY : sFeat = "Lucky";
            break;
        case FEAT_MAGIC_DOMAIN_POWER : sFeat = "Magic DOmain Power";
            break;
        case FEAT_MAXIMIZE_SPELL : sFeat = "Maximize Spell";
            break;
        case FEAT_MIGHTY_RAGE : sFeat = "Mighty Rage";
            break;
        case FEAT_MOBILITY : sFeat = "Mobility";
            break;
        case FEAT_MONK_AC_BONUS : sFeat = "Monk AC Bonus";
            break;
        case FEAT_MONK_ENDURANCE : sFeat = "Monk Endurance";
            break;
        case FEAT_NATURE_SENSE : sFeat = "Nature Sense";
            break;
        case FEAT_OPPORTUNIST : sFeat = "Opportunist";
            break;
        case FEAT_PARTIAL_SKILL_AFFINITY_LISTEN : sFeat = "Partial Skill Affinity Listen";
            break;
        case FEAT_PARTIAL_SKILL_AFFINITY_SEARCH : sFeat = "Partial Skill Affinity Search";
            break;
        case FEAT_PARTIAL_SKILL_AFFINITY_SPOT : sFeat = "Partial Skill Affinity Spot";
            break;
        case FEAT_PERFECT_SELF : sFeat = "Perfect Self";
            break;
        case FEAT_PLANT_DOMAIN_POWER : sFeat = "Plant Domain Power";
            break;
        case FEAT_POINT_BLANK_SHOT : sFeat = "Point Blank Shot";
            break;
        case FEAT_POWER_ATTACK : sFeat = "Power Attack";
            break;
        case FEAT_PRESTIGE_ARROW_OF_DEATH : sFeat = "Prestige Arrow of Death";
            break;
        case FEAT_PRESTIGE_DARK_BLESSING : sFeat = "Prestige Drak Blessing";
            break;
        case FEAT_PRESTIGE_DARKNESS : sFeat = "Prestige Darkness";
            break;
        case FEAT_PRESTIGE_DEATH_ATTACK_1 : sFeat = "Prestige Death Attack 1";
            break;
        case FEAT_PRESTIGE_DEATH_ATTACK_10 : sFeat = "Prestige Death Attack 10";
            break;
        case FEAT_PRESTIGE_DEATH_ATTACK_11 : sFeat = "Prestige Death Attack 11";
            break;
        case FEAT_PRESTIGE_DEATH_ATTACK_12 : sFeat = "Prestige Death Attack 12";
            break;
        case FEAT_PRESTIGE_DEATH_ATTACK_13 : sFeat = "Prestige Death Attack 13";
            break;
        case FEAT_PRESTIGE_DEATH_ATTACK_14 : sFeat = "Prestige Death Attack 14";
            break;
        case FEAT_PRESTIGE_DEATH_ATTACK_15 : sFeat = "Prestige Death Attack 15";
            break;
        case FEAT_PRESTIGE_DEATH_ATTACK_16 : sFeat = "Prestige Death Attack 16";
            break;
        case FEAT_PRESTIGE_DEATH_ATTACK_17 : sFeat = "Prestige Death Attack 17";
            break;
        case FEAT_PRESTIGE_DEATH_ATTACK_18 : sFeat = "Prestige Death Attack 18";
            break;
        case FEAT_PRESTIGE_DEATH_ATTACK_19 : sFeat = "Prestige Death Attack 19";
            break;
        case FEAT_PRESTIGE_DEATH_ATTACK_20 : sFeat = "Prestige Death Attack 20";
            break;
        case FEAT_PRESTIGE_DEATH_ATTACK_2 : sFeat = "Prestige Death Attack 2";
            break;
        case FEAT_PRESTIGE_DEATH_ATTACK_3 : sFeat = "Prestige Death Attack 3";
            break;
        case FEAT_PRESTIGE_DEATH_ATTACK_4 : sFeat = "Prestige Death Attack 4";
            break;
        case FEAT_PRESTIGE_DEATH_ATTACK_5 : sFeat = "Prestige Death Attack 5";
            break;
        case FEAT_PRESTIGE_DEATH_ATTACK_6 : sFeat = "Prestige Death Attack 6";
            break;
        case FEAT_PRESTIGE_DEATH_ATTACK_7 : sFeat = "Prestige Death Attack 7";
            break;
        case FEAT_PRESTIGE_DEATH_ATTACK_8 : sFeat = "Prestige Death Attack 8";
            break;
        case FEAT_PRESTIGE_DEATH_ATTACK_9 : sFeat = "Prestige Death Attack 9";
            break;
        case FEAT_PRESTIGE_DEFENSIVE_AWARENESS_1 : sFeat = "Prestige Defensive Awareness 1";
            break;
        case FEAT_PRESTIGE_DEFENSIVE_AWARENESS_2 : sFeat = "Prestige Defensive Awareness 2";
            break;
        case FEAT_PRESTIGE_DEFENSIVE_AWARENESS_3 : sFeat = "Prestige Defensive Awareness 3";
            break;
        case FEAT_PRESTIGE_ENCHANT_ARROW_1 : sFeat = "Prestige Enchant Arrow 1";
            break;
        case FEAT_PRESTIGE_ENCHANT_ARROW_10 : sFeat = "Prestige Enchant Arrow 10";
            break;
        case FEAT_PRESTIGE_ENCHANT_ARROW_11 : sFeat = "Prestige Enchant Arrow 11";
            break;
        case FEAT_PRESTIGE_ENCHANT_ARROW_12 : sFeat = "Prestige Enchant Arrow 12";
            break;
        case FEAT_PRESTIGE_ENCHANT_ARROW_13 : sFeat = "Prestige Enchant Arrow 13";
            break;
        case FEAT_PRESTIGE_ENCHANT_ARROW_14 : sFeat = "Prestige Enchant Arrow 14";
            break;
        case FEAT_PRESTIGE_ENCHANT_ARROW_15 : sFeat = "Prestige Enchant Arrow 15";
            break;
        case FEAT_PRESTIGE_ENCHANT_ARROW_16 : sFeat = "Prestige Enchant Arrow 16";
            break;
        case FEAT_PRESTIGE_ENCHANT_ARROW_17 : sFeat = "Prestige Enchant Arrow 17";
            break;
        case FEAT_PRESTIGE_ENCHANT_ARROW_18 : sFeat = "Prestige Enchant Arrow 18";
            break;
        case FEAT_PRESTIGE_ENCHANT_ARROW_19 : sFeat = "Prestige Enchant Arrow 19";
            break;
        case FEAT_PRESTIGE_ENCHANT_ARROW_2 : sFeat = "Prestige Enchant Arrow 2";
            break;
        case FEAT_PRESTIGE_ENCHANT_ARROW_20 : sFeat = "Prestige Enchant Arrow 20";
            break;
        case FEAT_PRESTIGE_ENCHANT_ARROW_3 : sFeat = "Prestige Enchant Arrow 3";
            break;
        case FEAT_PRESTIGE_ENCHANT_ARROW_4 : sFeat = "Prestige Enchant Arrow 4";
            break;
        case FEAT_PRESTIGE_ENCHANT_ARROW_5 : sFeat = "Prestige Enchant Arrow 5";
            break;
        case FEAT_PRESTIGE_ENCHANT_ARROW_6 : sFeat = "Prestige Enchant Arrow 6";
            break;
        case FEAT_PRESTIGE_ENCHANT_ARROW_7 : sFeat = "Prestige Enchant Arrow 7";
            break;
        case FEAT_PRESTIGE_ENCHANT_ARROW_8 : sFeat = "Prestige Enchant Arrow 8";
            break;
        case FEAT_PRESTIGE_ENCHANT_ARROW_9 : sFeat = "Prestige Enchant Arrow 9";
            break;
        case FEAT_PRESTIGE_HAIL_OF_ARROWS : sFeat = "Prestige Hail of Arrows";
            break;
        case FEAT_PRESTIGE_IMBUE_ARROW : sFeat = "Prestige Imbue Arrow";
            break;
        case FEAT_PRESTIGE_INVISIBILITY_1 : sFeat = "Prestige Invisibilty 1";
            break;
        case FEAT_PRESTIGE_INVISIBILITY_2 : sFeat = "Prestige Invisibilty 2";
            break;
        case FEAT_PRESTIGE_POISON_SAVE_1 : sFeat = "Prestige Poison Save 1";
            break;
        case FEAT_PRESTIGE_POISON_SAVE_2 : sFeat = "Prestige Poison Save 2";
            break;
        case FEAT_PRESTIGE_POISON_SAVE_3 : sFeat = "Prestige Poison Save 3";
            break;
        case FEAT_PRESTIGE_POISON_SAVE_4 : sFeat = "Prestige Poison Save 4";
            break;
        case FEAT_PRESTIGE_POISON_SAVE_5 : sFeat = "Prestige Poison Save 5";
            break;
        case FEAT_PRESTIGE_SEEKER_ARROW_1 : sFeat = "Prestige Seeker Arrow 1";
            break;
        case FEAT_PRESTIGE_SEEKER_ARROW_2 : sFeat = "Prestige Seeker Arrow 2";
            break;
        case FEAT_PRESTIGE_SPELL_GHOSTLY_VISAGE : sFeat = "Prestige Spell Ghostly Visage";
            break;
        case FEAT_PROTECTION_DOMAIN_POWER : sFeat = "Protection Domain Power";
            break;
        case FEAT_PURITY_OF_BODY : sFeat = "Purity Of Body";
            break;
        case FEAT_QUICK_TO_MASTER : sFeat = "Quick To Master";
            break;
        case FEAT_QUICKEN_SPELL : sFeat = "Quicken Spell";
            break;
        case FEAT_QUIVERING_PALM : sFeat = "Quivering Palm";
            break;
        case FEAT_RAPID_RELOAD : sFeat = "Rapid Reload";
            break;
        case FEAT_RAPID_SHOT : sFeat = "Rapid Shot";
            break;
        case FEAT_REMOVE_DISEASE : sFeat = "Remove Disease";
            break;
        case FEAT_RESIST_DISEASE : sFeat = "Resist Disease";
            break;
        case FEAT_RESIST_ENERGY_ACID : sFeat = "Resist Energy Acid";
            break;
        case FEAT_RESIST_ENERGY_COLD : sFeat = "Resist Energy Cold";
            break;
        case FEAT_RESIST_ENERGY_ELECTRICAL : sFeat = "Resist Energy Electrical";
            break;
        case FEAT_RESIST_ENERGY_FIRE : sFeat = "Resist Energy Fire";
            break;
        case FEAT_RESIST_ENERGY_SONIC : sFeat = "Resist Energy Sonic";
            break;
        case FEAT_RESIST_NATURES_LURE : sFeat = "Resist Natures Lure";
            break;
        case FEAT_RESIST_POISON : sFeat = "Resist Poison";
            break;
        case FEAT_SACRED_DEFENSE_1 : sFeat = "Scared Defense 1";
            break;
        case FEAT_SACRED_DEFENSE_2 : sFeat = "Scared Defense 2";
            break;
        case FEAT_SACRED_DEFENSE_3 : sFeat = "Scared Defense 3";
            break;
        case FEAT_SACRED_DEFENSE_4 : sFeat = "Scared Defense 4";
            break;
        case FEAT_SACRED_DEFENSE_5 : sFeat = "Scared Defense 5";
            break;
        case FEAT_SAP : sFeat = "Sap";
            break;
        case FEAT_SCRIBE_SCROLL : sFeat = "Scribe Scroll";
            break;
        case FEAT_SHADOW_DAZE : sFeat = "Shadow Daze";
            break;
        case FEAT_SHADOW_EVADE : sFeat = "Shadow Evade";
            break;
        case FEAT_SHIELD_PROFICIENCY : sFeat = "Shield Proficency";
            break;
        case FEAT_SILENCE_SPELL : sFeat = "Silent Spell";
            break;
        case FEAT_SILVER_PALM : sFeat = "Silver Palm";
            break;
        case FEAT_SKILL_AFFINITY_CONCENTRATION : sFeat = "Skill Affinity Concentration";
            break;
        case FEAT_SKILL_AFFINITY_LISTEN : sFeat = "Skill Affinity Listen";
            break;
        case FEAT_SKILL_AFFINITY_LORE : sFeat = "Skill Affinity Lore";
            break;
        case FEAT_SKILL_AFFINITY_MOVE_SILENTLY : sFeat = "Skill Affinity Silently";
            break;
        case FEAT_SKILL_AFFINITY_SEARCH : sFeat = "Skill Affinity Search";
            break;
        case FEAT_SKILL_AFFINITY_SPOT : sFeat = "Skill Affinity Spot";
            break;
        case FEAT_SKILL_FOCUS_ANIMAL_EMPATHY : sFeat = "Skill Focus Animal Empathy";
            break;
        case FEAT_SKILL_FOCUS_BLUFF : sFeat = "Skill Focus Bluff";
            break;
        case FEAT_SKILL_FOCUS_CONCENTRATION : sFeat = "Skill Focus Concentration";
            break;
        case FEAT_SKILL_FOCUS_CRAFT_ARMOR : sFeat = "Skill Focus Craft Armor";
            break;
        case FEAT_SKILL_FOCUS_CRAFT_TRAP : sFeat = "Skill Focus Craft Trap";
            break;
        case FEAT_SKILL_FOCUS_CRAFT_WEAPON : sFeat = "Skill Focus Craft Weapon";
            break;
        case FEAT_SKILL_FOCUS_DISABLE_TRAP : sFeat = "Skill Focus Disable Trap";
            break;
        case FEAT_SKILL_FOCUS_DISCIPLINE : sFeat = "Skill Focus Discipline";
            break;
        case FEAT_SKILL_FOCUS_HEAL : sFeat = "Skill Focus Heal";
            break;
        case FEAT_SKILL_FOCUS_HIDE : sFeat = "Skill Focus Hide";
            break;
        case FEAT_SKILL_FOCUS_INTIMIDATE : sFeat = "Skill Focus Intimidate";
            break;
        case FEAT_SKILL_FOCUS_LISTEN : sFeat = "Skill Focus Listen";
            break;
        case FEAT_SKILL_FOCUS_LORE : sFeat = "Skill Focus Lore";
            break;
        case FEAT_SKILL_FOCUS_MOVE_SILENTLY : sFeat = "Skill Focus Move Silently";
            break;
        case FEAT_SKILL_FOCUS_OPEN_LOCK : sFeat = "Skill Focus Open Lock";
            break;
        case FEAT_SKILL_FOCUS_PARRY : sFeat = "Skill Focus Parry";
            break;
        case FEAT_SKILL_FOCUS_PERFORM : sFeat = "Skill Focus Perform";
            break;
        case FEAT_SKILL_FOCUS_PERSUADE : sFeat = "Skill Focus Persuade";
            break;
        case FEAT_SKILL_FOCUS_PICK_POCKET : sFeat = "Skill Focus Pick Pocket";
            break;
        case FEAT_SKILL_FOCUS_SEARCH : sFeat = "Skill Focus Search";
            break;
        case FEAT_SKILL_FOCUS_SET_TRAP : sFeat = "Skill Focus Set Trap";
            break;
        case FEAT_SKILL_FOCUS_SPELLCRAFT : sFeat = "Skill Focus Spellcraft";
            break;
        case FEAT_SKILL_FOCUS_SPOT : sFeat = "Skill Focus Spot";
            break;
        case FEAT_SKILL_FOCUS_TAUNT : sFeat = "Skill Focus Taunt";
            break;
        case FEAT_SKILL_FOCUS_TUMBLE : sFeat = "Skill Focus Tumble";
            break;
        case FEAT_SKILL_FOCUS_USE_MAGIC_DEVICE : sFeat = "Skill Focus Use Magic Device";
            break;
        case FEAT_SKILL_MASTERY : sFeat = "Mastery";
            break;
        case FEAT_SKILLFOCUS_APPRAISE : sFeat = "Skill Focus Appraise";
            break;
        case FEAT_SLIPPERY_MIND : sFeat = "Slippery Mind";
            break;
        case 375 : sFeat = "Small Stature";
            break;
        case FEAT_SMITE_EVIL : sFeat = "Smite Evil";
            break;
        case FEAT_SMITE_GOOD : sFeat = "Smite Good";
            break;
        case FEAT_SNAKEBLOOD : sFeat = "Snakeblood";
            break;
        case FEAT_SNEAK_ATTACK : sFeat = "Sneak Attack";
            break;
        case FEAT_SPELL_FOCUS_ABJURATION : sFeat = "Spell Focus Abjuration";
            break;
        case FEAT_SPELL_FOCUS_CONJURATION : sFeat = "Spell Focus Conjuration";
            break;
        case FEAT_SPELL_FOCUS_DIVINATION : sFeat = "Spell Focus Divination";
            break;
        case FEAT_SPELL_FOCUS_ENCHANTMENT : sFeat = "Spell Focus Enchantment";
            break;
        case FEAT_SPELL_FOCUS_EVOCATION : sFeat = "Spell Focus Evocation";
            break;
        case FEAT_SPELL_FOCUS_ILLUSION : sFeat = "Spell Focus Illusion";
            break;
        case FEAT_SPELL_FOCUS_NECROMANCY : sFeat = "Spell Focus Necromancy";
            break;
        case FEAT_SPELL_FOCUS_TRANSMUTATION : sFeat = "Spell Focus Transmution";
            break;
        case FEAT_SPELL_PENETRATION : sFeat = "Spell Penetration";
            break;
        case FEAT_SPRING_ATTACK : sFeat = "Spring Attack";
            break;
        case FEAT_STEALTHY : sFeat = "Stealthy";
            break;
        case FEAT_STILL_MIND : sFeat = "Still Mind";
            break;
        case FEAT_STILL_SPELL : sFeat = "Still Spell";
            break;
        case FEAT_STONECUNNING : sFeat = "Stonecunning";
            break;
        case FEAT_STRENGTH_DOMAIN_POWER : sFeat = "Strenght Domain Power";
            break;
        case FEAT_STRONGSOUL : sFeat = "Strong Soul";
            break;
        case FEAT_STUNNING_FIST : sFeat = "Stunning Fist";
            break;
        case FEAT_SUMMON_FAMILIAR : sFeat = "Summon Familiar";
            break;
        case FEAT_SUMMON_GREATER_UNDEAD : sFeat = "Summon Grater Undead";
            break;
        case FEAT_SUMMON_SHADOW : sFeat = "Summon Shadow";
            break;
        case FEAT_SUMMON_UNDEAD : sFeat = "Summon Undead";
            break;
        case FEAT_SUN_DOMAIN_POWER : sFeat = "Sun Domain Power";
            break;
        case FEAT_SUPERIOR_WEAPON_FOCUS : sFeat = "Superior Weapon Focus";
            break;
        case FEAT_THUG : sFeat = "Thug";
            break;
        case FEAT_TOUGH_AS_BONE : sFeat = "Tough As Bone";
            break;
        case FEAT_TOUGHNESS : sFeat = "Toughness";
            break;
        case FEAT_TRACKLESS_STEP : sFeat = "Trackless Step";
            break;
        case FEAT_TRAVEL_DOMAIN_POWER : sFeat = "Travel Domain Power";
            break;
        case FEAT_TRICKERY_DOMAIN_POWER : sFeat = "Trickery Domain Power";
            break;
        case FEAT_TURN_UNDEAD : sFeat = "Turn Undead";
            break;
        case FEAT_TWO_WEAPON_FIGHTING : sFeat = "Two Weapon Fighting";
            break;
        case FEAT_TYMORAS_SMILE : sFeat = "Tymoras Smile";
            break;
        case FEAT_UNCANNY_DODGE_1 : sFeat = "Uncanny Dodge 1";
            break;
        case FEAT_UNCANNY_DODGE_2 : sFeat = "Uncanny Dodge 2";
            break;
        case FEAT_UNCANNY_DODGE_3 : sFeat = "Uncanny Dodge 3";
            break;
        case FEAT_UNCANNY_DODGE_4 : sFeat = "Uncanny Dodge 4";
            break;
        case FEAT_UNCANNY_DODGE_5 : sFeat = "Uncanny Dodge 5";
            break;
        case FEAT_UNCANNY_DODGE_6 : sFeat = "Uncanny Dodge 6";
            break;
        case FEAT_UNDEAD_GRAFT_1 : sFeat = "Undead Graft 1";
            break;
        case FEAT_UNDEAD_GRAFT_2 : sFeat = "Undead Graft 2";
            break;
        case FEAT_USE_POISON : sFeat = "Use Poison";
            break;
        case FEAT_VENOM_IMMUNITY : sFeat = "Venom Immunity";
            break;
        case FEAT_WAR_DOMAIN_POWER : sFeat = "War Domain Power";
            break;
        case FEAT_WATER_DOMAIN_POWER : sFeat = "Water Domain Power";
            break;
        case FEAT_WEAPON_FINESSE : sFeat = "Wepaon Finesse";
            break;
        case FEAT_WEAPON_FOCUS_BASTARD_SWORD : sFeat = "Weapon Focus Bastard";
            break;
        case FEAT_WEAPON_FOCUS_BATTLE_AXE : sFeat = "Weapon Focus Battle Axe";
            break;
        case FEAT_WEAPON_FOCUS_CLUB : sFeat = "Weapon Focus Club";
            break;
        case FEAT_WEAPON_FOCUS_CREATURE : sFeat = "Weapon Focus Creature";
            break;
        case FEAT_WEAPON_FOCUS_DAGGER : sFeat = "Weapon Focus Dagger";
            break;
        case FEAT_WEAPON_FOCUS_DART : sFeat = "Weapon Focus Dart";
            break;
        case FEAT_WEAPON_FOCUS_DIRE_MACE : sFeat = "Weapon Focus Dire Mace";
            break;
        case FEAT_WEAPON_FOCUS_DOUBLE_AXE : sFeat = "Weapon Focus Double Axe";
            break;
        case FEAT_WEAPON_FOCUS_DWAXE : sFeat = "Weapon Focus Dwarfen Axe";
            break;
        case FEAT_WEAPON_FOCUS_GREAT_AXE : sFeat = "Weapon Focus Great Axe";
            break;
        case FEAT_WEAPON_FOCUS_GREAT_SWORD : sFeat = "Weapon Focus Great Sword";
            break;
        case FEAT_WEAPON_FOCUS_HALBERD : sFeat = "Weapon Focus Halberd";
            break;
        case FEAT_WEAPON_FOCUS_HAND_AXE : sFeat = "Weapon Focus Hand Axe";
            break;
        case FEAT_WEAPON_FOCUS_HEAVY_CROSSBOW : sFeat = "Weapon Focus Heavy Crossbow";
            break;
        case FEAT_WEAPON_FOCUS_HEAVY_FLAIL : sFeat = "Weapon Focus Heavy Flail";
            break;
        case FEAT_WEAPON_FOCUS_KAMA : sFeat = "Weapon Focus Kama";
            break;
        case FEAT_WEAPON_FOCUS_KATANA : sFeat = "Weapon Focus Katana";
            break;
        case FEAT_WEAPON_FOCUS_KUKRI : sFeat = "Weapon Focus Kukri";
            break;
        case FEAT_WEAPON_FOCUS_LIGHT_CROSSBOW : sFeat = "Weapon Focus Light Crossbow";
            break;
        case FEAT_WEAPON_FOCUS_LIGHT_FLAIL : sFeat = "Weapon Focus Light Flail";
            break;
        case FEAT_WEAPON_FOCUS_LIGHT_HAMMER : sFeat = "Weapon Focus Light Hammer";
            break;
        case FEAT_WEAPON_FOCUS_LIGHT_MACE : sFeat = "Weapon Focus Light Mace";
            break;
        case FEAT_WEAPON_FOCUS_LONG_SWORD : sFeat = "Weapon Focus Long Sword";
            break;
        case FEAT_WEAPON_FOCUS_LONGBOW : sFeat = "Weapon Focus Long Bow";
            break;
        case FEAT_WEAPON_FOCUS_MORNING_STAR : sFeat = "Weapon Focus Morning Star";
            break;
        case FEAT_WEAPON_FOCUS_RAPIER : sFeat = "Weapon Focus Rapier";
            break;
        case FEAT_WEAPON_FOCUS_SCIMITAR : sFeat = "Weapon Focus Scimitar";
            break;
        case FEAT_WEAPON_FOCUS_SCYTHE : sFeat = "Weapon Focus Scythe";
            break;
        case FEAT_WEAPON_FOCUS_SHORT_SWORD : sFeat = "Weapon Focus Short Sword";
            break;
        case FEAT_WEAPON_FOCUS_SHORTBOW : sFeat = "Weapon Focus Shortbow";
            break;
        case FEAT_WEAPON_FOCUS_SHURIKEN : sFeat = "Weapon Focus Shuriken";
            break;
        case FEAT_WEAPON_FOCUS_SICKLE : sFeat = "Weapon Focus Sickle";
            break;
        case FEAT_WEAPON_FOCUS_SLING : sFeat = "Weapon Focus Sling";
            break;
        case FEAT_WEAPON_FOCUS_SPEAR : sFeat = "Weapon Focus Spear";
            break;
        case FEAT_WEAPON_FOCUS_STAFF : sFeat = "Weapon Focus Staff";
            break;
        case FEAT_WEAPON_FOCUS_THROWING_AXE : sFeat = "Weapon Focus Throwing Axe";
            break;
        case FEAT_WEAPON_FOCUS_TWO_BLADED_SWORD : sFeat = "Weapon Focus Two Bladed Sword";
            break;
        case FEAT_WEAPON_FOCUS_UNARMED_STRIKE : sFeat = "Weapon Focus Unarmed Strike";
            break;
        case FEAT_WEAPON_FOCUS_WAR_HAMMER : sFeat = "Weapon Focus War Hammer";
            break;
        case FEAT_WEAPON_FOCUS_WHIP : sFeat = "Weapon Focus Whip";
            break;
        case FEAT_WEAPON_OF_CHOICE_BASTARDSWORD : sFeat = "Weapon Of Choice Bastard";
            break;
        case FEAT_WEAPON_OF_CHOICE_BATTLEAXE : sFeat = "Weapon Of Choice Battle Axe";
            break;
        case FEAT_WEAPON_OF_CHOICE_CLUB : sFeat = "Weapon Of Choice Club";
            break;
        case FEAT_WEAPON_OF_CHOICE_DAGGER : sFeat = "Weapon Of Choice Dagger";
            break;
        case FEAT_WEAPON_OF_CHOICE_DIREMACE : sFeat = "Weapon Of Choice Dire Mace";
            break;
        case FEAT_WEAPON_OF_CHOICE_DOUBLEAXE : sFeat = "Weapon Of Choice Double Axe";
            break;
        case FEAT_WEAPON_OF_CHOICE_DWAXE : sFeat = "Weapon Of Choice Dwarfen Axe";
            break;
        case FEAT_WEAPON_OF_CHOICE_GREATAXE : sFeat = "Weapon Of Choice Great Axe";
            break;
        case FEAT_WEAPON_OF_CHOICE_GREATSWORD : sFeat = "Weapon Of Choice Great Sword";
            break;
        case FEAT_WEAPON_OF_CHOICE_HALBERD : sFeat = "Weapon Of Choice Halberd";
            break;
        case FEAT_WEAPON_OF_CHOICE_HANDAXE : sFeat = "Weapon Of Choice Hand Axe";
            break;
        case FEAT_WEAPON_OF_CHOICE_HEAVYFLAIL : sFeat = "Weapon Of Choice Heavy Flail";
            break;
        case FEAT_WEAPON_OF_CHOICE_KAMA : sFeat = "Weapon Of Choice Kama";
            break;
        case FEAT_WEAPON_OF_CHOICE_KATANA : sFeat = "Weapon Of Choice Katana";
            break;
        case FEAT_WEAPON_OF_CHOICE_KUKRI : sFeat = "Weapon Of Choice Kukri";
            break;
        case FEAT_WEAPON_OF_CHOICE_LIGHTFLAIL : sFeat = "Weapon Of Choice Light Flail";
            break;
        case FEAT_WEAPON_OF_CHOICE_LIGHTHAMMER : sFeat = "Weapon Of Choice Light Hammer";
            break;
        case FEAT_WEAPON_OF_CHOICE_LIGHTMACE : sFeat = "Weapon Of Choice Light Mace";
            break;
        case FEAT_WEAPON_OF_CHOICE_LONGSWORD : sFeat = "Weapon Of Choice Long Sword";
            break;
        case FEAT_WEAPON_OF_CHOICE_MORNINGSTAR : sFeat = "Weapon Of Choice Morning Star";
            break;
        case FEAT_WEAPON_OF_CHOICE_RAPIER : sFeat = "Weapon Of Choice Rapier";
            break;
        case FEAT_WEAPON_OF_CHOICE_SCIMITAR : sFeat = "Weapon Of Choice Scimitar";
            break;
        case FEAT_WEAPON_OF_CHOICE_SCYTHE : sFeat = "Weapon Of Choice Scythe";
            break;
        case FEAT_WEAPON_OF_CHOICE_SHORTSWORD : sFeat = "Weapon Of Choice Short Sword";
            break;
        case FEAT_WEAPON_OF_CHOICE_SICKLE : sFeat = "Weapon Of Choice Sickle";
            break;
        case FEAT_WEAPON_OF_CHOICE_QUARTERSTAFF : sFeat = "Weapon Of Choice Staff";
            break;
        case FEAT_WEAPON_OF_CHOICE_SHORTSPEAR : sFeat = "Weapon Of Choice Short Spear";
            break;
        case FEAT_WEAPON_OF_CHOICE_TWOBLADEDSWORD : sFeat = "Weapon Of Choice Two Bladed Sword";
            break;
        case FEAT_WEAPON_OF_CHOICE_WARHAMMER : sFeat = "Weapon Of Choice War Hammer";
            break;
        case FEAT_WEAPON_OF_CHOICE_WHIP : sFeat = "Weapon Of Choice Whip";
            break;
        case FEAT_WEAPON_PROFICIENCY_CREATURE : sFeat = "Weapon Proficeny Creature";
            break;
        case FEAT_WEAPON_PROFICIENCY_DRUID : sFeat = "Weapon Proficeny Druid";
            break;
        case FEAT_WEAPON_PROFICIENCY_ELF : sFeat = "Weapon Proficeny Elf";
            break;
        case FEAT_WEAPON_PROFICIENCY_EXOTIC : sFeat = "Weapon Proficeny Exotic";
            break;
        case FEAT_WEAPON_PROFICIENCY_MARTIAL : sFeat = "Weapon Proficeny Martial";
            break;
        case FEAT_WEAPON_PROFICIENCY_MONK : sFeat = "Weapon Proficeny Monk";
            break;
        case FEAT_WEAPON_PROFICIENCY_ROGUE : sFeat = "Weapon Proficeny Rouge";
            break;
        case FEAT_WEAPON_PROFICIENCY_SIMPLE : sFeat = "Weapon Proficeny Simple";
            break;
        case FEAT_WEAPON_PROFICIENCY_WIZARD : sFeat = "Weapon Proficeny Wizard";
            break;
        case FEAT_WEAPON_SPECIALIZATION_BASTARD_SWORD : sFeat = "Weapon Specialization Bastard";
            break;
        case FEAT_WEAPON_SPECIALIZATION_BATTLE_AXE : sFeat = "Weapon Specialization Battle Axe";
            break;
        case FEAT_WEAPON_SPECIALIZATION_CLUB : sFeat = "Weapon Specialization Club";
            break;
        case FEAT_WEAPON_SPECIALIZATION_CREATURE : sFeat = "Weapon Specialization Creature";
            break;
        case FEAT_WEAPON_SPECIALIZATION_DAGGER : sFeat = "Weapon Specialization Dagger";
            break;
        case FEAT_WEAPON_SPECIALIZATION_DART : sFeat = "Weapon Specialization Dart";
            break;
        case FEAT_WEAPON_SPECIALIZATION_DIRE_MACE : sFeat = "Weapon Specialization Dire Mace";
            break;
        case FEAT_WEAPON_SPECIALIZATION_DOUBLE_AXE : sFeat = "Weapon Specialization Double Axe";
            break;
        case FEAT_WEAPON_SPECIALIZATION_DWAXE : sFeat = "Weapon Specialization Dwarfen Axe";
            break;
        case FEAT_WEAPON_SPECIALIZATION_GREAT_AXE : sFeat = "Weapon Specialization Great Axe";
            break;
        case FEAT_WEAPON_SPECIALIZATION_GREAT_SWORD : sFeat = "Weapon Specialization Great Sword";
            break;
        case FEAT_WEAPON_SPECIALIZATION_HALBERD : sFeat = "Weapon Specialization Halberd";
            break;
        case FEAT_WEAPON_SPECIALIZATION_HAND_AXE : sFeat = "Weapon Specialization Hand Axe";
            break;
        case FEAT_WEAPON_SPECIALIZATION_HEAVY_CROSSBOW : sFeat = "Weapon Specialization Heavy Crossbow";
            break;
        case FEAT_WEAPON_SPECIALIZATION_HEAVY_FLAIL : sFeat = "Weapon Specialization Heavy Flail";
            break;
        case FEAT_WEAPON_SPECIALIZATION_KAMA : sFeat = "Weapon Specialization Kama";
            break;
        case FEAT_WEAPON_SPECIALIZATION_KATANA : sFeat = "Weapon Specialization Katana";
            break;
        case FEAT_WEAPON_SPECIALIZATION_KUKRI : sFeat = "Weapon Specialization Kukri";
            break;
        case FEAT_WEAPON_SPECIALIZATION_LIGHT_CROSSBOW : sFeat = "Weapon Specialization Light Crossbow";
            break;
        case FEAT_WEAPON_SPECIALIZATION_LIGHT_FLAIL : sFeat = "Weapon Specialization Light Flail";
            break;
        case FEAT_WEAPON_SPECIALIZATION_LIGHT_HAMMER : sFeat = "Weapon Specialization Light Hammer";
            break;
        case FEAT_WEAPON_SPECIALIZATION_LIGHT_MACE : sFeat = "Weapon Specialization Light Mace";
            break;
        case FEAT_WEAPON_SPECIALIZATION_LONG_SWORD : sFeat = "Weapon Specialization Long Sword";
            break;
        case FEAT_WEAPON_SPECIALIZATION_LONGBOW : sFeat = "Weapon Specialization Long Bow";
            break;
        case FEAT_WEAPON_SPECIALIZATION_MORNING_STAR : sFeat = "Weapon Specialization Morning Star";
            break;
        case FEAT_WEAPON_SPECIALIZATION_RAPIER : sFeat = "Weapon Specialization Rapier";
            break;
        case FEAT_WEAPON_SPECIALIZATION_SCIMITAR : sFeat = "Weapon Specialization Scimitar";
            break;
        case FEAT_WEAPON_SPECIALIZATION_SCYTHE : sFeat = "Weapon Specialization Scythe";
            break;
        case FEAT_WEAPON_SPECIALIZATION_SHORT_SWORD : sFeat = "Weapon Specialization Short Sword";
            break;
        case FEAT_WEAPON_SPECIALIZATION_SHORTBOW : sFeat = "Weapon Specialization Shortbow";
            break;
        case FEAT_WEAPON_SPECIALIZATION_SHURIKEN : sFeat = "Weapon Specialization Shuriken";
            break;
        case FEAT_WEAPON_SPECIALIZATION_SICKLE : sFeat = "Weapon Specialization Sickle";
            break;
        case FEAT_WEAPON_SPECIALIZATION_SLING : sFeat = "Weapon Specialization Sling";
            break;
        case FEAT_WEAPON_SPECIALIZATION_SPEAR : sFeat = "Weapon Specialization Spear";
            break;
        case FEAT_WEAPON_SPECIALIZATION_STAFF : sFeat = "Weapon Specialization Staff";
            break;
        case FEAT_WEAPON_SPECIALIZATION_THROWING_AXE : sFeat = "Weapon Specialization Throwing Axe";
            break;
        case FEAT_WEAPON_SPECIALIZATION_TWO_BLADED_SWORD : sFeat = "Weapon Specialization Two Bladed Sword";
            break;
        case FEAT_WEAPON_SPECIALIZATION_UNARMED_STRIKE : sFeat = "Weapon Specialization Unarmed Strike";
            break;
        case FEAT_WEAPON_SPECIALIZATION_WAR_HAMMER : sFeat = "Weapon Specialization War Hammer";
            break;
        case FEAT_WEAPON_SPECIALIZATION_WHIP : sFeat = "Weapon Specialization Whip";
            break;
        case FEAT_WHIRLWIND_ATTACK : sFeat = "Whirlwind Attack";
            break;
        case FEAT_WHOLENESS_OF_BODY : sFeat = "Wholeness Of Body";
            break;
        case FEAT_WILD_SHAPE : sFeat = "Whild Shape";
            break;
        case FEAT_WOODLAND_STRIDE : sFeat = "Woodland Stride";
            break;
        case FEAT_ZEN_ARCHERY : sFeat = "Zen Archery";
            break;
        default :
            {
                if ( nFeat > 489 )
                {
                    sFeat = "Epic Feature " + IntToString ( nFeat );
                }else
                {
                    sFeat = "Unknown Feature " + IntToString ( nFeat );
                }
            }
    }
    return sFeat;

}
string SkillToString ( int nSkill )
{
    string sSkill;
    switch ( nSkill )
    {
        case SKILL_ANIMAL_EMPATHY : sSkill = "Animal Empathy";
            break;
        case SKILL_APPRAISE : sSkill = "Appraise";
            break;
        case SKILL_BLUFF : sSkill = "Bluff";
            break;
        case SKILL_CONCENTRATION : sSkill = "Concentration";
            break;
        case SKILL_CRAFT_ARMOR : sSkill = "Craft Armor";
            break;
        case SKILL_CRAFT_TRAP : sSkill = "Craft Trap";
            break;
        case SKILL_CRAFT_WEAPON : sSkill = "Craft Weapon";
            break;
        case SKILL_DISABLE_TRAP : sSkill = "Disable Trap";
            break;
        case SKILL_DISCIPLINE : sSkill = "Discipline";
            break;
        case SKILL_HEAL : sSkill = "Heal";
            break;
        case SKILL_HIDE : sSkill = "Hide";
            break;
        case SKILL_INTIMIDATE : sSkill = "Intimidate";
            break;
        case SKILL_LISTEN : sSkill = "Listen";
            break;
        case SKILL_LORE : sSkill = "Lore";
            break;
        case SKILL_MOVE_SILENTLY : sSkill = "Move Silently";
            break;
        case SKILL_OPEN_LOCK : sSkill = "Open Lock";
            break;
        case SKILL_PARRY : sSkill = "Parry";
            break;
        case SKILL_PERFORM : sSkill = "Perform";
            break;
        case SKILL_PERSUADE : sSkill = "Persuade";
            break;
        case SKILL_PICK_POCKET : sSkill = "Pick Pocket";
            break;
        case SKILL_SEARCH : sSkill = "Search";
            break;
        case SKILL_SET_TRAP : sSkill = "Set Trap";
            break;
        case SKILL_SPELLCRAFT : sSkill = "Spellcraft";
            break;
        case SKILL_SPOT : sSkill = "Spot";
            break;
        case SKILL_TAUNT : sSkill = "Taunt";
            break;
        case SKILL_TUMBLE : sSkill = "Tumble";
            break;
        case SKILL_USE_MAGIC_DEVICE : sSkill = "Use Magic Device";
            break;

        default : sSkill = "Unknown Type " + IntToString ( nSkill );
    }
    return sSkill;
}

string SpellToString ( int nSpellId )
{
    string sSpell;

    switch ( nSpellId )
    {
        case 0: sSpell = "Acid Fog";
        break;
        case 424: sSpell = "Acid Splash";
        break;
        case 1: sSpell = "Aid";
        break;
        case 442: sSpell = "Amplify";
        break;
        case 2: sSpell = "Animate Dead";
        break;
        case 429: sSpell = "Aura Of Glory";
        break;
        case 372: sSpell = "Aura of Vitality";
        break;
        case 323: sSpell = "Aura versus Alignment";
        break;
        case 363: sSpell = "Awaken";
        break;
        case 436: sSpell = "Balagarn's Iron Horn";
        break;
        case 516: sSpell = "Ball Lightning";
        break;
        case 449: sSpell = "Bane";
        break;
        case 430: sSpell = "Banishment";
        break;
        case 3: sSpell = "Barkskin";
        break;
        case 517: sSpell = "Battletide";
        break;
        case 4: sSpell = "Bestow Curse";
        break;
        case 459: sSpell = "Bigby's Interposing Hand";
        break;
        case 460: sSpell = "Bigby's Forceful Hand";
        break;
        case 461: sSpell = "Bigby's Grasping Hand";
        break;
        case 462: sSpell = "Bigby's Clenched Hand";
        break;
        case 463: sSpell = "Bigby's Crushing Hand";
        break;
        case 541: sSpell = "Blackstaff";
        break;
        case 533: sSpell = "Black Blade of Disaster";
        break;
        case 5: sSpell = "Blade Barrier";
        break;
        case 535: sSpell = "Blade Thirst";
        break;
        case 6: sSpell = "Bless";
        break;
        case 537: sSpell = "Bless Weapon";
        break;
        case 8: sSpell = "Blindness/Deafness";
        break;
        case 422: sSpell = "Blood Frenzy";
        break;
        case 423: sSpell = "Bombardment";
        break;
        case 9: sSpell = "Bull's Strength";
        break;
        case 360: sSpell = "Bull's Strength, Greater";
        break;
        case 10: sSpell = "Burning Hands";
        break;
        case 11: sSpell = "Call Lightning";
        break;
        case 421: sSpell = "Camoflauge";
        break;
        case 13: sSpell = "Cat's Grace";
        break;
        case 361: sSpell = "Cat's Grace, Greater";
        break;
        case 14: sSpell = "Chain Lightning";
        break;
        case 15: sSpell = "Charm Monster";
        break;
        case 16: sSpell = "Charm Person";
        break;
        case 17: sSpell = "Charm Person or Animal";
        break;
        case 18: sSpell = "Circle of Death";
        break;
        case 19: sSpell = "Circle of Doom";
        break;
        case 20: sSpell = "Clairaudience/Clairvoyance";
        break;
        case 21: sSpell = "Clarity";
        break;
        case 23: sSpell = "Cloudkill";
        break;
        case 569: sSpell = "Cloud of Bewilderment";
        break;
        case 24: sSpell = "Color Spray";
        break;
        case 518: sSpell = "Combust";
        break;
        case 26: sSpell = "Confusion";
        break;
        case 25: sSpell = "Cone of Cold";
        break;
        case 27: sSpell = "Contagion";
        break;
        case 419: sSpell = "Continual Flame";
        break;
        case 28: sSpell = "Control Undead";
        break;
        case 29: sSpell = "Create Greater Undead";
        break;
        case 30: sSpell = "Create Undead";
        break;
        case 364: sSpell = "Creeping Doom";
        break;
        case 512: sSpell = "Crumble";
        break;
        case 31: sSpell = "Cure Critical Wounds";
        break;
        case 32: sSpell = "Cure Light Wounds";
        break;
        case 33: sSpell = "Cure Minor Wounds";
        break;
        case 34: sSpell = "Cure Moderate Wounds";
        break;
        case 35: sSpell = "Cure Serious Wounds";
        break;
        case 548: sSpell = "Darkfire";
        break;
        case 36: sSpell = "Darkness";
        break;
        case 37: sSpell = "Daze";
        break;
        case 536: sSpell = "Deafening Clang";
        break;
        case 519: sSpell = "Death Armor";
        break;
        case 383: sSpell = "Death Domain, Negative Plane Avatar";
        break;
        case 38: sSpell = "Death Ward";
        break;
        case 39: sSpell = "Delayed Blast Fireball";
        break;
        case 366: sSpell = "Destruction";
        break;
        case 445: sSpell = "Dirge";
        break;
        case 40: sSpell = "Dismissal";
        break;
        case 41: sSpell = "Dispel Magic";
        break;
        case 67: sSpell = "Dispelling, Greater";
        break;
        case 94: sSpell = "Dispel, Lesser";
        break;
        case 458: sSpell = "Displacement";
        break;
        case 414: sSpell = "Divine Favor";
        break;
        case 42: sSpell = "Divine Power";
        break;
        case 43: sSpell = "Dominate Animal";
        break;
        case 44: sSpell = "Dominate Monster";
        break;
        case 45: sSpell = "Dominate Person";
        break;
        case 46: sSpell = "Doom";
        break;
        case 437: sSpell = "Drown";
        break;
        case 354: sSpell = "Eagle's Splendor";
        break;
        case 357: sSpell = "Eagle's Splendor, Greater";
        break;
        case 426: sSpell = "Earthquake";
        break;
        case 439: sSpell = "Electric Jolt";
        break;
        case 47: sSpell = "Elemental Shield";
        break;
        case 48: sSpell = "Elemental Swarm";
        break;
        case 49: sSpell = "Endurance";
        break;
        case 362: sSpell = "Endurance, Greater";
        break;
        case 50: sSpell = "Endure Elements";
        break;
        case 369: sSpell = "Energy Buffer";
        break;
        case 51: sSpell = "Energy Drain";
        break;
        case 52: sSpell = "Enervation";
        break;
        case 53: sSpell = "Entangle";
        break;
        case 418: sSpell = "Entropic Shield";
        break;
        case 121: sSpell = "Ethereal Visage";
        break;
        case 375: sSpell = "Evard's Black Tentacles";
        break;
        case 456: sSpell = "Expeditious Retreat";
        break;
        case 54: sSpell = "Fear";
        break;
        case 55: sSpell = "Feeblemind";
        break;
        case 377: sSpell = "Find Traps";
        break;
        case 56: sSpell = "Finger of Death";
        break;
        case 58: sSpell = "Fireball";
        break;
        case 440: sSpell = "Firebrand";
        break;
        case 57: sSpell = "Fire Storm";
        break;
        case 59: sSpell = "Flame Arrow";
        break;
        case 60: sSpell = "Flame Lash";
        break;
        case 61: sSpell = "Flame Strike";
        break;
        case 542: sSpell = "Flame Weapon";
        break;
        case 416: sSpell = "Flare";
        break;
        case 485: sSpell = "Flesh To Stone";
        break;
        case 356: sSpell = "Fox's Cunning";
        break;
        case 359: sSpell = "Fox's Cunning, Greater";
        break;
        case 62: sSpell = "Freedom of Movement";
        break;
        case 63: sSpell = "Gate";
        break;
        case 520: sSpell = "Gedlee's Electric Loop";
        break;
        case 120: sSpell = "Ghostly Visage";
        break;
        case 64: sSpell = "Ghoul Touch";
        break;
        case 65: sSpell = "Globe Of Invulnerability";
        break;
        case 549: sSpell = "Glyph of Warding";
        break;
        case 66: sSpell = "Grease";
        break;
        case 453: sSpell = "Greater Magic Fang";
        break;
        case 545: sSpell = "Greater Magic Weapon";
        break;
        case 443: sSpell = "Greater Sanctuary/Etherealness";
        break;
        case 515: sSpell = "Great Thunderclap";
        break;
        case 75: sSpell = "Gust of Wind";
        break;
        case 76: sSpell = "Hammer of The Gods";
        break;
        case 77: sSpell = "Harm";
        break;
        case 78: sSpell = "Haste";
        break;
        case 79: sSpell = "Heal";
        break;
        case 80: sSpell = "Healing Circle";
        break;
        case 514: sSpell = "Healing Sting";
        break;
        case 81: sSpell = "Hold Animal";
        break;
        case 82: sSpell = "Hold Monster";
        break;
        case 83: sSpell = "Hold Person";
        break;
        case 538: sSpell = "Holy Sword";
        break;
        case 521: sSpell = "Horizikaul's Boom";
        break;
        case 367: sSpell = "Horrid Wilting";
        break;
        case 543: sSpell = "Ice Dagger";
        break;
        case 368: sSpell = "Ice Storm";
        break;
        case 86: sSpell = "Identify";
        break;
        case 87: sSpell = "Implosion";
        break;
        case 88: sSpell = "Improved Invisibility";
        break;
        case 89: sSpell = "Incendiary Cloud";
        break;
        case 446: sSpell = "Inferno";
        break;
        case 513: sSpell = "Infestation of Maggots";
        break;
        case 431: sSpell = "Inflict Minor Wounds";
        break;
        case 432: sSpell = "Inflict Light Wounds";
        break;
        case 433: sSpell = "Inflict Moderate Wounds";
        break;
        case 434: sSpell = "Inflict Serious Wounds";
        break;
        case 435: sSpell = "Inflict Critical Wounds";
        break;
        case 90: sSpell = "Invisibility";
        break;
        case 91: sSpell = "Invisibility Purge";
        break;
        case 92: sSpell = "Invisibility Sphere";
        break;
        case 522: sSpell = "Ironguts";
        break;
        case 447: sSpell = "Isaac's Lesser Missile Storm";
        break;
        case 448: sSpell = "Isaac's Greater Missile Storm";
        break;
        case 539: sSpell = "Keen Edge";
        break;
        case 93: sSpell = "Knock";
        break;
        case 376: sSpell = "Legend Lore";
        break;
        case 100: sSpell = "Light";
        break;
        case 101: sSpell = "Lightning Bolt";
        break;
        case 102: sSpell = "Mage Armor";
        break;
        case 322: sSpell = "Magic Circle Against Alignment";
        break;
        case 452: sSpell = "Magic Fang";
        break;
        case 107: sSpell = "Magic Missile";
        break;
        case 546: sSpell = "Magic Vestment";
        break;
        case 544: sSpell = "Magic Weapon";
        break;
        case 110: sSpell = "Mass Blindness/Deafness";
        break;
        case 455: sSpell = "Mass Camoflauge";
        break;
        case 111: sSpell = "Mass Charm";
        break;
        case 113: sSpell = "Mass Haste";
        break;
        case 114: sSpell = "Mass Heal";
        break;
        case 115: sSpell = "Melf's Acid Arrow";
        break;
        case 523: sSpell = "Mestil's Acid Breath";
        break;
        case 524: sSpell = "Mestil's Acid Sheath";
        break;
        case 116: sSpell = "Meteor Swarm";
        break;
        case 117: sSpell = "Mind Blank";
        break;
        case 95: sSpell = "Mind Blank, Lesser";
        break;
        case 118: sSpell = "Mind Fog";
        break;
        case 119: sSpell = "Minor Globe of Invulnerability";
        break;
        case 525: sSpell = "Monstrous Regeneration";
        break;
        case 122: sSpell = "Mordenkainen's Disjunction";
        break;
        case 123: sSpell = "Mordenkainen's Sword";
        break;
        case 124: sSpell = "Nature's Balance";
        break;
        case 370: sSpell = "Negative Energy Burst";
        break;
        case 125: sSpell = "Negative Energy Protection";
        break;
        case 371: sSpell = "Negative Energy Ray";
        break;
        case 126: sSpell = "Neutralize Poison";
        break;
        case 420: sSpell = "One With The Land";
        break;
        case 438: sSpell = "Owl's Insight";
        break;
        case 355: sSpell = "Owl's Wisdom";
        break;
        case 358: sSpell = "Owl's Wisdom, Greater";
        break;
        case 127: sSpell = "Phantasmal Killer";
        break;
        case 451: sSpell = "Planar Ally";
        break;
        case 128: sSpell = "Planar Binding";
        break;
        case 69: sSpell = "Planar Binding, Greater";
        break;
        case 96: sSpell = "Planar Binding, Lesser";
        break;
        case 129: sSpell = "Poison";
        break;
        case 130: sSpell = "Polymorph Self";
        break;
        case 131: sSpell = "Power Word, Kill";
        break;
        case 132: sSpell = "Power Word, Stun";
        break;
        case 133: sSpell = "Prayer";
        break;
        case 134: sSpell = "Premonition";
        break;
        case 135: sSpell = "Prismatic Spray";
        break;
        case 382: sSpell = "Protection Domain, Divine Protection";
        break;
        case 321: sSpell = "Protection from Alignment";
        break;
        case 138: sSpell = "Protection from Alignment Good";
        break;
        case 139: sSpell = "Protection from Alignment Evil";
        break;
        case 137: sSpell = "Protection from Elements";
        break;
        case 141: sSpell = "Protection from Spells";
        break;
        case 425: sSpell = "Quillfire";
        break;
        case 142: sSpell = "Raise Dead";
        break;
        case 143: sSpell = "Ray of Enfeeblement";
        break;
        case 144: sSpell = "Ray of Frost";
        break;
        case 374: sSpell = "Regenerate";
        break;
        case 145: sSpell = "Remove Blindness/Deafness";
        break;
        case 146: sSpell = "Remove Curse";
        break;
        case 147: sSpell = "Remove Disease";
        break;
        case 148: sSpell = "Remove Fear";
        break;
        case 149: sSpell = "Remove Paralysis";
        break;
        case 150: sSpell = "Resist Elements";
        break;
        case 151: sSpell = "Resistance";
        break;
        case 152: sSpell = "Restoration";
        break;
        case 70: sSpell = "Restoration, Greater";
        break;
        case 97: sSpell = "Restoration, Lesser";
        break;
        case 153: sSpell = "Resurrection";
        break;
        case 385: sSpell = "Rogue's Cunning";
        break;
        case 154: sSpell = "Sanctuary";
        break;
        case 155: sSpell = "Scare";
        break;
        case 526: sSpell = "Scintillating Sphere";
        break;
        case 156: sSpell = "Searing Light";
        break;
        case 157: sSpell = "See Invisibility";
        break;
        case 158: sSpell = "Shades";
        break;
        case 159: sSpell = "Shadow Conjuration";
        break;
        case 71: sSpell = "Shadow Conjuration, Greater";
        break;
        case 160: sSpell = "Shadow Shield";
        break;
        case 161: sSpell = "Shapechange";
        break;
        case 534: sSpell = "Shelgarns Persistant Blade";
        break;
        case 417: sSpell = "Shield";
        break;
        case 450: sSpell = "Shield of Faith";
        break;
        case 163: sSpell = "Silence";
        break;
        case 164: sSpell = "Slay Living";
        break;
        case 165: sSpell = "Sleep";
        break;
        case 166: sSpell = "Slow";
        break;
        case 167: sSpell = "Sound Burst";
        break;
        case 72: sSpell = "Spell Breach, Greater";
        break;
        case 98: sSpell = "Spell Breach, Lesser";
        break;
        case 169: sSpell = "Spell Mantle";
        break;
        case 73: sSpell = "Spell Mantle, Greater";
        break;
        case 99: sSpell = "Spell Mantle, Lesser";
        break;
        case 168: sSpell = "Spell Resistance";
        break;
        case 454: sSpell = "Spike Growth";
        break;
        case 171: sSpell = "Stinking Cloud";
        break;
        case 547: sSpell = "Stonehold";
        break;
        case 172: sSpell = "Stoneskin";
        break;
        case 74: sSpell = "Stoneskin, Greater";
        break;
        case 527: sSpell = "Stone Bones";
        break;
        case 486: sSpell = "Stone To Flesh";
        break;
        case 173: sSpell = "Storm of Vengeance";
        break;
        case 381: sSpell = "Strength Domain, Divine Strength";
        break;
        case 379: sSpell = "Summon Celestial";
        break;
        case 174: sSpell = "Summon Creature I";
        break;
        case 175: sSpell = "Summon Creature II";
        break;
        case 176: sSpell = "Summon Creature III";
        break;
        case 177: sSpell = "Summon Creature IV";
        break;
        case 179: sSpell = "Summon Creature V";
        break;
        case 180: sSpell = "Summon Creature VI";
        break;
        case 181: sSpell = "Summon Creature VII";
        break;
        case 182: sSpell = "Summon Creature VIII";
        break;
        case 178: sSpell = "Summon Creature,IX";
        break;
        case 378: sSpell = "Summon Mephit";
        break;
        case 183: sSpell = "Sunbeam";
        break;
        case 427: sSpell = "Sunburst";
        break;
        case 457: sSpell = "Tasha's Hideous Laughter";
        break;
        case 184: sSpell = "Tenser's Transformation";
        break;
        case 185: sSpell = "Time Stop";
        break;
        case 384: sSpell = "Trickery Domain, Divine Trickery";
        break;
        case 186: sSpell = "True Seeing";
        break;
        case 415: sSpell = "True Strike";
        break;
        case 365: sSpell = "Ultravision";
        break;
        case 444: sSpell = "Undeath's Eternal Foe";
        break;
        case 528: sSpell = "Undeath to Death";
        break;
        case 188: sSpell = "Vampiric Touch";
        break;
        case 529: sSpell = "Vine Mine";
        break;
        case 189: sSpell = "Virtue";
        break;
        case 190: sSpell = "Wail of the Banshee";
        break;
        case 191: sSpell = "Wall of Fire";
        break;
        case 373: sSpell = "War Cry";
        break;
        case 380: sSpell = "War Domain, Battle Mastery";
        break;
        case 192: sSpell = "Web";
        break;
        case 193: sSpell = "Weird";
        break;
        case 194: sSpell = "Word of Faith";
        break;
        case 441: sSpell = "Wounding Whispers";
        break;
        default: sSpell = "Unknown Spell " + IntToString ( nSpellId );
    }

    return sSpell;
}


string CreatureSizeToString ( int nSize )
{
    string sSize = "unknown";
    switch ( nSize )
    {
        case ( CREATURE_SIZE_HUGE ) : sSize = "huge";
            break;
        case ( CREATURE_SIZE_LARGE ) : sSize = "large";
            break;
        case ( CREATURE_SIZE_MEDIUM ) : sSize = "medium";
            break;
        case ( CREATURE_SIZE_SMALL ) : sSize = "small";
            break;
        case ( CREATURE_SIZE_TINY ) : sSize = "tiny";
            break;
        default: sSize = "invalid";
    }
    return sSize;
}
