// NWTACTICS By Jhenne (tallonzek@hotmail.com)
// 07/07/02

void main()
{
object oPC = GetPCSpeaker();
string sTeam = GetLocalString(oPC, "team");
object oItem;

if (sTeam == "GOLD")
{
oItem = CreateItemOnObject ("goldchainmail", oPC);
}
else if(sTeam == "SILVER")
{
oItem = CreateItemOnObject ("silverchainmail", oPC);
}
AssignCommand (oPC, ActionEquipItem ( oItem, INVENTORY_SLOT_CHEST));

}
