//nwk_polymorph
#include "nwk_const_teams"


const int NWK_POLYMORPH_TYPE_SILVER_DRAGON= 200;  //original hide
const int NWK_POLYMORPH_TYPE_GOLD_DRAGON= 201;   //original hide
const int NWK_POLYMORPH_TYPE_RED_DRAGON= 208;    //original hide


const int NWK_POLYMORPH_TYPE_FIRE_GIANT = 209; //original hide
const int NWK_POLYMORPH_TYPE_BALOR= 210;
const int NWK_POLYMORPH_TYPE_DEATH_SLAAD = 211;
const int NWK_POLYMORPH_TYPE_IRON_GOLEM  = 212;

const int  NWK_POLYMORPH_TYPE_HUGE_FIRE_ELEMENTAL = 213 ;
const int  NWK_POLYMORPH_TYPE_HUGE_WATER_ELEMENTAL = 214 ;
const int  NWK_POLYMORPH_TYPE_HUGE_EARTH_ELEMENTAL   = 215 ;
const int  NWK_POLYMORPH_TYPE_HUGE_AIR_ELEMENTAL  = 216 ;
const int  NWK_POLYMORPH_TYPE_ELDER_FIRE_ELEMENTAL = 217 ;
const int  NWK_POLYMORPH_TYPE_ELDER_WATER_ELEMENTAL  = 218 ;
const int  NWK_POLYMORPH_TYPE_ELDER_EARTH_ELEMENTAL  = 219 ;
const int  NWK_POLYMORPH_TYPE_ELDER_AIR_ELEMENTAL = 220 ;


/** return the NWK_POLYMOPRH_TYPE_* for the dragon color
    according to his team (SILVER/GOLD or RED if it is neutral
*/
int getDragonPolymorphConstAccordingToTeam(object oPC);

/** checks if oPC have a monk level . If so , add a property to the ARMOUR slot
    usually it will be an invisible hide. (at least on all polymorphs)
    If the monk do not have such item , it will not do anything
    ATTENTION: call it only after the monk had poolymorphed , otherwise it will
    work on it`s own regular armor and may not be transfered to the polymorphed shape.
*/
void addACDecreaseIfPCIsMonk(object oPC) ;

void addStandardNonLivingAbilities(object oHide);

void addAbilitiesToHideForBalor(object oHide);
void addAbilitiesToHideForDeathSlaad(object oHide) ;
void addSpecificAbilitiesForIronGolem(object oHide)  ;
void addSpecificAbilitiesForFireElemetal(object oHide);
void addSpecificAbilitiesForWaterElemetal(object oHide);
void addSpecificAbilitiesForEarthAndAirElemetal(object oHide);



/**
 * adds special abilites to the hide of the oPC , according to the
 * polymorph type.
 * Attention : must be called AFTER the oPC has the polymorph effect , and make
 * sure the oPC has a hide on him , even the empty hide is ok.
 * returns: 0 on success , negative on failuare (there is no hide)
 */
int addPolymoprhAbilitiesToPC(object oPC,int nwkPolymprphType)
{
    object oHide = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);
    if (oHide == OBJECT_INVALID)
        return -1;

//IP_CONST_IMMUNITYMISC_BACKSTAB IP_CONST_IMMUNITYMISC_CRITICAL_HITS
//IP_CONST_IMMUNITYMISC_KNOCKDOWN IP_CONST_IMMUNITYMISC_POISON


    switch (nwkPolymprphType)
    {
    case NWK_POLYMORPH_TYPE_BALOR:
        addAbilitiesToHideForBalor(oHide);
        break;

    case NWK_POLYMORPH_TYPE_DEATH_SLAAD:
        addAbilitiesToHideForDeathSlaad(oHide);
        break;

    case NWK_POLYMORPH_TYPE_IRON_GOLEM:
        addStandardNonLivingAbilities(oHide) ;
        addSpecificAbilitiesForIronGolem(oHide);
        break;

    case NWK_POLYMORPH_TYPE_HUGE_FIRE_ELEMENTAL:
    case NWK_POLYMORPH_TYPE_ELDER_FIRE_ELEMENTAL:
        addStandardNonLivingAbilities(oHide) ;
        addSpecificAbilitiesForFireElemetal(oHide);
        break;

    case NWK_POLYMORPH_TYPE_HUGE_WATER_ELEMENTAL:
    case NWK_POLYMORPH_TYPE_ELDER_WATER_ELEMENTAL:
        addStandardNonLivingAbilities(oHide) ;
        addSpecificAbilitiesForWaterElemetal(oHide);
        break;

    case NWK_POLYMORPH_TYPE_HUGE_EARTH_ELEMENTAL:
    case NWK_POLYMORPH_TYPE_HUGE_AIR_ELEMENTAL:
    case NWK_POLYMORPH_TYPE_ELDER_EARTH_ELEMENTAL:
    case NWK_POLYMORPH_TYPE_ELDER_AIR_ELEMENTAL:
        addStandardNonLivingAbilities(oHide) ;
        addSpecificAbilitiesForEarthAndAirElemetal(oHide);
        break ;






    }//end of switch-case





  return 0;
 }

