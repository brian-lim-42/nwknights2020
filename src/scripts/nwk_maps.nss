//nwk_maps
//deals with maps , some functions are still at nwk_constants.

#include "nwk_constants"
#include "nwk_flag"
#include "nwk_gates"
#include "nwk_dom_inc"

/*
  adding new maps:

  - Add map number constant - all waypoints on the map have to end on this values
  - Increase TOTAL_NUMBER_OF_MAPS constant
  - Add map type to function getMapType
  - Add map to function SelectNextMap() - strategy ROUNDTRIP
*/
// void main () {}
//map numbers. Add new one here
const int MAP_ISLE_FLAG = 1;
const int MAP_ISLE_DOMINATION = 2;
const int MAP_CITY_KING = 3;
const int MAP_CITY_FLAG = 4;
const int MAP_CRYPT_FLAG = 5;
const int MAP_ISLE_KING = 6;
const int MAP_CRYPT_KING = 7;
const int MAP_FOREST_KING = 8;
const int MAP_DUNGEON_KING = 9;
const int MAP_SEWER_KING = 10;
const int MAP_TAVERN_KING = 11;
const int MAP_CAVERN_FLAG = 12;
const int MAP_CAVERN_KING = 13;
const int MAP_FOREST_FLAG = 14;
const int MAP_CASTLE_KING = 15;
const int MAP_TOWER_KING = 16;
const int MAP_CITY_DOMINATION = 17;
const int MAP_SUN_DUNGEON_FLAG = 18;
const int MAP_DUNGEON_FLAG = 19;
const int MAP_EL_PIRATES_KING = 20;
const int MAP_EL_GHOST_TOWN_FLAG = 21;


//number of active maps
const int TOTAL_NUMBER_OF_MAPS    = 21; // should be equal to highest map number
const int NUMBER_OF_DISABLED_MAPS = 0;  //on rotation (only ball is out)

const string MAP_SELECT_STRATEGY = "SR_MAP_SELECT_STRATEGY";

/////////////////////////////////////////
const int MAP_TYPE_KING = 60;
const int MAP_TYPE_FLAG = 61;
const int MAP_TYPE_BALL = 62;
const int MAP_TYPE_DOMINATION = 63;
const int MAP_TYPE_ERROR = 79;


// used to store the modifier for random map selection strategy
const string MAP_NAME_PREFIX = "SR_MAP_NUMBER_";

// map selction strategy
const int STRATEGY_ROUNDTRIP = 1; // default and fallback
const int STRATEGY_RANDOM = 2;

// select a map depending on the selected strategy
// return new map_number
// set number of new map in module variable "map_number"
int SelectNewMap ( int nStrategy );

// clear the last map
void clearLastMap(int old_map);

// create a new map, depending on map type
// map number in module variable "map_number"
void createNewMap();

// set a modification value for map selection strategy RANDOM
void SetRandomModifier ( int nMap, int nModifier );

// get the modification value for map selection strategy RANDOM
int GetRandomModifier ( int nMap );

/**
 * returns the type of the map as a constant MAP_TYPE_X
 * if it is an unknow type  , MAP_TYPE_ERROR will be returned
 */
int getMapType(int map_num)
{
    // map_type start with error , but will change if it is legal map
    int map_type =MAP_TYPE_ERROR;


    switch (map_num)
    {
        case MAP_ISLE_FLAG: map_type=MAP_TYPE_FLAG; break;
        case MAP_CITY_KING: map_type=MAP_TYPE_KING; break;
        case MAP_CITY_FLAG: map_type=MAP_TYPE_FLAG; break;
        case MAP_CRYPT_FLAG: map_type=MAP_TYPE_FLAG; break;
        case MAP_ISLE_KING: map_type=MAP_TYPE_KING; break;
        case MAP_CRYPT_KING: map_type=MAP_TYPE_KING; break;
        case MAP_FOREST_KING: map_type=MAP_TYPE_KING; break;
        case MAP_DUNGEON_KING: map_type=MAP_TYPE_KING; break;
        case MAP_SEWER_KING: map_type=MAP_TYPE_KING; break;
        case MAP_TAVERN_KING: map_type=MAP_TYPE_KING; break;
        case MAP_CAVERN_KING: map_type=MAP_TYPE_KING; break;
        case MAP_CAVERN_FLAG: map_type=MAP_TYPE_FLAG; break;
        case MAP_FOREST_FLAG: map_type=MAP_TYPE_FLAG; break;
        case MAP_CASTLE_KING: map_type=MAP_TYPE_KING; break;
        case MAP_TOWER_KING: map_type=MAP_TYPE_KING; break;
        case MAP_CITY_DOMINATION: map_type=MAP_TYPE_DOMINATION; break;
        case MAP_ISLE_DOMINATION: map_type=MAP_TYPE_DOMINATION; break;
        case MAP_DUNGEON_FLAG: map_type=MAP_TYPE_FLAG; break;
        case MAP_SUN_DUNGEON_FLAG: map_type=MAP_TYPE_FLAG; break;
        case MAP_EL_PIRATES_KING: map_type=MAP_TYPE_KING; break;
        case MAP_EL_GHOST_TOWN_FLAG: map_type=MAP_TYPE_FLAG; break;
        default: map_type = MAP_TYPE_ERROR;
   }
   return map_type;
}


