//nerf monks


void main()
{
 object oPC=GetExitingObject();
 if (!(GetIsObjectValid(oPC)))
        oPC=OBJECT_SELF;


 int monk_level=GetLevelByClass(CLASS_TYPE_MONK,oPC) ;
 int i;
 for (i=0;i<=monk_level;i++)
    DecrementRemainingFeatUses(oPC,FEAT_STUNNING_FIST);

// if (GetHasFeat(FEAT_QUIVERING_PALM,oPC))
//    DecrementRemainingFeatUses(oPC,FEAT_QUIVERING_PALM);

// int paladin_level=GetLevelByClass(CLASS_TYPE_PALADIN,oPC) ;
// for (i=0;i<=monk_level;i++)
//    DecrementRemainingFeatUses(oPC,FEAT_SMITE_EVIL);

//cleric nerfs -added by shadow_in_the_dark Rev. 5.4
    int nClericLevel = GetLevelByClass ( CLASS_TYPE_CLERIC, oPC );
    if ( GetHasFeat ( FEAT_TRICKERY_DOMAIN_POWER, oPC ) )
    {
        int nCharismaBonus = GetAbilityModifier ( ABILITY_CHARISMA, oPC );
        if ( GetHasFeat ( FEAT_EXTRA_TURNING, oPC ) )
        {
            nCharismaBonus += 6;
        }
        for ( i = 0; i <= ( nClericLevel + nCharismaBonus ); i++ )
        {
            DecrementRemainingFeatUses ( oPC, FEAT_TURN_UNDEAD );
        }
    }

}