/**
1 [*** DELETED Damage Soak +3/30 ***]
2 Damage Resistance: Acid Resist 20 / -
3 Damage Resistance: Cold Resist 20 / -
4 Damage Resistance: Fire Resist 20 / -
5 Immunity: Damage Type: Electrical 100% Immunity Bonus
6 Immunity: Miscellaneous: Poison
7 Immunity: Miscellaneous: Knowckdown [***NEW***]
*/
void addAbilitiesToHideForBalor(object oHide)
{
/*1*/ //deleted

/*2*/    AddItemProperty( DURATION_TYPE_PERMANENT,
                     ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,
                                                  IP_CONST_DAMAGERESIST_20),
                     oHide,
                     0.0
                    );

/*3*/    AddItemProperty( DURATION_TYPE_PERMANENT,
                     ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD,
                                                  IP_CONST_DAMAGERESIST_20),
                     oHide,
                     0.0
                    );
/*4*/    AddItemProperty( DURATION_TYPE_PERMANENT,
                     ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,
                                                  IP_CONST_DAMAGERESIST_20),
                     oHide,
                     0.0
                    );


/*5*/AddItemProperty( DURATION_TYPE_PERMANENT,
                     ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_ELECTRICAL,
                                                IP_CONST_DAMAGEIMMUNITY_100_PERCENT),
                     oHide,
                     0.0
                    );
/*6*/ AddItemProperty( DURATION_TYPE_PERMANENT,
                     ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_POISON),
                     oHide,
                     0.0
                    );


/*7*/ AddItemProperty( DURATION_TYPE_PERMANENT,
                     ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_KNOCKDOWN),
                     oHide,
                     0.0
                    );

/*8*/ AddItemProperty ( DURATION_TYPE_PERMANENT,
                      ItemPropertyOnHitCastSpell (IP_CONST_ONHIT_CASTSPELL_ACTIVATE_ITEM, 1 ),
                      oHide );

}



/**
Death Slaad
abilities: (STR,CONS,DEX,NATUAL_AC_BONUS,HP) 24 24 36 10 0(*UPDATED*)
1 [*** DELETED * Damage Reduction: +2 Soak 20 Damage***]
2 Damage Resistance: Acid Resist 5 / -
3 Damage Resistance: Cold Resist 5 / -
4 Damage Resistance: Electrical Resist 5 / -
5 Damage Resistance: Fire Resist 5 / -
6 Damage Resistance: Sonic Resist 5 / -
7 Regeneration +5
8 Immunity: Miscellaneous: Knowckdown [***NEW***]
*/
void addAbilitiesToHideForDeathSlaad(object oHide)
{
/*1*/ //deleted
/*2*/    AddItemProperty( DURATION_TYPE_PERMANENT,
                     ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ACID,
                                                  IP_CONST_DAMAGERESIST_5),
                     oHide,
                     0.0
                    );

/*3*/    AddItemProperty( DURATION_TYPE_PERMANENT,
                     ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_COLD,
                                                  IP_CONST_DAMAGERESIST_5),
                     oHide,
                     0.0
                    );

/*4*/    AddItemProperty( DURATION_TYPE_PERMANENT,
                     ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_ELECTRICAL,
                                                  IP_CONST_DAMAGERESIST_5),
                     oHide,
                     0.0
                    );



/*5*/    AddItemProperty( DURATION_TYPE_PERMANENT,
                     ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_FIRE,
                                                  IP_CONST_DAMAGERESIST_5),
                     oHide,
                     0.0
                    );
/*6*/    AddItemProperty( DURATION_TYPE_PERMANENT,
                     ItemPropertyDamageResistance(IP_CONST_DAMAGETYPE_SONIC,
                                                  IP_CONST_DAMAGERESIST_5),
                     oHide,
                     0.0
                    );
/*7*/    AddItemProperty( DURATION_TYPE_PERMANENT,
                     ItemPropertyRegeneration(5),
                     oHide,
                     0.0
                    );

/*8*/ AddItemProperty( DURATION_TYPE_PERMANENT,
                     ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_KNOCKDOWN),
                     oHide,
                     0.0
                    );
/*9*/AddItemProperty ( DURATION_TYPE_PERMANENT,
                      ItemPropertyOnHitCastSpell (IP_CONST_ONHIT_CASTSPELL_ACTIVATE_ITEM, 1 ),
                      oHide );

}

