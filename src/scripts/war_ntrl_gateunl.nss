#include "nwk_gates"

void main()
{
    object oDoor = OBJECT_SELF;
    object oUnlocker = GetLastUnlocked();
    onUnlockGate(oDoor  , TEAM_NONE,GATE_TYPE_NEUTRAL_FAST ,  oUnlocker);


}
