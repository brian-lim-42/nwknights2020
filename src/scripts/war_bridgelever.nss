// This script will open the associated bridge_gate. It will determine which gate to
// open according to the suffix of the lever (The OBJECT_SELF of the script) .
// for example: lever name = "LEVER@2@3" (The second lever(2) in map number 3)
// then the gate which will be opened is "BRIDGE_GATE@2_3"
// a lever may open MULTIPLE doors , just call them by this syntax:
//replace all @ with double '_' . places which was one underscore reamins only one.
// "BRIDGE_GATE"+"@"+lever_num+[optional:"_"+gate_num]+ "@" + map_num
// and it will open all gates no matter what the gate_num is!
// For example: with the optionl "BRIDGE_GATE@2_1@3" "BRIDGE_GATE@2_2@3" ... "BRIDGE_GATE@2_99@3"
// Attention: they must be assecnding (1,2,3...) when we get one which is not valid , we stop .
// so if you put (1,2,5) the 5 will not be found!
// Without it: "BRIDGE_GATE@2@3"



#include "nwk_constants"
#include "nwk_debug"

/**
 * unlocks the gate with animation and sound . puts a delay command to relock it again.
 * @param oGate must be a valid object
 */
void unlockGate(object oGate)
{
    SetLocked (oGate, FALSE);
    AssignCommand(oGate,ActionOpenDoor(oGate));
    PlayAnimation (ANIMATION_PLACEABLE_ACTIVATE);
    PlaySound ("as_dr_woodvlgop2");
    DelayCommand(13.0, SetLocked (oGate, TRUE));
    DelayCommand(13.0, AssignCommand(oGate,ActionCloseDoor(oGate)));
    DelayCommand(13.0, PlayAnimation (ANIMATION_PLACEABLE_DEACTIVATE));
    DelayCommand(13.0, PlaySound ("as_dr_woodvlgop2"));
}


void main()
{
    string leverTag = GetTag(OBJECT_SELF);  // LEVER__2__3
    int leverTagLength = GetStringLength(leverTag); // length=11
    int positionOfFirstStrudel = FindSubString(leverTag,"__"); // position=5 (5-6starting in zero)
    //get the substring - "2__3" . start position+2(7) count= length - position - 2 = 11 -5 -2 =4
    string leverTagSufix = GetSubString(    leverTag,
                        positionOfFirstStrudel+2,
                        leverTagLength - positionOfFirstStrudel - 2);
    int positionOfSecondStrudel= FindSubString(leverTagSufix,"__"); // return 1
    //all of this was done to get exacly the lever_num - in  our case [...__] "2" [__3]
    string numberOfLeverAsString = GetSubString (   leverTagSufix,
                        0,
                        positionOfSecondStrudel  ); //-> "1"
    debugSpeakString(OBJECT_SELF,"The lever number is:" + numberOfLeverAsString);

    //good . now we got a string representing the number . can be "2" , can be "87".
    //we will loop upon all the options to the gates name.
    // 1. simple name , without the _ and gate number.
    // 2. complex name , start with _1 and increase until the first unvalid.
    object oGate;
    string sGate;

    sGate = mapFullTagName("BRIDGE_GATE"+"__"+numberOfLeverAsString + "__");
    debugSpeakString(OBJECT_SELF,sGate);
    oGate = GetObjectByTag(sGate);
    if (GetIsObjectValid(oGate)==TRUE)
    {
        unlockGate(oGate);
    }

    //now loop through all numbers , start with _1
    int i=1;
    sGate = mapFullTagName("BRIDGE_GATE"+"__"+numberOfLeverAsString  +"_"+ IntToString(i)+ "__");
    debugSpeakString(OBJECT_SELF,sGate);
    oGate= GetObjectByTag(sGate);
    while (GetIsObjectValid(oGate))
    {
        unlockGate(oGate);
        i++;
        sGate = mapFullTagName("BRIDGE_GATE"+"__"+numberOfLeverAsString  +"_"+ IntToString(i)+ "__");
        debugSpeakString(OBJECT_SELF,sGate);
        oGate= GetObjectByTag(sGate);
    }

}
