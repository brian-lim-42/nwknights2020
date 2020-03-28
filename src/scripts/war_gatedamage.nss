// NWTACTICS by Jhenne (tallonzek@hotmail.com)
// 07/07/02
// Door Damage scripts so the doors will open when hurt instead of falling apart
// implemented because doors cannot be respawned or healed.
// this script is called in the 'OnDamaged' event of the door
// Modified by PDL Northpal - 08/02/2002
// Reworked on 8/22/2002
// This specific script does apply to any door that is not related to a specific team. The difference
// is that this script doesn;t reclose the door automatically. Players must close it.

#include "nwk_gates"

void main()
{
    // get the door being damaged
    object oDoor = OBJECT_SELF;
    object oDamager = GetLastDamager();

    onDamageToTheGate(  oDoor , TEAM_NONE , GATE_TYPE_BASE,  oDamager );


}

