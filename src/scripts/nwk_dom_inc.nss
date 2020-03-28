/*
  author: shadow_in_the_dark
  name:   nwk_dom_inc
  date:   05/05/23

  include file for domination map type

*/
#include "nw_i0_spells"
#include "nwk_const_teams"
#include "nwk_constants"
#include "nwk_colors"

// relevant constants for scoring
const int DOM_WIN_POINTS = 300;
const int DOM_SCORE_POINT_LIMIT = 30;
const int DOM_SCORE_BROADCAST = 30;
const int DOM_SCORE_AT_INTERVALL = 1;


// identify a "dominator"
const string DOM_DOMINATOR = "SR_DOMINATOR";




// local area variable
// Number of domination areas in map
const string sNumberOfDomArea = "NWK_NUM_DOM_AREAS";

//base name of the way point the counter object shall be created on
//final name is: sDominationCounterBaseTag + IntToString ( map_number )
const string sDominationCounterWPBaseTag = "nwk_domination_counter_";
//base name of the counter object for domination maps
//final name is: sDominationCounterBaseTag + IntToString ( map_number )
const string sDominationCounterBaseTag = "domination_counter_";

// template tag of the counter object
const string sDominationCounterTemplateTag = "domination_count";

// the dominion the are belongs to
const string sDominionOfArea = "NWK_DOMINATION_DOMINION";

// base tag of the domination area ( map and area independent )
const string sDomAreaBaseTag = "nwk_domination_area_";

// the dominator of the area
const string sDominator = "NWK_DOMINATION_AREA_DOMINATOR";

//Areas are only active if this local int is TRUE
const string sDomAreaActive = "NWK_DOMINATION_AREA_ACTIVE";

// check if a player is inside a domination area
int GetIsInDominationArea ( object oPlayer );

// the domination area a player is inside
object GetDominationArea ( object oPlayer );

// check if a player dominates the area
int GetIsDominator ( object oPlayer, object oArea );

// check if Dominator inside dominated area
int GetIsActiveDominator ( object oPlayer );

// check if domination area is active
int GetIsActiveArea ( object oArea );

// reset the domination area
void ResetDominationArea ( object oArea );

// reset all domination areas domitaed by oPlayer
void ResetDominationAreaForPlayer ( object oPlayer );

// handle the event if a Player entered a domination area
// - check if area is controlled by him
void HandleOnEnterDominationAreaEvent ( object oPlayer, object oArea );

// handle the event if a Player leaves a domination area
// Related Events: OnDeath, OnClientExit, OnExit (Domination Area)
// - remove mark
// - check if area control has to be change
void HandleOnExitDominationAreaEvent ( object oPlayer, object oArea );

// activate the domination map
void StartDominationMap ( int map_number );

// de-activate the domination map
void StopDominationMap ( int map_number );

// State Report for current domination map.
string CreateDomStateReport ();

int GetNumberOfDomArea ( object oArea )
{
    return GetLocalInt ( oArea, sNumberOfDomArea );
}

int GetIsInDominationArea ( object oPlayer )
{
    //iterate over all domination areas in the current area of the player
    // get map number
    int nMap = GetLocalInt ( GetModule (), "map_number" );
    int bInArea = FALSE;
    int i;
    for ( i = 1; i <= GetNumberOfDomArea ( GetArea ( oPlayer ) ); i++ )
    {
        // create tag of the domination area
        string sDomAreaTag = sDomAreaBaseTag +
                                 IntToString ( nMap ) +
                                 "_" +
                                 IntToString ( i );
        bInArea = bInArea || GetIsInSubArea ( oPlayer, GetObjectByTag ( sDomAreaTag ) );
    }
    return bInArea;
}

