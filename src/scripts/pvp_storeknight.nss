void main()
{
    object oPC = GetPCSpeaker();
    string team= GetLocalString(oPC,"team");
    object oSStore;
    object oGStore;
    if ( GetLevelByClass ( CLASS_TYPE_PALEMASTER, oPC ) )
    {
        oGStore = GetObjectByTag("GoldenFlameKnightStorePM");
        oSStore = GetObjectByTag("SilveryIceKnightStorePM");
    }
    else
    {
        oGStore = GetObjectByTag("GKnightStore");
        oSStore = GetObjectByTag("SKnightStore");
    }
    if (team=="SILVER")
    {
        if ( ! GetIsObjectValid ( oSStore ) )
        {
            SpeakString ( "Hm, no store for this class available." );
            WriteTimestampedLogEntry ( "##ERROR - Knight Shop: Invalid object for silver shop" );
        } else
        {
            //WriteTimestampedLogEntry ( "##DEBUG - Knight Shop: open silver shop " + GetName ( oSStore ) );
        }
        OpenStore(oSStore, GetPCSpeaker());

    }
    else if (team=="GOLD")
    {
        if ( ! GetIsObjectValid ( oGStore ) )
        {
            SpeakString ( "Hm, no store for this class available." );
            WriteTimestampedLogEntry ( "##ERROR - Knight Shop: Invalid object for gold shop" );
        } else
        {
            //WriteTimestampedLogEntry ( "##DEBUG - Knight Shop: open gold shop " + GetName ( oGStore ) );
        }
        OpenStore(oGStore, GetPCSpeaker());
    }
}
