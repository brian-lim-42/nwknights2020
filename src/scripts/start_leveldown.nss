#include "sr_charid_inc"
void main()
{

object oPC = GetPCSpeaker();
int oLevel = GetHitDice (oPC);

if (oLevel == 20)
{
SetXP(oPC, 171000);
DelayCommand (0.1, SetXP(oPC, 190000));
}

else if (oLevel == 19)
{
SetXP(oPC, 153000);
DelayCommand (0.1, SetXP(oPC, 190000));
}

else if (oLevel == 18)
{
SetXP(oPC, 136000);
DelayCommand (0.1, SetXP(oPC, 190000));
}

else if (oLevel == 17)
{
SetXP(oPC, 120000);
DelayCommand (0.1, SetXP(oPC, 190000));
}

else if (oLevel == 16)
{
SetXP(oPC, 105000);
DelayCommand (0.1, SetXP(oPC, 190000));
}

else if (oLevel == 15)
{
SetXP(oPC, 91000);
DelayCommand (0.1, SetXP(oPC, 190000));
}

else if (oLevel == 14)
{
SetXP(oPC, 78000);
DelayCommand (0.1, SetXP(oPC, 190000));
}

else if (oLevel == 13)
{
SetXP(oPC, 66000);
DelayCommand (0.1, SetXP(oPC, 190000));
}

else if (oLevel == 12)
{
SetXP(oPC, 55000);
DelayCommand (0.1, SetXP(oPC, 190000));
}

else if (oLevel == 11)
{
SetXP(oPC, 45000);
DelayCommand (0.1, SetXP(oPC, 190000));
}

else if (oLevel == 10)
{
SetXP(oPC, 36000);
DelayCommand (0.1, SetXP(oPC, 190000));
}

else if (oLevel == 9)
{
SetXP(oPC, 28000);
DelayCommand (0.1, SetXP(oPC, 190000));
}

else if (oLevel == 8)
{
SetXP(oPC, 21000);
DelayCommand (0.1, SetXP(oPC, 190000));
}

else if (oLevel == 7)
{
SetXP(oPC, 15000);
DelayCommand (0.1, SetXP(oPC, 190000));
}

else if (oLevel == 6)
{
SetXP(oPC, 10000);
DelayCommand (0.1, SetXP(oPC, 190000));
}

else if (oLevel == 5)
{
SetXP(oPC, 6000);
DelayCommand (0.1, SetXP(oPC, 190000));
}

else if (oLevel == 4)
{
SetXP(oPC, 3000);
DelayCommand (0.1, SetXP(oPC, 190000));
}

else if (oLevel == 3)
{
SetXP(oPC, 1000);
DelayCommand (0.1, SetXP(oPC, 190000));
}

else if (oLevel == 2)
{
SetXP(oPC, 0);
DelayCommand (0.1, SetXP(oPC, 190000));
}

SetNewCharId ( oPC );

}