object GetDominationArea ( object oPlayer )
{
    //iterate over all domination areas in the current area of the player
    // get map number
    int nMap = GetLocalInt ( GetModule (), "map_number" );
    object oArea = OBJECT_INVALID;
    int i = 1;
    int bExit = FALSE;
    int nNumberOfAreas = GetNumberOfDomArea ( GetArea ( GetObjectByTag (  sDominationCounterWPBaseTag + IntToString ( nMap ) ) ) );
    while ( i <= nNumberOfAreas && ! bExit )
    {
        // create tag of the domination area
        string sDomAreaTag = sDomAreaBaseTag +
                                 IntToString ( nMap ) +
                                 "_" +
                                 IntToString ( i );
        oArea = GetObjectByTag ( sDomAreaTag );
        if ( GetIsInSubArea ( oPlayer, oArea ) )
        {
            bExit = TRUE;
        }
        else
        {
            i++;
        }
    }
    WriteTimestampedLogEntry ( "\n**************************************************************************************" +
                               "\n*** NWK DEBUG: " + GetName ( oPlayer ) + " is in Domination Area " + GetTag ( oArea ) +
                               "\n**************************************************************************************");

    return oArea;

}

void ResetDominationAreaForPlayer ( object oPlayer )
{
    //iterate over all domination areas in the current area of the player
//    WriteTimestampedLogEntry ( "\n**************************************************************************************" +
//                               "\n*** NWK DEBUG: Reset of all domination areas for player " + GetName ( oPlayer ) +
//                               "\n**************************************************************************************");

    int nMap = GetLocalInt ( GetModule (), "map_number" );
    object oArea = OBJECT_INVALID;
    int i = 1;
    int bExit = FALSE;
    int nNumberOfAreas = GetNumberOfDomArea ( GetArea ( GetObjectByTag (  sDominationCounterWPBaseTag + IntToString ( nMap ) ) ) );
    while ( i <= nNumberOfAreas  )
    {
        // create tag of the domination area
        string sDomAreaTag = sDomAreaBaseTag +
                                 IntToString ( nMap ) +
                                 "_" +
                                 IntToString ( i );
        oArea = GetObjectByTag ( sDomAreaTag );
        object oDominator = GetLocalObject ( oArea, sDominator );
        WriteTimestampedLogEntry ( " AreaTag : " +  sDomAreaTag + "/" + GetName ( oArea ) + ", dominated by " + GetName ( oDominator ) );
        if ( oDominator == oPlayer )
        {
            ResetDominationArea ( oArea );
            HandleOnExitDominationAreaEvent ( OBJECT_INVALID, oArea );
        }
        i++;
    }

}

int GetIsActiveArea ( object oArea )
{
    return GetLocalInt ( oArea, sDomAreaActive );
}

// called in HandleOnEnterDominationAreaEvent() and HandleOnExitDominationAreaEvent()
void ApplyDominatorEffect ( object oDominator )
{
    SetLocalInt ( oDominator, DOM_DOMINATOR, TRUE );
    RemoveEffectsFromSpell ( oDominator, SPELL_MASS_CAMOFLAGE );
    RemoveEffectsFromSpell ( oDominator, SPELL_CAMOFLAGE );
    RemoveEffectsFromSpell ( oDominator, SPELL_ONE_WITH_THE_LAND );
    int nSkillHide = GetSkillRank (SKILL_HIDE, oDominator );
    int nSkillMoveSilent = GetSkillRank (SKILL_MOVE_SILENTLY, oDominator );
    if ( nSkillHide <= 0 ) nSkillHide = 1;
    if ( nSkillMoveSilent <= 0 ) nSkillHide = 1;
    effect eMalus = EffectSkillDecrease ( SKILL_HIDE, nSkillHide );
    eMalus = EffectLinkEffects (  EffectSkillDecrease ( SKILL_MOVE_SILENTLY, nSkillMoveSilent ), eMalus );
    effect eDominator = EffectLinkEffects (  EffectVisualEffect ( VFX_DUR_GLOW_ORANGE ), eMalus );
    ApplyEffectToObject ( DURATION_TYPE_PERMANENT, ExtraordinaryEffect ( eDominator ), oDominator );
    //remove invisiblitity and (greater) sanctuary
    RemoveSpecificEffect(EFFECT_TYPE_INVISIBILITY, oDominator);
    RemoveSpecificEffect(EFFECT_TYPE_SANCTUARY, oDominator);
    RemoveSpecificEffect(EFFECT_TYPE_ETHEREAL, oDominator);
}

