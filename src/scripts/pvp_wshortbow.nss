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

SetLocalInt(oPC,"arrows",1+GetLocalInt(oPC,"arrows"));

if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL)
{
oItem = CreateItemOnObject ("EvilArrows", oPC, 99);
oItem = CreateItemOnObject ("EvilShortbow", oPC);
}
else if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
{
oItem = CreateItemOnObject ("GoodArrows", oPC, 99);
oItem = CreateItemOnObject ("GoodShortbow", oPC);
}
else if ((sTeam == "GOLD") && (GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL))
{
oItem = CreateItemOnObject ("GoldArrows", oPC, 99);
oItem = CreateItemOnObject ("GoldShortbow", oPC);
}
else if ((sTeam == "SILVER") && (GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL))
{
oItem = CreateItemOnObject ("SilverArrows", oPC, 99);
oItem = CreateItemOnObject ("SilverShortbow", oPC);
}
AssignCommand (oPC, ActionEquipItem ( oItem, INVENTORY_SLOT_RIGHTHAND));

}

