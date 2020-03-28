void main()
{
    object oItem = OBJECT_SELF;
    object oGainer = GetItemPossessor (oItem);

    if (oGainer != GetLocalObject (oItem, "owner"))
    {
        DestroyObject(oItem);

    }
}