/**
0 DELETED * Damage Reduction: +3 Soak 30 Damage
1 Damage Vulnerability: Electrical 50% Damage Vulnerability
2 Immunity: Miscellaneous: Critical Hits
3 Immunity: Miscellaneous: Death Magic
4 Immunity: Miscellaneous: Disease
5 Immunity: Miscellaneous: Level/Ability Drain
6 Immunity: Miscellaneous: Mind-Affecting Spells
7 Immunity: Miscellaneous: Paralysis
8 Immunity: Miscellaneous: Poison
9 Immunity: Miscellaneous: Sneak Attack
10 Immunity: Miscellaneous: Knowckdown [***NEW***]
*/
void addSpecificAbilitiesForIronGolem(object oHide)
{
    /** 2,4,6,7,8,9 already done in StandardNonLivingAbilitie */
    /*0 was deleted*/

/*1*/  AddItemProperty( DURATION_TYPE_PERMANENT,
                     ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_ELECTRICAL,
                                                    IP_CONST_DAMAGEVULNERABILITY_50_PERCENT),

                     oHide,
                     0.0
                    );
/*3*/
      AddItemProperty( DURATION_TYPE_PERMANENT,
                     ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_DEATH_MAGIC),
                     oHide,
                     0.0
                    );
/*5*/  AddItemProperty( DURATION_TYPE_PERMANENT,
                     ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_LEVEL_ABIL_DRAIN),
                     oHide,
                     0.0
                    );
/*10*/ AddItemProperty( DURATION_TYPE_PERMANENT,
                     ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_KNOCKDOWN),
                     oHide,
                     0.0
                    );
/*11*/ AddItemProperty ( DURATION_TYPE_PERMANENT,
                      ItemPropertyOnHitCastSpell (IP_CONST_ONHIT_CASTSPELL_ACTIVATE_ITEM, 1 ),
                      oHide );


}


/**
1 Damage Vulnerability: Cold 50% Damage Vulnerability
2 Immunity: Damage Type: Fire 100% Immunity Bonus
3 KD immunity
*/
void addSpecificAbilitiesForFireElemetal(object oHide)
{
/*1*/  AddItemProperty( DURATION_TYPE_PERMANENT,
                     ItemPropertyDamageVulnerability(IP_CONST_DAMAGETYPE_COLD,
                                                    IP_CONST_DAMAGEVULNERABILITY_50_PERCENT),

                     oHide,
                     0.0
                    );
/*2*/ AddItemProperty( DURATION_TYPE_PERMANENT,
                  ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_FIRE,
                                             IP_CONST_DAMAGEIMMUNITY_100_PERCENT),
                     oHide,
                     0.0
                    );
/*3*/ AddItemProperty( DURATION_TYPE_PERMANENT,
                     ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_KNOCKDOWN),
                     oHide,
                     0.0
                    );
/*4*/AddItemProperty ( DURATION_TYPE_PERMANENT,
                      ItemPropertyOnHitCastSpell (IP_CONST_ONHIT_CASTSPELL_ACTIVATE_ITEM, 1 ),
                      oHide );

}

/**
1 Immunity: Damage Type: Fire 100% Immunity Bonus
2 Immunity to KD
*/
void addSpecificAbilitiesForWaterElemetal(object oHide)
{
/*1*/ AddItemProperty( DURATION_TYPE_PERMANENT,
                  ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_FIRE,
                                             IP_CONST_DAMAGEIMMUNITY_100_PERCENT),
                     oHide,
                     0.0
                    );
/*2*/ AddItemProperty( DURATION_TYPE_PERMANENT,
                     ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_KNOCKDOWN),
                     oHide,
                     0.0
                    );
/*3*/AddItemProperty ( DURATION_TYPE_PERMANENT,
                      ItemPropertyOnHitCastSpell (IP_CONST_ONHIT_CASTSPELL_ACTIVATE_ITEM, 1 ),
                      oHide );
}

/**
1 Immunity to KD
*/
void addSpecificAbilitiesForEarthAndAirElemetal(object oHide)
{
/*1*/ AddItemProperty( DURATION_TYPE_PERMANENT,
                     ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_KNOCKDOWN),
                     oHide,
                     0.0
                    );
/*2*/AddItemProperty ( DURATION_TYPE_PERMANENT,
                      ItemPropertyOnHitCastSpell (IP_CONST_ONHIT_CASTSPELL_ACTIVATE_ITEM, 1 ),
                      oHide );

}






