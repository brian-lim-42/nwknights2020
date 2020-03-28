#include "nwk_constants"

void main()
{
    object oPlayer;

    switch ( GetObjectType ( OBJECT_SELF ) )
    {
        case OBJECT_TYPE_PLACEABLE :
            oPlayer = GetPlaceableLastClickedBy ();
            break;
        default :
            oPlayer = GetClickingObject();
    }
    float fDistance = GetDistanceToObject ( oPlayer );
    // check if distance between oPlayer and OBJECT_SELF is less than 3.0m
    if ( fDistance <= 3.0 )
    {
        location lDest;

        lDest = GetLocation(GetObjectByTag(mapFullTagName("ESCAPE_GOLD")));
        AssignCommand(oPlayer, ActionJumpToLocation(lDest));
        JumpHenchmen(oPlayer, lDest, 1);
    }
}
