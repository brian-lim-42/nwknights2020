/*
  author: shadow_in_the_dark
  name:   equ_hvy_arm_1
  date:   05/08/24

  Show selection of heavy armor only if:
  - no Palemaster Level

*/


int StartingConditional()
{
    int iResult = TRUE;
    object oPC = GetPCSpeaker ();
    iResult = iResult && ! GetLevelByClass ( CLASS_TYPE_PALEMASTER, oPC );

    return iResult;
}
