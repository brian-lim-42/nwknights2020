int getMapNumber()
{
    return GetLocalInt(GetModule(), "map_number");
}

string getMap()
{
    return IntToString(getMapNumber());
}

