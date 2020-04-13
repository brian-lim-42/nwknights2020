#include "nwk_map_utils"
#include "x0_i0_equip"
#include "x0_i0_destroy"

void createObjectsAndWalk(int count, string resRef, string tSpawn, string tTarget)
{
    location lSpawn = GetLocation(GetWaypointByTag(tSpawn));
    object oTarget = GetWaypointByTag(tTarget);
    object oCreature;
    int i;
    for (i = 0; i < count; i++) {
        oCreature = CreateObject(OBJECT_TYPE_CREATURE, resRef, lSpawn);
        EquipAppropriateWeapons(oCreature);
        AssignCommand(oCreature, ActionMoveToObject(oTarget, TRUE));
    }
}

void createObjectIfNotExists(int count, string resRef, string tag, string tObjInArea, string tSpawn, string tTarget)
{
    int nCount = CountAllObjectsInAreaByTag(tag, GetObjectByTag(tObjInArea));
    if (nCount < count) {
        createObjectsAndWalk(count - nCount, resRef, tSpawn, tTarget);
    }
}

