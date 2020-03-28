int StartingConditional()
{
    int iResult;

    iResult = (GetLevelByClass (CLASS_TYPE_WIZARD, GetPCSpeaker()) >= 1);
    return iResult;
}
