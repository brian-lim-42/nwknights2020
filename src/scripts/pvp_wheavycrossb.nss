// NWTACTICS By Jhenne (tallonzek@hotmail.com)
// 07/07/02

void main()
{
object oPC = GetPCSpeaker();
//this script is used form "pvp_restock" too , there PC speaker
//won`t work so we need to say it`s OBJECT_SELF
if (!GetIsObjectValid(oPC))
    oPC=OBJECT_SELF;
string sTeam = GetLocalString(oPC, "team");
object oItem;


SetLocalInt(oPC,"bolts",1+GetLocalInt(oPC,"bolts"));

if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL)
{
oItem = CreateItemOnObject ("EvilBolts", oPC, 99);
oItem = CreateItemOnObject ("EvilHeavyCrossbow", oPC);
}
else if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
{
oItem = CreateItemOnObject ("GoodBolts", oPC, 99);
oItem = CreateItemOnObject ("GoodHeavyCrossbow", oPC);
}
else if ((sTeam == "GOLD") && (GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL))
{
oItem = CreateItemOnObject ("GoldBolts", oPC, 99);
oItem = CreateItemOnObject ("GoldHeavyCrossbow", oPC);
}
else if ((sTeam == "SILVER") && (GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL))
{
oItem = CreateItemOnObject ("SilverBolts", oPC, 99);
oItem = CreateItemOnObject ("SilverHeavyCrossbow", oPC);
}
AssignCommand (oPC, ActionEquipItem ( oItem, INVENTORY_SLOT_RIGHTHAND));

}

