int StartingConditional()
{
    int iResult;
    object oPC = GetPCSpeaker();

    if (GetHitDice(oPC) == 20)
    {
        if (!GetObjectSeen(oPC, OBJECT_SELF))
        {
            DelayCommand(5.0,BootPC(oPC));
            SendMessageToPC(oPC, "testing invisible skin anti cheat code. Please report any abnormal boot to the boards at nwtactics.com!!");
            return FALSE;
        }
         else
            return TRUE;

    }
    else{
        SendMessageToPC(oPC, "You need to build up your character to level 20 first!");
        return FALSE;
    }



}