/*  changeMaps
 * called upon map winning , we decide what new lovely map will be the
 * new map and transfer all the pc`s there.
 * parameters:
 *  winning_team - a string to determine who won ( for the broadcast and trophies)
 */
void changeMaps(string winning_team)
{
    //decide to which map number we need to go , make MOD operation
    int map_number;//=GetLocalInt(GetModule(),"map_number");
    int old_map=GetLocalInt(GetModule(),"map_number");
    int i;


//hold this area pointer , check in 10 and 20 sec and try to get all
//remaining people back .
    object old_area=GetArea(GetObjectByTag (mapFullTagName ("SANC_GOLD")));

    DelayCommand(10.0,ExecuteScript("nwk_pick_remains",old_area)) ;
    DelayCommand(20.0,ExecuteScript("nwk_pick_remains",old_area)) ;

    map_number = SelectNewMap ( GetLocalInt ( GetModule (), MAP_SELECT_STRATEGY ) );

    //do this even on first module map - to destroy throwns of "king`s hill"
    //have to be before creation of the new map
    clearLastMap(old_map);
    createNewMap();


    //if module was just created , return; else broadcast the good(or bad)
    //news to the teams and jump them to the new map
    if (winning_team=="INIT_MODULE")
        return;


    float fDelay=0.0;

    string winMsg= "The "+longTeamName(winning_team)+" team has won the match";
    int nHighestKillScore = 0;
    string sHighestKillScorer = "";
    int nHighestTeamScore = 0;
    string sHighestTeamScorer = "";
    object oPC = GetFirstPC ();
    while ( GetIsObjectValid( oPC ) )
    {
        if  ( GetLocalInt ( oPC, ROUND_KILL_STAT ) > nHighestKillScore )
        {
            nHighestKillScore = GetLocalInt ( oPC, ROUND_KILL_STAT );
            sHighestKillScorer = GetName ( oPC );
        }
        if  ( GetLocalInt ( oPC, ROUND_TEAM_STAT ) > nHighestTeamScore )
        {
            nHighestTeamScore = GetLocalInt ( oPC, ROUND_TEAM_STAT );
            sHighestTeamScorer = GetName ( oPC );
        }
        SetLocalInt ( oPC, ROUND_KILL_STAT, 0 );
        SetLocalInt ( oPC, ROUND_TEAM_STAT, 0 );
        oPC = GetNextPC ();
    }
    string teamScoreMsg = "\n" + "Top Scorer: " + sHighestTeamScorer + " (" + IntToString ( nHighestTeamScore ) + ")";
    string killScoreMsg = "\n" + "Top Slayer: " + sHighestKillScorer + " (" + IntToString ( nHighestKillScore ) + ")";
    object oBroadcast = GetFirstPC();
    while(GetIsObjectValid(oBroadcast) == TRUE)
    {
        int animation ;
        int victory_counter=0;
        int voiceChat;
        if  ( GetLocalInt ( oBroadcast, ROUND_KILL_STAT ) > nHighestKillScore )
        {
            nHighestKillScore = GetLocalInt ( oBroadcast, ROUND_KILL_STAT );
            sHighestKillScorer = GetName ( oBroadcast );
        }
        if  ( GetLocalInt ( oBroadcast, ROUND_TEAM_STAT ) > nHighestTeamScore )
        {
            nHighestTeamScore = GetLocalInt ( oBroadcast, ROUND_TEAM_STAT );
            sHighestTeamScorer = GetName ( oBroadcast );
        }
        SetLocalInt(oPC, ROUND_KILL_STAT, 0);
        SetLocalInt(oPC, ROUND_TEAM_STAT, 0);
        //give winners a trophy
        if ( GetBelongsToWinningTeam ( oBroadcast ) )
        {
            CreateItemOnObject ("Trophy",oBroadcast);
            switch (victory_counter)
            {
                case 0 :  animation = ANIMATION_FIREFORGET_VICTORY1;
                          voiceChat=VOICE_CHAT_CHEER;
                          break;

                case 1 :  animation = ANIMATION_FIREFORGET_VICTORY2;
                          voiceChat=VOICE_CHAT_LAUGH;
                          break;
                case 2 :  animation = ANIMATION_FIREFORGET_VICTORY3;
                          voiceChat=VOICE_CHAT_CHEER;
                          break;
            }
            victory_counter++;
            if (victory_counter > 2)
                victory_counter=0;

        }
        else
        {
           animation = ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD;
           voiceChat = VOICE_CHAT_CUSS;
        }

        DelayCommand(   fDelay+5.0 ,
                            AssignCommand( oBroadcast,
                                ActionPlayAnimation(animation)
                            )
                        );
        DelayCommand(   fDelay+5.0 ,
                            AssignCommand( oBroadcast,
                                PlayVoiceChat(voiceChat)
                            )
                        );

        DelayCommand(5.0,AssignCommand(oBroadcast,
                                       SpeakString(ColorString(winMsg,COLOR_GREEN) +
                                                   ColorString(teamScoreMsg,COLOR_DARK_BLUE) +
                                                   ColorString(killScoreMsg,COLOR_DARK_BLUE)
                                                   ,TALKVOLUME_WHISPER)));



        //no delay , cause if there is one , clearLastMap changes the map
        NewMap(oBroadcast);
       // SendMessageToPC(oBroadcast,"for debug purpose , u stay here a bit");


        fDelay = fDelay + 0.53;
        oBroadcast=GetNextPC();
    }




      //change MVP statues to new map
      changeMvpStatues(getMvpObj(1));

}


