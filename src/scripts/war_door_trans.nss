/*
  author: shadow_in_the_dark
  name:   war_door_trans
  date:   05/03/20

  Transitions script which takes pick familiars and summons up.

*/
#include "nwk_constants"
void main()
{
    object oPlayer = GetClickingObject();
    location lDest;


    lDest = GetLocation(GetTransitionTarget(OBJECT_SELF));
    AssignCommand(oPlayer, ActionJumpToLocation(lDest));
    JumpHenchmen(oPlayer, lDest, 1);


}