// called in HandleOnEnterDominationAreaEvent(), HandleOnExitDominationAreaEvent()
// and ResetDominationArea()
void RemoveDominatorEffect ( object oDominator )
{
    DeleteLocalInt ( oDominator, DOM_DOMINATOR );
//    WriteTimestampedLogEntry( "RemoveDominatorEffect | check for valid effect: *********************** "+
//    "\n" + "effect type = " + IntToString ( EFFECT_TYPE_SKILL_DECREASE ) +
//    "\n" + "effect subtype = " + IntToString ( SUBTYPE_EXTRAORDINARY ) +
//    "\n" + "effect durationtype = " + IntToString ( DURATION_TYPE_PERMANENT ) );
    effect eEffect = GetFirstEffect ( oDominator );
    while ( GetIsEffectValid ( eEffect ) )
    {
//    WriteTimestampedLogEntry( "RemoveDominatorEffect | effect to check: *********************** "+
//    "\n" + "effect type = " + IntToString ( GetEffectType ( eEffect ) ) +
//    "\n" + "effect subtype = " + IntToString ( GetEffectSubType ( eEffect ) ) +
//    "\n" + "effect durationtype = " + IntToString ( GetEffectDurationType ( eEffect ) ) );


        if ( ( GetEffectType ( eEffect ) == EFFECT_TYPE_SKILL_DECREASE ) &&
             ( GetEffectSubType ( eEffect ) == SUBTYPE_EXTRAORDINARY ) &&
             ( GetEffectDurationType ( eEffect ) == DURATION_TYPE_PERMANENT ) )
        {
            RemoveEffect ( oDominator, eEffect );
        }
        eEffect = GetNextEffect ( oDominator );
    }

}

int GetIsActiveDominator ( object oPlayer )
{
    return GetLocalInt ( oPlayer, DOM_DOMINATOR );
}

// area will change dominator
// - if it's free
// - if the owner is not inside
void HandleOnEnterDominationAreaEvent ( object oPlayer, object oArea )
{
    string sOwningTeam = "";
    object oDominator = GetLocalObject ( oArea, sDominator );
    if ( GetIsObjectValid ( oDominator ) )
    {
        sOwningTeam = getTeamNameByPC ( oDominator );
    }
    string sTeam = getTeamNameByPC ( oPlayer );

    if ( sOwningTeam == "" )
    {
        if ( ( sTeam == TEAM_NAME_GOLD ) ||
             ( sTeam == TEAM_NAME_SILVER ) )
        {
            CreateObject ( OBJECT_TYPE_PLACEABLE, "light_" + sTeam, GetLocation ( oArea ), FALSE, "light_" + sTeam );
            SetLocalObject ( oArea, sDominator, oPlayer );
            ApplyDominatorEffect ( oPlayer );
            sendMessageToAllPlayer ( "", ColorString ( longTeamName ( sTeam ) +
                                     " conquers " +
                                     GetLocalString ( oArea, sDominionOfArea ) +
                                     " Dominion", COLOR_ORANGE ) );

            // WriteTimestampedLogEntry ( "\n**************************************************************************************" +
            //                           "\n*** NWK DEBUG: " + GetName ( oPlayer ) + " conquers free Domination Area " + GetTag ( oArea ) +
            //                           "\n**************************************************************************************");

        }

    } else if ( oPlayer == oDominator )
    {
        // re-entering of dominator
        ApplyDominatorEffect ( oPlayer );
    } else if ( ! GetIsInSubArea ( oDominator, oArea ) || GetIsDead ( oDominator ) )
    {
        // change domination
        object oCreature = GetFirstObjectInArea ( GetArea ( oArea ) );
        int bExit = FALSE;
        string sNewOwner;
        object oNewOwner = OBJECT_INVALID;
        // if we found team member of old dominator, he will become new one
        // otherwise one of the opposite team becomes dominator
        while ( GetIsObjectValid ( oCreature ) && ! bExit)
        {
            if ( GetIsInSubArea ( oCreature , oArea ) && ! GetIsDead ( oCreature ) )
            {

                sNewOwner = getTeamNameByPC ( oCreature );
                if ( ( sNewOwner == TEAM_NAME_GOLD ) ||
                     ( sNewOwner == TEAM_NAME_SILVER ) )
                {
                    oNewOwner = oCreature;
                    bExit = sTeam != sNewOwner;
                 }
            }
            oCreature = GetNextObjectInArea ( GetArea ( oArea ) );
        }
        // change to new owner ( dominator not in area or dead )
        if ( GetIsObjectValid ( oNewOwner ) )
        {
            SetLocalObject ( oArea, sDominator, oNewOwner );
            ApplyDominatorEffect ( oNewOwner );
            object oLight = GetNearestObjectByTag ( "light_" + sOwningTeam, oArea );
            DestroyObject ( oLight );
            CreateObject ( OBJECT_TYPE_PLACEABLE, "light_" + sNewOwner, GetLocation ( oArea ), FALSE, "light_" + sNewOwner );
            SetLocalObject ( oArea, sDominator, oNewOwner );
            sendMessageToAllPlayer ( "", ColorString ( longTeamName ( sNewOwner ) +
                                     " conquers " +
                                     GetLocalString ( oArea, sDominionOfArea ) +
                                     " Dominion", COLOR_ORANGE ) );
            // WriteTimestampedLogEntry ( "\n**************************************************************************************" +
            //                           "\n*** NWK DEBUG: " + GetName ( oNewOwner ) + " conquers Domination Area " + GetTag ( oArea ) +
            //                           " from " + GetName ( oDominator ) +
            //                           "\n**************************************************************************************");
        }
    }

}

