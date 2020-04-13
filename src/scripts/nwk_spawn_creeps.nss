#include "nwk_map_utils"
#include "nwk_object_utils"

const int FIGHTER_COUNT = 4;
const int ROGUE_COUNT = 3;
const int WIZARD_COUNT = 2;

const string TAG_PORTAL = "SANC_GOLD";

const string WP_GOLD_CREEP_SPAWN = "WP_GOLD_CREEP_SPAWN";
const string WP_GOLD_CREEP_TARGET = "WP_GOLD_CREEP_TARGET";
const string WP_SILVER_CREEP_SPAWN = "WP_SILVER_CREEP_SPAWN";
const string WP_SILVER_CREEP_TARGET = "WP_SILVER_CREEP_TARGET";

void spawnGoldCreeps(string tSpawn, string tTarget);
void spawnSilverCreeps(string tSpawn, string tTarget);

void spawnCreeps()
{

    int nMap = getMapNumber();
    string sMap = getMap();

    // invalid current area; do not spawn
    if (!(nMap >= 1 && nMap <= 21)) { return; }

    // invalid waypoints; do not spawn
    string tagGoldCreepSpawn = WP_GOLD_CREEP_SPAWN + "_" + sMap;
    string tagGoldCreepTarget = WP_GOLD_CREEP_TARGET + "_" + sMap;
    string tagSilverCreepSpawn = WP_SILVER_CREEP_SPAWN + "_" + sMap;
    string tagSilverCreepTarget = WP_SILVER_CREEP_TARGET + "_" + sMap;

    if (GetWaypointByTag(tagGoldCreepSpawn) == OBJECT_INVALID ||
        GetWaypointByTag(tagGoldCreepTarget) == OBJECT_INVALID ||
        GetWaypointByTag(tagSilverCreepSpawn) == OBJECT_INVALID ||
        GetWaypointByTag(tagSilverCreepTarget) == OBJECT_INVALID)
    {
        return;
    }

    spawnGoldCreeps(tagGoldCreepSpawn, tagGoldCreepTarget);
    spawnSilverCreeps(tagSilverCreepSpawn, tagSilverCreepTarget);
}

void spawnGoldCreeps(string tSpawn, string tTarget)
{
    createObjectIfNotExists(FIGHTER_COUNT, "goldenflamefight", "GF_Fighter", TAG_PORTAL + getMap(), tSpawn, tTarget);
    createObjectIfNotExists(ROGUE_COUNT, "goldenflamerogue", "GF_Rogue", TAG_PORTAL + getMap(), tSpawn, tTarget);
    createObjectIfNotExists(WIZARD_COUNT, "goldenflamewizar", "GF_Wizard", TAG_PORTAL + getMap(), tSpawn, tTarget);
}

void spawnSilverCreeps(string tSpawn, string tTarget)
{
    createObjectIfNotExists(FIGHTER_COUNT, "silveryicefighte", "SI_Fighter", TAG_PORTAL + getMap(), tSpawn, tTarget);
    createObjectIfNotExists(ROGUE_COUNT, "silveryicerogue", "SI_Rogue", TAG_PORTAL + getMap(), tSpawn, tTarget);
    createObjectIfNotExists(WIZARD_COUNT, "silveryicewizard", "SI_Wizard", TAG_PORTAL + getMap(), tSpawn, tTarget);
}