// close open Gates
// reset to default points
// Gates needs to have tag:
// - GoldenFlameGate
// - SilveryIceGate
void ResetBaseGates ( int map_number )
{
    int map_type =  getMapType ( map_number );
    // only necessary for flag and ball
    if ( ( map_type == MAP_TYPE_FLAG ) || ( map_type == MAP_TYPE_BALL ) )
    {
        // need the area of the map to decide if we shall reset the gate
        object area = GetArea(GetObjectByTag ( fullTagNameInMap ( "SANC_GOLD", map_number )));
        // WriteTimestampedLogEntry ( "nwk_maps.ResetBaseGates | area = " + GetName (area));
        // now search for all Gates
        string sGoldGateTag = "GoldenFlameGate";
        string sSilverGateTag = "SilveryIceGate";

        object oGate = GetFirstObjectInArea ( area );
        while ( GetIsObjectValid ( oGate ) )
        {
            // WriteTimestampedLogEntry ( "nwk_maps.ResetBaseGates | gate = " + GetTag (oGate));
            if ( ( GetTag ( oGate ) == sGoldGateTag ) ||
                 ( GetTag ( oGate ) == sSilverGateTag ) )
            {
                // close Gate if open, delay to ensure that all player have leave map
                DelayCommand ( 20.0, ResetBaseGate ( oGate ));
            }

            oGate = GetNextObjectInArea ( area );
        }
    }
}

void ClearArea ( int map_number )
{
    object area = GetArea(GetObjectByTag ( fullTagNameInMap ( "SANC_GOLD", map_number )));
    object oObject = GetFirstObjectInArea ( area );
    while ( GetIsObjectValid ( oObject ) )
    {
        if ( ! GetLocalInt ( oObject, "NWK_STATIC" ) )
        {
            if ( GetIsTrapped ( oObject ) )
            {
                SetTrapDisabled ( oObject );
                SendMessageToAllDMs ( "map change, trap disabled" );
            }
            else if ( GetObjectType ( oObject ) == OBJECT_TYPE_CREATURE &&
                      ! GetIsPC ( oObject ) )
            {
                DestroyObject ( oObject );
                SendMessageToAllDMs ( "map change, Creature destroyed" );
            }


        }
        oObject = GetNextObjectInArea ( area );
    }

}

