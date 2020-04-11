const int LEVEL_ONE_EXPERIENCE = 0;
const int LEVEL_TWENTY_EXPERIENCE = 190000;

void main()
{

    object oPC = GetPCSpeaker();
    int iPCClass = GetClassByPosition(1, oPC);

    SetXP(oPC, LEVEL_ONE_EXPERIENCE);
    SetXP(oPC, LEVEL_TWENTY_EXPERIENCE);

    // level up 19 times
    // the CLASS_TYPE_* is the same integer as PACKAGE_* for default packages
    int i;
    for (i = 0; i < 19; i++) {
        LevelUpHenchman(oPC, iPCClass, TRUE, iPCClass);
    }

    // TODO more choices than default package

}
