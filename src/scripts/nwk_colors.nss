//::///////////////////////////////
// Token Color Strings Include Script.
//::///////////////////////////////
// _token_colors
//::///////////////////////////////
// taken from Bioware forum post , copied and changed name to nwk_colors

//Color used by saving throws.
const string COLOR_BLUE         = "<cfÌþ>";

//Color used for electric damage.
const string COLOR_DARK_BLUE    = "<c fþ>";

//Color used for negative damage.
const string COLOR_GRAY         = "<c®®®>";

//Color used for acid damage.
const string COLOR_GREEN        = "<c þ >";

//Color used for the player's name, and cold damage.
const string COLOR_LIGHT_BLUE   = "<c®þþ>";

//Color used for system messages.
const string COLOR_LIGHT_GRAY   = "<c°°°>";

//Color used for sonic damage.
const string COLOR_LIGHT_ORANGE = "<cþ® >";

//Color used for a target's name.
const string COLOR_LIGHT_PURPLE = "<cÌ®Ì>";

//Color used for attack rolls and physical damage.
const string COLOR_ORANGE       = "<cþf >";

//Color used for spell casts, as well as magic damage.
const string COLOR_PURPLE       = "<cÌwþ>";

//Color used for fire damage.
const string COLOR_RED          = "<cþ  >";

//Color used for positive damage.
const string COLOR_WHITE        = "<cþþþ>";

//Color used for healing, and sent messages.
const string COLOR_YELLOW       = "<cþþ >";

// No color.
const string COLOR_NONE         = "";

// Color end TAG.
const string COLOR_END          = "</c>";


//:://////////////////////////////////////////////////
// int GetIsColorTagValid( string sColorTag)
//        Returns TRUE if the input string is a valid color tag.
//:://////////////////////////////////////////////////
// Parameters: string sColorTag = color tag to check.
//
// Returns: Returns TRUE if the input string is a valid color tag, FALSE otherwise.
//:://////////////////////////////////////////////////
int GetIsColorTagValid( string sColorTag);
int GetIsColorTagValid( string sColorTag)
{ if( sColorTag == COLOR_BLUE)         return TRUE;
  if( sColorTag == COLOR_DARK_BLUE)    return TRUE;
  if( sColorTag == COLOR_GRAY)         return TRUE;
  if( sColorTag == COLOR_GREEN)        return TRUE;
  if( sColorTag == COLOR_LIGHT_BLUE)   return TRUE;
  if( sColorTag == COLOR_LIGHT_GRAY)   return TRUE;
  if( sColorTag == COLOR_LIGHT_ORANGE) return TRUE;
  if( sColorTag == COLOR_LIGHT_PURPLE) return TRUE;
  if( sColorTag == COLOR_ORANGE)       return TRUE;
  if( sColorTag == COLOR_PURPLE)       return TRUE;
  if( sColorTag == COLOR_RED)          return TRUE;
  if( sColorTag == COLOR_WHITE)        return TRUE;
  if( sColorTag == COLOR_YELLOW)       return TRUE;
  return FALSE;
}


//:://////////////////////////////////////////////////
// string ColorString( string sString, string sColorTag)
//        Returns a string encoded with color tags.
//:://////////////////////////////////////////////////
// Parameters: string sString   = string to color encode.
//             string sColorTag = color tag to use.
//
// Returns: The input string encoded for color.
//:://////////////////////////////////////////////////
string ColorString( string sString, string sColorTag);
string ColorString( string sString, string sColorTag)
{ return (!GetIsColorTagValid( sColorTag) ? sString : (sColorTag +sString +COLOR_END));
}