/** used for golems,elementals
the list contains: (note death-magic immunity is NOT is the list.
1 Immunity: Miscellaneous: Critical Hits
2 Immunity: Miscellaneous: Disease
3 Immunity: Miscellaneous: Mind-Affecting Spells
4 Immunity: Miscellaneous: Paralysis
5 Immunity: Miscellaneous: Poison
6 Immunity: Miscellaneous: Sneak Attack
*/
void addStandardNonLivingAbilities(object oHide)
{
/*1*/  AddItemProperty( DURATION_TYPE_PERMANENT,
                     ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_CRITICAL_HITS),
                     oHide,
                     0.0
                    );
/*2*/AddItemProperty( DURATION_TYPE_PERMANENT,
                     ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_DISEASE),
                     oHide,
                     0.0
                    );
/*3*/AddItemProperty( DURATION_TYPE_PERMANENT,
                     ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_MINDSPELLS),
                     oHide,
                     0.0
                    );
/*4*/AddItemProperty( DURATION_TYPE_PERMANENT,
                     ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_PARALYSIS),
                     oHide,
                     0.0
                    );
/*5*/AddItemProperty( DURATION_TYPE_PERMANENT,
                     ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_POISON),
                     oHide,
                     0.0
                    );
/*6*/AddItemProperty( DURATION_TYPE_PERMANENT,
                     ItemPropertyImmunityMisc(IP_CONST_IMMUNITYMISC_BACKSTAB),
                     oHide,
                     0.0
                    );
/*7*/AddItemProperty ( DURATION_TYPE_PERMANENT,
                      ItemPropertyOnHitCastSpell (IP_CONST_ONHIT_CASTSPELL_ACTIVATE_ITEM, 1 ),
                      oHide );
}
















/** return the NWK_POLYMOPRH_TYPE_* for the dragon color
    according to his team (SILVER/GOLD or RED if it is neutral
*/
int getDragonPolymorphConstAccordingToTeam(object oPC)
{
    int dragonPolyConst;
    int teamInt = getTeamIntByPC(oPC);
    if (teamInt == TEAM_SILVER)
        dragonPolyConst=NWK_POLYMORPH_TYPE_SILVER_DRAGON;
    else if (teamInt == TEAM_GOLD)
        dragonPolyConst=NWK_POLYMORPH_TYPE_GOLD_DRAGON;
    else
        dragonPolyConst=NWK_POLYMORPH_TYPE_RED_DRAGON;

    return dragonPolyConst;
}







/** checks if oPC have a monk level . If so , add a property to the ARMOUR slot
    usually it will be an invisible hide. (at least on all polymorphs)
    If the monk do not have such item , it will not do anything
    ATTENTION: call it only after the monk had poolymorphed , otherwise it will
    work on it`s own regular armor and may not be transfered to the polymorphed shape.
*/
void addACDecreaseIfPCIsMonk(object oPC)
{
    if (GetLevelByClass(CLASS_TYPE_MONK, oPC) <= 0)
        return;

    object oMonkHide = GetItemInSlot(INVENTORY_SLOT_CARMOUR,oPC);
    if (oMonkHide == OBJECT_INVALID)
    {
        //log output to see how often and in which shape it happens

        WriteTimestampedLogEntry ( "nwk_polymorh::addACDecreaseIfPCIsMonk | no hide found for player : " +GetName (oPC));
        WriteTimestampedLogEntry ( "nwk_polymorh::addACDecreaseIfPCIsMonk | SpellID : " + IntToString (GetSpellId()));

        return; //what can we do ? the monk eluded us again
    }

    //the monk ac bonus is according to the wisdom
    //ac decrease on one item can be 5 at max . so loop and create several
    itemproperty ipAcDecrease;
    int monkAcBonus = GetAbilityModifier(ABILITY_WISDOM,oPC);
    if ( monkAcBonus <= 0)//dont waste calculations
        return;

    int nCurrentACDecrease ;
    if ( monkAcBonus >=5 )
    {
        nCurrentACDecrease=5;
    }
    else
    {
        nCurrentACDecrease = monkAcBonus;
    }

    ipAcDecrease = ItemPropertyDecreaseAC(IP_CONST_ACMODIFIERTYPE_NATURAL,
                                        nCurrentACDecrease);
    AddItemProperty( DURATION_TYPE_PERMANENT,
                   ipAcDecrease,
                   oMonkHide
                  );

    monkAcBonus -=nCurrentACDecrease;
    if ( monkAcBonus > 0)
    {
        int nWisdomModifier = monkAcBonus * 2;
        if ( nWisdomModifier > 10 ) nWisdomModifier = 10;
        ipAcDecrease = ItemPropertyDecreaseAbility ( IP_CONST_ABILITY_WIS, nWisdomModifier );
        AddItemProperty( DURATION_TYPE_PERMANENT,
                   ipAcDecrease,
                   oMonkHide
                  );

    }

}