/** clear all data from last map , this includes local vars
  * and placeables.
  * MUST BE CALLED WHEN MODULE MAP NUMBER IS SET TO NEW MAP
  */
void clearLastMap(int old_map)
{
    int map_type =  getMapType(old_map);
    WriteTimestampedLogEntry ( "\n**************************************************************************************" +
                               "\n*** DEBUG: Clear last Map: old map = " + IntToString ( old_map ) + ", map type = " + IntToString ( map_type ) );
    if (map_type==MAP_TYPE_KING)
    {
          //in "king of the hill" map type , we must destroy the thrown (cause they
            //have scripts on heartbit

         DestroyMultipleObjects("ThroneGood"+IntToString(old_map),30.0 );
    }
    else if (map_type == MAP_TYPE_FLAG)
    {
         ResetBaseGates ( old_map );
         deleteFlagFromAllPlayers();
         //destroy the flags
         DestroyObject(GetObjectByTag(nwk_silver_flag_tag() ),0.0);
         DestroyObject(GetObjectByTag(nwk_gold_flag_tag() ),0.0);
    }
    else if ( map_type == MAP_TYPE_DOMINATION )
    {
        StopDominationMap ( old_map );
    }

    ClearArea ( old_map );
    WriteTimestampedLogEntry ( "\n**************************************************************************************" );

}
/**
 * used on init/restart module
*/
void clearAllMaps()
{
    int total_maps= TOTAL_NUMBER_OF_MAPS;

    int i;

    for (i=1;i<=total_maps;i++)
    {
        clearLastMap(i);
        SetRandomModifier ( i, 0 );
    }
}


/** create a new map with new variables and placeables.
  * MUST BE CALLED WHEN MODULE MAP NUMBER IS SET TO NEW MAP
  * "thronegood",  //resref- this is only the for throne3 must be changed for other maps
  */
void  createNewMap()
{
    int map_number=GetLocalInt(GetModule(),"map_number");
    SetLocalInt(GetModule(),"silverscore"  ,0);
    SetLocalInt(GetModule(),"goldscore"  ,0);

    SetWeather(GetModule(),WEATHER_USE_AREA_SETTINGS);


    int map_type =  getMapType(map_number);
    //in "king of the hill" map type , we must create throwns.
    if (map_type==MAP_TYPE_KING)
    {
        CreateObject(OBJECT_TYPE_PLACEABLE,
                    "thronegood",  //resref- this is only the for throne3
                    GetLocation(GetObjectByTag(mapFullTagName("Throne"))),
                    FALSE,
                    "ThroneGood" + IntToString ( map_number ));

    }
    else if (map_type == MAP_TYPE_FLAG)
    {
        //on flag maps: 1.create the gold and silver flag in their bases.
        //              2.delete effects/variables from players and module , cause
        //                although one flag won the battle , the other may be on the move.
        // there seems to be a problem with the removing of the flags ..
        // this is the hard tour
        DestroyObject(GetObjectByTag(nwk_silver_flag_tag() ),0.0);
        DestroyObject(GetObjectByTag(nwk_gold_flag_tag() ),0.0);
        // go ahead with the original stuff

        createFlagOnFloor( TEAM_SILVER,
                           GetLocation(GetObjectByTag(nwk_silver_base_flag_location_tag()))
                         );

        createFlagOnFloor( TEAM_GOLD,
                           GetLocation(GetObjectByTag(nwk_gold_base_flag_location_tag()))
                         );
    }
    else if ( map_type == MAP_TYPE_DOMINATION )
    {
        StartDominationMap ( map_number );
    }

}



