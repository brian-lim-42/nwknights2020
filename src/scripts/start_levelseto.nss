#include "sr_charid_inc"
void main()
{

  object oPC = GetPCSpeaker();
  SetXP(oPC, 0);
  DelayCommand (0.1, SetXP(oPC, 190000));
  SetNewCharId ( oPC );
}

