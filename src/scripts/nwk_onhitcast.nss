/*
  author: shadow_in_the_dark
  name:   nwk_onhitcast
  date:   05/02/18

*/

#include "war_inc_stun"
#include "nwk_flag"
#include "nwk_dom_inc"


// if any other reason exist for the SD hide nerf - check for it in this function
void ReAssignMalus ( object oAttacker )
{
    // flag issues
    ApplySDMalus ( oAttacker );
    // domination issues
    if ( GetIsActiveDominator ( oAttacker ) )
    {
        ApplyDominatorEffect ( oAttacker );
    }

}


// check if a valid Sneak malus is there.
int GetHasSneakMalus ( object oAttacker )
{
    int nNerfValid = FALSE;
    effect eCurrentEffect = GetFirstEffect ( oAttacker );

    while ( GetIsEffectValid ( eCurrentEffect ) )
    {
    // DEBUG
    //WriteTimestampedLogEntry( "nwk_onhitcast::GetIsSDNerfValid | efect check *********************** " );
    //WriteTimestampedLogEntry( "nwk_onhitcast::GetIsSDNerfValid | effect type = " + IntToString ( GetEffectType ( eCurrentEffect ) ) );
    //WriteTimestampedLogEntry( "nwk_onhitcast::GetIsSDNerfValid | effect subtype = " + IntToString ( GetEffectSubType ( eCurrentEffect ) ) );
    //WriteTimestampedLogEntry( "nwk_onhitcast::GetIsSDNerfValid | effect durationtype = " + IntToString ( GetEffectDurationType ( eCurrentEffect ) ) );

        if ( GetEffectType ( eCurrentEffect ) == EFFECT_TYPE_ABILITY_DECREASE &&
             GetEffectDurationType ( eCurrentEffect ) == DURATION_TYPE_TEMPORARY &&
             GetEffectSubType ( eCurrentEffect ) == SUBTYPE_EXTRAORDINARY )
        {
            nNerfValid = TRUE;
        }

        eCurrentEffect = GetNextEffect ( oAttacker );
    }
    return nNerfValid;
}

/*
  SD and Cobold Comand get a malus on hide and move silent. Duration of the malus depends on the
  number of class levels.
*/
void ApplySneakMalus ( object oSpellTarget )
{
    if ( GetHasFeat ( FEAT_HIDE_IN_PLAIN_SIGHT, oSpellTarget ) )
    {
        if ( ! GetHasSneakMalus ( oSpellTarget ) )
        {
            int nSkillHide = GetSkillRank (SKILL_HIDE, oSpellTarget );
            if ( nSkillHide > 50 )
            {
                RemoveEffectsFromSpell ( oSpellTarget, SPELL_MASS_CAMOFLAGE );
                RemoveEffectsFromSpell ( oSpellTarget, SPELL_CAMOFLAGE );
                RemoveEffectsFromSpell ( oSpellTarget, SPELL_ONE_WITH_THE_LAND );
            }
            int nSkillMoveSilent = GetSkillRank (SKILL_MOVE_SILENTLY, oSpellTarget );

            int nClassLevel = GetLevelByClass ( CLASS_TYPE_SHADOWDANCER, oSpellTarget );

            if ( nClassLevel == 0 )
            {
                // no SD - feat must be based on cobold command form
                // calculate "SD class level" from total number of druid and shifter level.
                nClassLevel = ( GetLevelByClass ( CLASS_TYPE_SHIFTER, oSpellTarget ) +
                                GetLevelByClass ( CLASS_TYPE_DRUID, oSpellTarget ) ) / 2;
            }

            float fDuration = 20.0 - IntToFloat ( nClassLevel );

            effect eMalus = ExtraordinaryEffect ( EffectSkillDecrease ( SKILL_HIDE, nSkillHide ) );
            eMalus = EffectLinkEffects ( ExtraordinaryEffect ( EffectSkillDecrease ( SKILL_MOVE_SILENTLY, nSkillMoveSilent ) ), eMalus );
            eMalus = EffectLinkEffects ( ExtraordinaryEffect ( EffectVisualEffect ( VFX_DUR_ICESKIN ) ), eMalus );
            ApplyEffectToObject ( DURATION_TYPE_TEMPORARY, eMalus, oSpellTarget, fDuration );
            // re-assign malus, if necesary
            DelayCommand ( fDuration + 0.5, AssignCommand ( oSpellTarget, ReAssignMalus ( oSpellTarget ) ) );
        }
    }
}

