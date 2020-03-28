// NWTACTICS By Jhenne (tallonzek@hotmail.com)
// 07/07/02

void main()
{
object oPC = GetPCSpeaker();
string sTeam = GetLocalString(oPC, "team");
object oItem;

if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL)
{
oItem = CreateItemOnObject ("EvilLongsword", oPC);
}
else if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
{
oItem = CreateItemOnObject ("GoodLongsword", oPC);
}
else if ((sTeam == "GOLD") && (GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL))
{
oItem = CreateItemOnObject ("GoldLongsword", oPC);
}
else if ((sTeam == "SILVER") && (GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL))
{
oItem = CreateItemOnObject ("SilverLongsword", oPC);
}
AssignCommand (oPC, ActionEquipItem ( oItem, INVENTORY_SLOT_RIGHTHAND));

}

