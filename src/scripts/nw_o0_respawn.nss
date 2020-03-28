// NWTACTICS by Jhenne (tallonzek@hotmail.com)
// 07/07/02
// PvP Respawn script, delay's respawning by 15 seconds, no exp or gold penalties
// are applied, if the player is in the combat arena they are move to the
// start point for their team

#include "nw_i0_plot"
#include "nwk_constants"
#include "nwk_debug"
#include "nwk_changeteams"
#include "sr_inc_dd"
/** Timing issue (pentagon 28/9/04)
 * Lots of bugs have happend here , so be carefull:
 * Effect ressuraction , must occur before player jumped to his base , but very close
 *          so no one will kill him again.
 * Effect visual shaft of light must happen before the jump (can jump with pc)
 * effect restock must happen after the player has resurracted
 * rffect heal must happen after ressuraction.
 * jump works only on live (hp>0) creatures
 */
void main()
{
    float fDelayVisualShaft = 0.3 ;
    float fDelayJump        = 1.0 ;
    //float fDelayResurrection= 0.9 ; done with jump!
    float fDelayHeal        = 2.0 ;
    float fDelayRestock     = 2.0 ;

//object oRespawner = GetLastRespawnButtonPresser();

//this script tuns on dead bodies . It runs every two or so seconds ,
// so even if you did not press a respwan button , it will still run.
// it will not do anything unless you are the last clicker &  you are also dead
// & your local int
//if (!GetIsDead(oRespawner))
//    return;

//if (!GetIsObjectValid( oRespawner))
object    oRespawner=OBJECT_SELF;
 if (!GetIsDead(oRespawner))
    return;

    // 2.96
    // shadow: avoid that the respawner directly dies
    // ensure he can be teleported
    // has to be reseted at end of jump
    SetPlotFlag (oRespawner, TRUE);


    effect eEffect = GetFirstEffect(oRespawner);
    while ( GetIsEffectValid(eEffect) == TRUE )
    {
       if ( GetEffectDurationType(eEffect) == DURATION_TYPE_TEMPORARY ||
            GetEffectDurationType(eEffect) == DURATION_TYPE_PERMANENT )
       {
                  if (GetEffectType(eEffect) != EFFECT_TYPE_DISEASE
                      && GetEffectType(eEffect) != EFFECT_TYPE_POISON
                      && GetEffectType(eEffect) != EFFECT_TYPE_CURSE)
                RemoveEffect(oRespawner,eEffect);
       }
       eEffect = GetNextEffect(oRespawner);
    }
//DelayCommand (fDelayResurrection, ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectResurrection(),oRespawner));
//resuucation in jump func. must be veryh close (same delay, but res before in func order

//changed on version 1.3 from 1.0 to 2.0 delay
//debug_sendDebugMessage( oRespawner , "gonna heal" + GetMaxHitPoints(oRespawner));
DelayCommand (fDelayHeal, ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(GetMaxHitPoints(oRespawner)), oRespawner));

 //Respawning Visual Effect should be :
 //1 . NOT delayed
 //2. applied on the the death location
location eLocation = GetLocation(oRespawner);

effect eVisual = EffectVisualEffect(VFX_IMP_HEALING_X);
//ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVisual, eLocation);
DelayCommand ( fDelayVisualShaft,ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisual, oRespawner));


 quickMvpCheck( oRespawner);


int destPoint = getDestPointByCharType(oRespawner);
//  DelayCommand (1.1,balanceTeamsWithPC(  oRespawner , destPoint ,  0.0));
DelayCommand(fDelayJump,balanceTeamsWithPC(  oRespawner , destPoint , fDelayRestock -  fDelayJump));
/* not working
DelayCommand ( fDelayJump + 1.0, SolveIncreasedAC ( oRespawner ) );
*/
//SetPermanentEffects(oRespawner);


}

