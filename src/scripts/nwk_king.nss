/** nwk_king
    file that includes general flag related functions and constants
*/
#include "nw_i0_spells"

///////////////// constants  //////////////////////

int nwk_king_team_bonus()   {return 1;}
int nwk_king_player_bonus() {return 1;}
int nwk_king_win_points()   {return 100;}
int nwk_king_trophy_points(){return 10;}

const int KING_BROADCAST_EVERY_POINT_AMOUT = 10;

const string TAG_THROWN = " ";
string VARNAME_USE_COUNTER="useCounter";

// remove all spell effects for invisibilty and set
// hide and move silent feat for 1 round to 0
void ApplyKingNerfs ( object oKing );

void ApplyKingNerfs ( object oKing )
{

    int nSkillHide = GetSkillRank (SKILL_HIDE, oKing );
    if ( nSkillHide > 50 )
    {
        RemoveEffectsFromSpell ( oKing, SPELL_MASS_CAMOFLAGE );
        RemoveEffectsFromSpell ( oKing, SPELL_CAMOFLAGE );
        RemoveEffectsFromSpell ( oKing, SPELL_ONE_WITH_THE_LAND );
    }
    int nSkillMoveSilent = GetSkillRank (SKILL_MOVE_SILENTLY, oKing );
    effect eMalus = ExtraordinaryEffect ( EffectSkillDecrease ( SKILL_HIDE, nSkillHide ) );
    eMalus = EffectLinkEffects ( ExtraordinaryEffect ( EffectSkillDecrease ( SKILL_MOVE_SILENTLY, nSkillMoveSilent ) ), eMalus );
    RemoveSpecificEffect(EFFECT_TYPE_INVISIBILITY, oKing);
    RemoveSpecificEffect(EFFECT_TYPE_SANCTUARY, oKing);
    RemoveSpecificEffect(EFFECT_TYPE_ETHEREAL, oKing);
    ApplyEffectToObject ( DURATION_TYPE_TEMPORARY, eMalus, oKing, 6.0f );
}
