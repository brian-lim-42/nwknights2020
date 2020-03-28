// NWTACTICS By Jhenne (tallonzek@hotmail.com)
// 07/07/02

void main()
{
object oPC = GetPCSpeaker();
string sTeam = GetLocalString(oPC, "team");
object oItem;

if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL)
{
oItem = CreateItemOnObject ("EvilHeavyFlail", oPC);
}
else if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
{
oItem = CreateItemOnObject ("GoodHeavyFlail", oPC);
}
else if ((sTeam == "GOLD") && (GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL))
{
oItem = CreateItemOnObject ("GoldHeavyFlail", oPC);
}
else if ((sTeam == "SILVER") && (GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL))
{
oItem = CreateItemOnObject ("SilverHeavyFlail", oPC);
}
AssignCommand (oPC, ActionEquipItem ( oItem, INVENTORY_SLOT_RIGHTHAND));

}

