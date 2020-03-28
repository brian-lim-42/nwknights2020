void main()
{
    //destory anything which was on other PC
    if (GetIsPC(GetModuleItemAcquiredFrom()))
    {
        DestroyObject(GetModuleItemAcquired());
    }
}
