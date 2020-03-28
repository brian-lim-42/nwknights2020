void main()
{

    object oPC = GetLastSpeaker();

    object oEquip = GetFirstItemInInventory(oPC);

    string  sTag;

     while(GetIsObjectValid(oEquip))
     {
      sTag = GetTag(oEquip);
      if ((GetStringLeft(sTag,4)=="NW_I")||(GetStringLeft(sTag,5)=="X1_IT")||(GetStringLeft(sTag,5)=="X2_IT"))
          DestroyObject(oEquip);

      oEquip = GetNextItemInInventory(oPC);
      }

}
