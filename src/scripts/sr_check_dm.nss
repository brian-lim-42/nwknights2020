/*
  author: shadow_in_the_dark
  name:   sr_check_dm
  date:   05/01/02

  check if the speaker is a DM
*/
int StartingConditional()
{
    int iResult;

    iResult = GetIsDM ( GetPCSpeaker () );
    return iResult;
}
