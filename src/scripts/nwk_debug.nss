 //::///////////////////////////////////////////////
//:: Name  nwk_debug
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Pentagon
//:: Created On: 9/9/2004
//:://////////////////////////////////////////////



/** sends a debug message to the player If and only if
he is defined as a debugger. meaning , most of the players
will not see this message
@param player - the object to send the message too. the player name
    of this object will be tested to se if he is a debugger
@param message - the msg string.
*/
// fileName: nwk_debug
int DEBUG_MODE_ENABLED=1;
int DEBUG_MODE_DISABLED=0;




int CURRENT_DEBUG_MODE=DEBUG_MODE_DISABLED;  //change that on real game




/** speaks it only if we are on mode enabled
*/
void debugSpeakString(object obj,string message)
{
    if (CURRENT_DEBUG_MODE==DEBUG_MODE_ENABLED)
    {
        SpeakString(message);
    }
}

///
void debug_sendDebugMessage(object player,string message)
{
    string DebuggerPlayerName="NWKnights2";

    if (DebuggerPlayerName!=GetPCPlayerName(player))
        return;
    else
        SendMessageToPC(player,message);
}



