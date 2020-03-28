#include "nwk_constants"

void main()
{
    object old_area=OBJECT_SELF;

    //SpeakString("old area is:"+GetName(old_area),TALKVOLUME_SHOUT);
    object oPC=GetFirstPC();

    while (GetIsPC(oPC))
    {
  //      SendMessageToPC(oPC,GetName (oPC) +"is now in area:"+ GetName(GetArea (oPC)));


        if (GetArea (oPC)==old_area)     //he is still back there
              NewMap(oPC);

        oPC=GetNextPC();
    }
}
