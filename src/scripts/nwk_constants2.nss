//nwk_constant2 - NO DEPENCY ALLOWED HER (no include) IT IS ROOT HIERARCHY

string fullTagNameInMap(string tag,int map_number)
{
    int n1=map_number;
    string result1=IntToString(n1);
    result1=InsertString(result1,tag,0);
    return (result1);
}

//returns the full name which include map number in the tags end
//for example:in: SANC_GOLD , out:SANC_GOLD_MAP1
string mapFullTagName(string tag)
{
    int n1=GetLocalInt(GetModule(),"map_number");
    string result  = fullTagNameInMap(tag,n1);
    return result;
}