void HandleOnExitDominationAreaEvent ( object oPlayer, object oArea )
{
    string sOwningTeam = "";
    object oDominator = GetLocalObject ( oArea, sDominator );
    RemoveDominatorEffect ( oPlayer );
    if ( GetIsObjectValid ( oDominator ) )
    {
        sOwningTeam = getTeamNameByPC ( oDominator );
    }
    if ( oDominator == oPlayer )
    {
        object oCreature = GetFirstObjectInArea ( GetArea ( oArea ) );
        int bExit = FALSE;
        string sNewOwner;
        object oNewOwner = OBJECT_INVALID;
        while ( GetIsObjectValid ( oCreature ) && ! bExit)
        {
            if ( GetIsInSubArea ( oCreature, oArea ) && ! GetIsDead ( oCreature ) )
            {
                sNewOwner = getTeamNameByPC ( oCreature );
                if ( ( sNewOwner == TEAM_NAME_GOLD ) ||
                     ( sNewOwner == TEAM_NAME_SILVER ) )
                {
                    oNewOwner = oCreature;
                    bExit = sOwningTeam == sNewOwner;
                }
            }
            oCreature = GetNextObjectInArea ( GetArea ( oArea ) );
        }
        // switch dominator to first player found
        // - the old one, if no one is found in domination area
        // - the first of the dominating team, who is inside the area
        // - the first of opposite team if domination changes
        if ( GetIsObjectValid ( oNewOwner ) )
        {
            SetLocalObject ( oArea, sDominator, oNewOwner );
            ApplyDominatorEffect ( oNewOwner );

            //WriteTimestampedLogEntry ( "\n**************************************************************************************" +
            //                           "\n*** NWK DEBUG: domination changes from " + GetName ( oDominator ) + " to " + GetName ( oDominator ) +
            //                           " for area " + GetTag ( oArea ) +
            //                           "\n**************************************************************************************");

            sNewOwner = getTeamNameByPC ( oNewOwner );
            object oLight = GetNearestObjectByTag ( "light_" + sOwningTeam, oArea );
            DestroyObject ( oLight );
            CreateObject ( OBJECT_TYPE_PLACEABLE, "light_" + sNewOwner, GetLocation ( oArea ), FALSE, "light_" + sNewOwner );
            if ( oNewOwner != oDominator )
            {
                sendMessageToAllPlayer ( "", ColorString ( longTeamName ( sNewOwner ) +
                                         " conquers " +
                                         GetLocalString ( oArea, sDominionOfArea ) +
                                         " Dominion", COLOR_ORANGE ) );
            }
        }
    }
}