int GetHasSpeedMalus ( object oAttacker )
{
    int nNerfValid = FALSE;
    effect eCurrentEffect = GetFirstEffect ( oAttacker );

    while ( GetIsEffectValid ( eCurrentEffect ) )
    {
    // DEBUG
    //WriteTimestampedLogEntry( "nwk_onhitcast::GetHasSpeedMalus | efect check *********************** " );
    //WriteTimestampedLogEntry( "nwk_onhitcast::GetHasSpeedMalus | effect type = " + IntToString ( GetEffectType ( eCurrentEffect ) ) );

        if ( GetEffectType ( eCurrentEffect ) == EFFECT_TYPE_MOVEMENT_SPEED_DECREASE )
        {
            nNerfValid = TRUE;
        }

        eCurrentEffect = GetNextEffect ( oAttacker );
    }
    return nNerfValid;
}

void ApplySpeedMalus ( object oSpellTarget )
{
    object weapon = GetItemInSlot ( INVENTORY_SLOT_RIGHTHAND, oSpellTarget );

    if (GetIsObjectValid(weapon) && (GetWeaponRanged(weapon)))
    {
        if ( ! GetHasSpeedMalus ( oSpellTarget ) )
        {
            effect eMalus = ExtraordinaryEffect ( EffectMovementSpeedDecrease ( 35 ) );
            ApplyEffectToObject ( DURATION_TYPE_TEMPORARY, eMalus, oSpellTarget, 4.0f );
        }
    }
}

// start stun check if attacker is assassin and victim is stunned
void HandleStun ( object oVictim, object oAttacker )

{
    /*
    WriteTimestampedLogEntry ("*************************************************" +
                       "\n" + "NWK DEBUG: HandleStun" +
                       "\n" + "Attacker =  " + GetName ( oAttacker ) +
                       "\n" + "Victim = " + GetName ( oVictim ) +
                       "\n" + "*************************************************" );
    */
    if ( GetLevelByClass ( CLASS_TYPE_ASSASSIN, oAttacker ) > 0 )
    {
        effect e = GetFirstEffect ( oVictim );
        int e_type;
        int not_found_yet = TRUE;
        while (GetIsEffectValid(e) && not_found_yet)
        {
          if (GetEffectDurationType(e)==DURATION_TYPE_TEMPORARY)
          {

             e_type=GetEffectType(e);
             if ( e_type==EFFECT_TYPE_PARALYZE )
             {

                 not_found_yet = FALSE;

             }
          }
          e=GetNextEffect ( oVictim ) ;
        }//of while
        if ( ! not_found_yet )
        {

            WriteTimestampedLogEntry ( "*************************************************" +
                                "\n" + "NWK DEBUG: " + GetName ( oVictim ) + " stunned by Assassin" +
                                "\n" + "*************************************************" );
            InitiateStunCheck ( oVictim, 10 );

        }

    }
}

void NerfAttacker ( object oItem, object oSpellTarget )
{
    if ( ( GetBaseItemType ( oItem ) == BASE_ITEM_ARMOR ) ||
         ( GetBaseItemType ( oItem ) == BASE_ITEM_CREATUREITEM )
       )
    {

        // start here to add nerf for archer and SD from HB Script.
        // major problem is to avoid double malus
        // the functions decides if the nerf is necessary or not
        ApplySneakMalus ( oSpellTarget );
        ApplySpeedMalus ( oSpellTarget );
        DelayCommand(2.0, HandleStun ( OBJECT_SELF, oSpellTarget ) );
    }
}

