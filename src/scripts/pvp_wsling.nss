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

SetLocalInt(oPC,"bullets",1+GetLocalInt(oPC,"bullets"));

if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL)
{
oItem = CreateItemOnObject ("EvilSling", oPC);
oItem = CreateItemOnObject ("EvilBullets", oPC, 99);
}
else if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
{
oItem = CreateItemOnObject ("GoodSling", oPC);
oItem = CreateItemOnObject ("GoodBullets", oPC, 99);
}
else if ((sTeam == "GOLD") && (GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL))
{
oItem = CreateItemOnObject ("GoldSling", oPC);
oItem = CreateItemOnObject ("GoldBullets", oPC, 99);
}
else if ((sTeam == "SILVER") && (GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL))
{
oItem = CreateItemOnObject ("SilverSling", oPC);
oItem = CreateItemOnObject ("SilverBullets", oPC, 99);
}
AssignCommand (oPC, ActionEquipItem ( oItem, INVENTORY_SLOT_RIGHTHAND));

}

