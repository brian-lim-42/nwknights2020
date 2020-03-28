// bug in level down of RDD - attributes will not removed
// returns true if char has at least one level in RDD
int StartingConditional()
{
    int iResult;

    iResult = GetLevelByClass ( CLASS_TYPE_DRAGON_DISCIPLE, GetPCSpeaker() );
    return iResult;
}
