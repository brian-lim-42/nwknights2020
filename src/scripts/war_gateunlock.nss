// NWTACTICS by Jhenne (tallonzek@hotmail.com)
// 07/07/02
// OnUnlocked Script for the Fort Doors, letting them stay unlocked forever
// was unbalancing, frequently no one would ever relock it and the original
// thief that unlocked it would eventually relock it just to give them a break.

// this script will start working whenever the OnUnlock function is fixed by Bioware.

#include "nwk_gates"

void main()
{
    object oDoor = OBJECT_SELF;
    object oUnlocker = GetLastUnlocked();
    onUnlockGate(oDoor  , TEAM_NONE, GATE_TYPE_BASE ,  oUnlocker);


}