int SelectNewMap ( int nStrategy )
{

    int map_number = 0;
    int map_order;
    int bMapSelected = FALSE;
    int old_map = GetLocalInt ( GetModule (), "map_number" );
    int map_type_modifier;

    switch ( nStrategy )
    {
        case STRATEGY_RANDOM:
            ////////////////////////////////
            // Select a map with map number between 1 and TOTAL_NUMBER_OF_MAPS
            // Make a second roll with d100 which must be higher than
            // the map modifier to select the map. If map is not selected, the modifier
            // will be decreased by "100/TOTAL_NUMBER_OF_MAPS".
            // This ensures that a map is normally not selected 2 times in a row.
            // Maps which shall not be used can be disabled in function GetRandomModifier ()
            // The selected map gets an modifer of 100.
            while ( ! bMapSelected )
            {
                map_number = Random ( TOTAL_NUMBER_OF_MAPS ) + 1;
                map_type_modifier = 0;
                if ( getMapType ( old_map ) == getMapType ( map_number ) )
                {
                    map_type_modifier = 30;
                }
                if ( ( GetRandomModifier ( map_number ) + map_type_modifier ) < d100 () )
                {
                    SetRandomModifier ( map_number, 100 );
                    bMapSelected = TRUE;
                } else
                {
                    SetRandomModifier ( map_number,
                                        GetRandomModifier ( map_number ) -
                                        100 / ( TOTAL_NUMBER_OF_MAPS - NUMBER_OF_DISABLED_MAPS ) );
                }

            }
            break;
        case STRATEGY_ROUNDTRIP:
            ////////////////////////////////
            //   Round Trip - select next map.
            //   - Map order is constant
            //
            map_order=GetLocalInt(GetModule(),"map_order");
            map_order++;
            if (map_order>TOTAL_NUMBER_OF_MAPS - NUMBER_OF_DISABLED_MAPS)
                map_order=1;
             SetLocalInt(GetModule(),"map_order",map_order);
            ///////////////////////////////
            //  map_number is the current map and old map. the old is determined according
            //  to the map_number before this function. the new is determined according
            //  to the map order.

            if (map_order==1)       map_number=MAP_TAVERN_KING;
            else if (map_order==2)  map_number=MAP_CITY_KING;
            else if (map_order==3)  map_number=MAP_FOREST_FLAG;
            else if (map_order==4)  map_number=MAP_ISLE_KING;
            else if (map_order==5)  map_number=MAP_CASTLE_KING;
            else if (map_order==6)  map_number=MAP_CAVERN_FLAG;
            else if (map_order==7)  map_number=MAP_FOREST_KING;
            else if (map_order==8)  map_number=MAP_SUN_DUNGEON_FLAG;
            else if (map_order==9)  map_number=MAP_ISLE_DOMINATION;
            else if (map_order==10) map_number=MAP_ISLE_FLAG;
            else if (map_order==11) map_number=MAP_CAVERN_KING;
            else if (map_order==12) map_number=MAP_CRYPT_KING;
            else if (map_order==13) map_number=MAP_CITY_FLAG;
            else if (map_order==14) map_number=MAP_DUNGEON_KING;
            else if (map_order==15) map_number=MAP_SEWER_KING;
            else if (map_order==16) map_number=MAP_CRYPT_FLAG;
            else if (map_order==17) map_number=MAP_CITY_DOMINATION;
            else if (map_order==18) map_number=MAP_TOWER_KING;
            else if (map_order==19) map_number=MAP_DUNGEON_FLAG;
            else if (map_order==20) map_number=MAP_EL_PIRATES_KING;
            else if (map_order==21) map_number=MAP_EL_GHOST_TOWN_FLAG;
            else      map_number=2;//will never happen

            break;
        default:
            WriteTimestampedLogEntry ( "* ERROR : nwk_maps | unknown strategy for SelectNewMap - set default strategy" );
            SetLocalInt ( GetModule (), MAP_SELECT_STRATEGY, STRATEGY_ROUNDTRIP );
            map_number = MAP_TAVERN_KING;
    }
    SetLocalInt(GetModule(),"map_number",map_number);
    return map_number;
}

void SetRandomModifier ( int nMap, int nModifier )
{
    SetLocalInt ( GetModule (), MAP_NAME_PREFIX + IntToString ( nMap ), nModifier );
}

int GetRandomModifier ( int nMap )
{

    int nModifier = GetLocalInt ( GetModule (), MAP_NAME_PREFIX + IntToString ( nMap ) );
    // Maps which should not be selected by RANMDOM strategy needs modifier 100
    // add maps in the case statements
    switch ( nMap )
    {
    /*
        case 2:
            nModifier = 100;
    */
        default:
    }

    return nModifier;
}


