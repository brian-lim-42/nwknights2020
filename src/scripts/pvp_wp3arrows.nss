void main()
{
object oPC = OBJECT_SELF;
string sTeam = GetLocalString(oPC, "team");
object oItem;



if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL)
{
    oItem = CreateItemOnObject ("EvilArrows", oPC, 99);
}
else if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
{
    oItem = CreateItemOnObject ("GoodArrows", oPC, 99);
}
else if ((sTeam == "GOLD") && (GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL))
{
    oItem = CreateItemOnObject ("GoldArrows", oPC, 99);
}
else if ((sTeam == "SILVER") && (GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL))
{
    oItem = CreateItemOnObject ("SilverArrows", oPC, 99);
}




}
