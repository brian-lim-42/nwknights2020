#include "nwk_math"

void changeFaction(object oPC, string sTagFriend, string sTagEnemy)
{
    object oEnemy = GetObjectByTag(sTagEnemy);
    object oFriend = GetObjectByTag(sTagFriend);

    // reset reputation to zero (assumes all faction members view the same)
    int iFriendRep = GetFactionAverageReputation(oPC, oFriend);
    int iEnemyRep = GetFactionAverageReputation(oPC, oEnemy);
    AdjustReputation(oPC, oEnemy, -1 * iEnemyRep);
    AdjustReputation(oPC, oFriend, -1 * iFriendRep);

    // set reputation of friend
    AdjustReputation(oPC, oFriend, 200);
}

