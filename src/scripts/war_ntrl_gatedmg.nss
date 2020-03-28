#include "nwk_gates"

void main()
{
    // get the door being damaged
    object oDoor = OBJECT_SELF;
    object oDamager = GetLastDamager();

    onDamageToTheGate(  oDoor , TEAM_NONE , GATE_TYPE_NEUTRAL_FAST,  oDamager );


}
