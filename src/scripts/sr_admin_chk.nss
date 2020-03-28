/*
  author: shadow_in_the_dark
  name:   sr_admin_chk
  date:   05/01/03

  Checks if a PC speaker has administration rights

*/
#include "sr_admin_inc"
int StartingConditional()
{
    int iResult;

    iResult = GetIsAdmin (GetPCSpeaker ());
    return iResult;
}
