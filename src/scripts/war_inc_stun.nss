/*
  author: shadow_in_the_dark
  name:   war_inc_stun
  date:   05/03/02

  Include file for the NWKnight "remove stun on damage" rule

*/
const string sStunChecksLeft = "SR_STUN_CHECKS_LEFT";
const string sStunCheckOldHP = "SR_hp_before_stun";

const string sStunCheckScript = "war_stun_check";

// duration between 2 checks
const float nCheckPeriode = 3.0;

// call the responsible script to remove the stun effect every 3 sec.
void InitiateStunCheck ( object oTarget, int nRounds );

// remove stunn effect
void RemoveStunnEffect ( object oTarget );

void InitiateStunCheck ( object oTarget, int nRounds )
{
    if ( ! GetLocalInt ( oTarget, sStunChecksLeft ) )
    {
        SetLocalInt ( oTarget, sStunChecksLeft, nRounds * 2 );

        SetLocalInt ( oTarget, sStunCheckOldHP, GetCurrentHitPoints ( oTarget ) );

        DelayCommand ( nCheckPeriode, ExecuteScript ( sStunCheckScript, oTarget ));

    }

}


void RemoveStunnEffect ( object oTarget )
{
    WriteTimestampedLogEntry ( "NWK DEBUG: RemoveStunnEffect called for " + GetName ( oTarget ) );
    DeleteLocalInt ( oTarget, sStunChecksLeft );
    //search for all stunning effects and remove them
    //to save time , first check if it is temporary one ,
    //and only then dwell in.
    effect eEffect = GetFirstEffect(oTarget);
    int e_type;
    while ( GetIsEffectValid ( eEffect ) )// CAN HAVE 2 OR MORE EFFECTS SIMULTANISLY
    {
      if ( GetEffectDurationType ( eEffect ) == DURATION_TYPE_TEMPORARY )
      {

         e_type = GetEffectType ( eEffect );
         if((e_type==EFFECT_TYPE_CHARMED)||
            (e_type==EFFECT_TYPE_CONFUSED)||
            (e_type==EFFECT_TYPE_DAZED)||
            (e_type== EFFECT_TYPE_FRIGHTENED )||
            (e_type==EFFECT_TYPE_DOMINATED)||
            (e_type==EFFECT_TYPE_PARALYZE)||
            (e_type==EFFECT_TYPE_CUTSCENE_PARALYZE)||
            (e_type==EFFECT_TYPE_STUNNED) ||
            (e_type==EFFECT_TYPE_PETRIFY) )
         {
            RemoveEffect(oTarget, eEffect);
         }
      }
      eEffect = GetNextEffect(oTarget);
    }//of while
}


string DurationType2String ( int nDurationType )
{
    string result = "unknown";
    switch ( nDurationType )
    {
        case DURATION_TYPE_INSTANT : result = "instant";
            break;
        case DURATION_TYPE_PERMANENT : result = "permanent";
            break;
        case DURATION_TYPE_TEMPORARY : result = "temporary";
            break;
        default:
            result = "unknown";
    }
    return result;
}

string EffectType2String ( int nEffectType )
{
    string result = "unknown";
    switch ( nEffectType )
    {
        case EFFECT_TYPE_CHARMED : result = "charmed";
            break;
        case EFFECT_TYPE_CONFUSED : result = "confused";
            break;
        case EFFECT_TYPE_DAZED : result = "dazed";
            break;
        case EFFECT_TYPE_FRIGHTENED : result = "frightened";
            break;
        case EFFECT_TYPE_DOMINATED : result = "dominated";
            break;
        case EFFECT_TYPE_PARALYZE : result = "paralyze";
            break;
        case EFFECT_TYPE_CUTSCENE_PARALYZE : result = "cutscene paralyze";
            break;
        case EFFECT_TYPE_STUNNED : result = "stunned";
            break;
        case EFFECT_TYPE_PETRIFY : result = "petrify";
            break;
        default:
            result = "unknown";
    }
    return result;
}
