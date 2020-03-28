// NWTACTICS By Jhenne (tallonzek@hotmail.com)
// 07/07/02

void main()
{
object oPC = GetPCSpeaker();
//this script is used form "pvp_restock" too , there PC speaker
//won`t work so we need to say it`s OBJECT_SELF
if (!GetIsObjectValid(oPC))
    oPC=OBJECT_SELF;
//else //talking to an officer
//{
    //get how many axes he got already , and give him more (when officer does
    //the restock , this counts how many times did he do it)
    //deleted
//}
SetLocalInt(oPC,"throwing_axes",GetLocalInt(oPC,"throwing_axes")+1);
string sTeam = GetLocalString(oPC, "team");
object oItem;



if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL)
{
oItem = CreateItemOnObject ("EvilThrowingAxe", oPC, 15);
}
else if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
{
oItem = CreateItemOnObject ("GoodThrowingAxe", oPC, 15);
}
else if ((sTeam == "GOLD") && (GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL))
{
oItem = CreateItemOnObject ("GoldThrowingAxe", oPC, 15);
}
else if ((sTeam == "SILVER") && (GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL))
{
oItem = CreateItemOnObject ("SilverThrowingAxe", oPC, 15);
}
AssignCommand (oPC, ActionEquipItem ( oItem, INVENTORY_SLOT_RIGHTHAND));

}

