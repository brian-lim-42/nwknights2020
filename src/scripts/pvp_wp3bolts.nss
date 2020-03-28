
void main()
{
object oPC = OBJECT_SELF;
string sTeam = GetLocalString(oPC, "team");
object oItem;


//SetLocalInt(oPC,"arrows",GetLocalInt(oPC,"arrows")+1);


if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL)
{
oItem = CreateItemOnObject ("EvilBolts", oPC, 99);

}
else if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
{
oItem = CreateItemOnObject ("GoodBolts", oPC, 99);

}
else if ((sTeam == "GOLD") && (GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL))
{
oItem = CreateItemOnObject ("GoldBolts", oPC, 99);

}
else if ((sTeam == "SILVER") && (GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL))
{
oItem = CreateItemOnObject ("SilverBolts", oPC, 99);

}

}

