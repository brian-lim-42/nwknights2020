#include "nwk_gates"

void main()
{
    object oDoor = OBJECT_SELF;
    object oCloser = GetLastClosedBy();

    onPcTryToCloseGate(   oDoor , TEAM_SILVER , oCloser);
}
