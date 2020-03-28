
#include "nwk_constants"

/* only certain team can pass  */
void main()
{
    //to change when giving other teams
    string door_color="GOLD";
    object door=OBJECT_SELF;
    string door_name=GetTag(door);

    //example:GOLD_RIGHTDOOR_OUT
    string where_to="WP_"+door_color+"_"+door_name;



    object oPlayer = GetClickingObject();
      location lDest;

    if (GetLocalString(oPlayer,"team")==door_color)
    {
        lDest = GetLocation(GetObjectByTag(mapFullTagName(where_to)));
        AssignCommand(oPlayer, ActionJumpToLocation(lDest));
        JumpHenchmen(oPlayer, lDest, 1);
    }

}

