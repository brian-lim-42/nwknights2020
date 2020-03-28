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

//get how many he got already , and give him more
int curr_num= GetLocalInt(oPC,"shurikens");
SetLocalInt(oPC,"shurikens",curr_num+1);

if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_EVIL)
{
oItem = CreateItemOnObject ("EvilShuriken", oPC, 50);
}
else if (GetAlignmentGoodEvil(oPC) == ALIGNMENT_GOOD)
{
oItem = CreateItemOnObject ("GoodShuriken", oPC, 50);
}
else if ((sTeam == "GOLD") && (GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL))
{
oItem = CreateItemOnObject ("GoldShuriken", oPC, 50);
}
else if ((sTeam == "SILVER") && (GetAlignmentGoodEvil(oPC) == ALIGNMENT_NEUTRAL))
{
oItem = CreateItemOnObject ("SilverShuriken", oPC, 50);
}
AssignCommand (oPC, ActionEquipItem ( oItem, INVENTORY_SLOT_RIGHTHAND));

}

