void main()
{
    object oPC = GetPCSpeaker();
    string team= GetLocalString(oPC,"team");
    object oSStore;
    object oGStore;
    if ( GetLevelByClass ( CLASS_TYPE_PALEMASTER, oPC ) )
    {
        oSStore = GetObjectByTag("SilveryIceTrophyExchangePM");
        oGStore = GetObjectByTag("GoldenFlameTrophyExchangePM");
    }
    else
    {
        oSStore = GetObjectByTag("SilveryIceTrophyExchange");
        oGStore = GetObjectByTag("GoldenFlameTrophyExchange");
    }

    if (team=="SILVER")
    {
        OpenStore(oSStore, GetPCSpeaker());
    }
    else if (team=="GOLD")
    {
        OpenStore(oGStore, GetPCSpeaker());
    }

}
