void main()
{
object oPC = GetPCSpeaker();
string sTeam = GetLocalString(oPC, "team");
object oItem;
int nTumble = GetSkillRank (SKILL_TUMBLE, oPC);
int nLevelRDD = GetLevelByClass(CLASS_TYPE_DRAGONDISCIPLE , oPC);

if ((sTeam == "GOLD") && (nLevelRDD <=0))
{
oItem = CreateItemOnObject ("goldtower4", oPC);
}
else if ((sTeam == "GOLD") && (nLevelRDD>=1)&&(nLevelRDD<5))
{
oItem = CreateItemOnObject ("goldtower3", oPC);
}
else if ((sTeam == "GOLD") && (nLevelRDD>=5)&&(nLevelRDD<=7))
{
oItem = CreateItemOnObject ("goldtower2", oPC);
}
else if ((sTeam == "GOLD") && (nLevelRDD>=8)&&(nLevelRDD<=9))
{
oItem = CreateItemOnObject ("goldtower1", oPC);
}
else if ((sTeam == "GOLD") && (nLevelRDD==10))
{
oItem = CreateItemOnObject ("goldtower0", oPC);
}
else if ((sTeam == "SILVER") && (nLevelRDD <=0))
{
oItem = CreateItemOnObject ("silvertower4", oPC);
}
else if ((sTeam == "SILVER") && (nLevelRDD>=1)&&(nLevelRDD<5))
{
oItem = CreateItemOnObject ("silvertower3", oPC);
}
else if ((sTeam == "SILVER") && (nLevelRDD>=5)&&(nLevelRDD<=7))
{
oItem = CreateItemOnObject ("silvertower2", oPC);
}
else if ((sTeam == "SILVER") && (nLevelRDD>=8)&&(nLevelRDD<=9))
{
oItem = CreateItemOnObject ("silvertower1", oPC);
}
else if ((sTeam == "SILVER") && (nLevelRDD==10))
{
oItem = CreateItemOnObject ("silvertower0", oPC);
}

AssignCommand (oPC, ActionEquipItem ( oItem, INVENTORY_SLOT_CHEST));


}
