void main()
{
object oPC = GetPCSpeaker();
string sTeam = GetLocalString(oPC, "team");
object oItem;
int nTumble = GetSkillRank (SKILL_TUMBLE, oPC);
int nLevelRDD = GetLevelByClass(CLASS_TYPE_DRAGONDISCIPLE , oPC);

if ((sTeam == "GOLD") && (nLevelRDD <=0))
{
oItem = CreateItemOnObject ("goldsmall4", oPC);
}
else if ((sTeam == "GOLD") && (nLevelRDD>=1)&&(nLevelRDD<5))
{
oItem = CreateItemOnObject ("goldsmall3", oPC);
}
else if ((sTeam == "GOLD") && (nLevelRDD>=5)&&(nLevelRDD<=7))
{
oItem = CreateItemOnObject ("goldsmall2", oPC);
}
else if ((sTeam == "GOLD") && (nLevelRDD>=8)&&(nLevelRDD<=9))
{
oItem = CreateItemOnObject ("goldsmall1", oPC);
}
else if ((sTeam == "GOLD") && (nLevelRDD==10))
{
oItem = CreateItemOnObject ("goldsmall0", oPC);
}
else if ((sTeam == "SILVER") && (nLevelRDD <=0))
{
oItem = CreateItemOnObject ("silversmall4", oPC);
}
else if ((sTeam == "SILVER") && (nLevelRDD>=1)&&(nLevelRDD<5))
{
oItem = CreateItemOnObject ("silversmall3", oPC);
}
else if ((sTeam == "SILVER") && (nLevelRDD>=5)&&(nLevelRDD<=7))
{
oItem = CreateItemOnObject ("silversmall2", oPC);
}
else if ((sTeam == "SILVER") && (nLevelRDD>=8)&&(nLevelRDD<=9))
{
oItem = CreateItemOnObject ("silversmall1", oPC);
}
else if ((sTeam == "SILVER") && (nLevelRDD==10))
{
oItem = CreateItemOnObject ("silversmall0", oPC);
}

AssignCommand (oPC, ActionEquipItem ( oItem, INVENTORY_SLOT_CHEST));

}
