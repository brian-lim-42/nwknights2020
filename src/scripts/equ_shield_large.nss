void main()
{
object oPC = GetPCSpeaker();
string sTeam = GetLocalString(oPC, "team");
object oItem;
int nTumble = GetSkillRank (SKILL_TUMBLE, oPC);
int nLevelRDD = GetLevelByClass(CLASS_TYPE_DRAGONDISCIPLE , oPC);

if ((sTeam == "GOLD") && (nLevelRDD <=0))
{
oItem = CreateItemOnObject ("goldlarge4", oPC);
}
else if ((sTeam == "GOLD") && (nLevelRDD>=1)&&(nLevelRDD<5))
{
oItem = CreateItemOnObject ("goldlarge3", oPC);
}
else if ((sTeam == "GOLD") && (nLevelRDD>=5)&&(nLevelRDD<=7))
{
oItem = CreateItemOnObject ("goldlarge2", oPC);
}
else if ((sTeam == "GOLD") && (nLevelRDD>=8)&&(nLevelRDD<=9))
{
oItem = CreateItemOnObject ("goldlarge1", oPC);
}
else if ((sTeam == "GOLD") && (nLevelRDD==10))
{
oItem = CreateItemOnObject ("goldlarge0", oPC);
}
else if ((sTeam == "SILVER") && (nLevelRDD <=0))
{
oItem = CreateItemOnObject ("silverlarge4", oPC);
}
else if ((sTeam == "SILVER") && (nLevelRDD>=1)&&(nLevelRDD<5))
{
oItem = CreateItemOnObject ("silverlarge3", oPC);
}
else if ((sTeam == "SILVER") && (nLevelRDD>=5)&&(nLevelRDD<=7))
{
oItem = CreateItemOnObject ("silverlarge2", oPC);
}
else if ((sTeam == "SILVER") && (nLevelRDD>=8)&&(nLevelRDD<=9))
{
oItem = CreateItemOnObject ("silverlarge1", oPC);
}
else if ((sTeam == "SILVER") && (nLevelRDD==10))
{
oItem = CreateItemOnObject ("silverlarge0", oPC);
}

AssignCommand (oPC, ActionEquipItem ( oItem, INVENTORY_SLOT_CHEST));

}
