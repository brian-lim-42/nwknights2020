/*
  author: shadow_in_the_dark
  name:   sr_inc_shifter
  date:   2009-07-19

  shifter related functions

*/

/* kill a shapeshifter if his HP are not less or equal 0 */
void KillUndeadPlayer ( object oShifter );

void KillUndeadPlayer ( object oShifter )
{
    // kick him on floor, to avoid lich on thrown
    effect eKnockDown = EffectKnockdown ();
    effect eRessurect = EffectResurrection ();
    effect eDeath = EffectDeath(TRUE, TRUE);

    int nHP = GetCurrentHitPoints ( oShifter );
    if ( nHP > 0 )
    {
        WriteTimestampedLogEntry ( "\n**************************************************************************************" +
                                   "\n*** NWK DEBUG: Player " + GetName ( oShifter ) + ", HP = " + IntToString ( nHP ) + " killed by script" +
                                   "\n**************************************************************************************");
        // char was transformed to other shape, let's try again
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eRessurect, oShifter);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eKnockDown, oShifter, 3.0);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDeath, oShifter);
    }

}
