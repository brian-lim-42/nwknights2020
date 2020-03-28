/*
  author: shadow_in_the_dark
  name:   sr_charid_inc
  date:   2008-05-06

  create and store identifiers to distinguish between chars of the same player
  with the same char name

*/



// Create an identifer to distinguish between different chars of the same build
int CreateCharIdValue ( object oPlayer );

// Set/override the char id for the player - used in level up/level down events
void SetNewCharId ( object oPlayer );

// Check if the char is equal to the registered one. If no char is registered
// the result is true and the char will be registered.
int GetIsSameChar ( object oPlayer );

// Get the key for the player/char combo
string GetCharIDKey ( object oPlayer );



// internal

int GetIsSameChar ( object oPlayer )
{
    // check for using different char with same name.
    int result = 0;
    int nCharIdValue = CreateCharIdValue ( oPlayer );
    // 1. Check if char was already logged in
    if ( GetLocalInt ( GetModule (), GetCharIDKey ( oPlayer ) ) == 0 )
    {
        // new char -> set id
        SetNewCharId( oPlayer );
        result = 1;
    }
    else
    {
        // player reloged
        if ( GetLocalInt ( GetModule (), GetCharIDKey ( oPlayer ) ) != nCharIdValue )
        {
            // same char name, but different build
            result = 0;
        }
        else
        {
            result = 1;
        }
    }
    return result;
}


int CreateCharIdValue ( object oPlayer )
{
    string sCharIdValue = "";
    // classes
    int i = 1;
    int nClasses = 0;
    while ( i <= 3 )
    {
        nClasses += GetClassByPosition ( i, oPlayer );
        i = i + 1;
    }
    sCharIdValue += IntToString ( nClasses );
    sCharIdValue += IntToString ( GetRacialType ( oPlayer ) );
    sCharIdValue += IntToString ( GetBaseAttackBonus ( oPlayer ) );
    return StringToInt ( sCharIdValue ) + GetAge ( oPlayer );

}

string GetCharIDKey ( object oPlayer )
{
    return GetPCPublicCDKey ( oPlayer, TRUE ) + GetName ( oPlayer );
}


void SetNewCharId ( object oPlayer )
{
    SetLocalInt ( GetModule (), GetCharIDKey ( oPlayer ), CreateCharIdValue ( oPlayer )  );
    /*
    WriteTimestampedLogEntry ( "NWK DEBUG: register new char for player: " +
                                GetPCPlayerName ( oPlayer ) + " with id: [" +
                                GetName ( oPlayer ) + "/" + IntToString ( CreateCharIdValue ( oPlayer ) ) + "]" );
    */
}