void  ResetDominationArea ( object oArea )
{
    object oDominator = GetLocalObject ( oArea, sDominator );
    if ( GetIsObjectValid ( oDominator ) )
    {
    WriteTimestampedLogEntry ( "\n**************************************************************************************" +
                               "\n*** NWK DEBUG: Reset Domination Area " + GetTag ( oArea ) +
                               "\n**************************************************************************************");
        RemoveDominatorEffect ( oDominator );
        string sOwningTeam = getTeamNameByPC ( oDominator );
        object oLight = GetNearestObjectByTag ( "light_" + sOwningTeam, oArea );
        DestroyObject ( oLight );
        SetLocalObject ( oArea, sDominator, OBJECT_INVALID );
    }
}


// activate the domination map
void StartDominationMap ( int map_number )
{
    // create counter at location of the waypoint
    object oWP = GetObjectByTag ( sDominationCounterWPBaseTag + IntToString ( map_number ) );
    location lCounter = GetLocation ( oWP );
    CreateObject ( OBJECT_TYPE_PLACEABLE, sDominationCounterTemplateTag, lCounter, FALSE, sDominationCounterBaseTag + IntToString ( map_number ) );
    // reset the domination areas to default
    int i;
    for ( i = 1; i <= GetNumberOfDomArea ( GetArea ( oWP ) ); i++ )
    {
        // create tag of the domination area
        string sDomAreaTag = sDomAreaBaseTag +
                                 IntToString ( map_number ) +
                                 "_" +
                                 IntToString ( i );
        object oDomArea = GetObjectByTag ( sDomAreaTag );
        ResetDominationArea ( oDomArea );
        SetLocalInt ( oDomArea, sDomAreaActive, TRUE );
    }


}

// de-activate the domination map
void StopDominationMap ( int map_number )
{
    // reset the domination areas to default
    int i;
    for ( i = 1; i <= GetNumberOfDomArea ( GetArea ( GetObjectByTag (  sDominationCounterWPBaseTag + IntToString ( map_number ) ) ) ); i++ )
    {
        // create tag of the domination area
        string sDomAreaTag = sDomAreaBaseTag +
                                 IntToString ( map_number ) +
                                 "_" +
                                 IntToString ( i );
        object oDomArea = GetObjectByTag ( sDomAreaTag );
        ResetDominationArea ( oDomArea );
        SetLocalInt ( oDomArea, sDomAreaActive, FALSE );
    }
    // destroy counter (heartbeat event)
    DestroyObject ( GetObjectByTag (  sDominationCounterBaseTag + IntToString ( map_number ) ) );
}


int GetIsDominator ( object oPlayer, object oArea )
{
    int bResult = FALSE;

    if ( GetIsObjectValid ( oPlayer ) )
    {
        bResult = GetLocalObject ( oArea, sDominator ) == oPlayer;
    }
    return bResult;

}


string CreateDomStateReport ()
{
    string sResult = "";
    int nMap = GetLocalInt ( GetModule (), "map_number" );
    object oArea = OBJECT_INVALID;
    int i = 1;
    int nNumberOfAreas = GetNumberOfDomArea ( GetArea ( GetObjectByTag (  sDominationCounterWPBaseTag + IntToString ( nMap ) ) ) );
    for ( i = 1; i <= nNumberOfAreas; i++  )
    {
        // create tag of the domination area
        string sDomAreaTag = sDomAreaBaseTag +
                                 IntToString ( nMap ) +
                                 "_" +
                                 IntToString ( i );
        oArea = GetObjectByTag ( sDomAreaTag );
        object oDominator = GetLocalObject ( oArea, sDominator );
        if ( GetIsObjectValid ( oDominator ) )
        {
            sResult += GetLocalString ( oArea, sDominionOfArea ) +
                      " Dominion is conquered by " + longTeamName ( getTeamNameByPC ( oDominator ) ) + "\n";
        }
        else
        {
            sResult += GetLocalString ( oArea, sDominionOfArea ) +
                       " Dominion is free"  + "\n";
        }
    }
    WriteTimestampedLogEntry ( "\n**************************************************************************************" +
                               "\n*** NWK DEBUG: Domination State Created " +
                               "\n" + sResult +
                               "\n**************************************************************************************");

    return sResult;


}
