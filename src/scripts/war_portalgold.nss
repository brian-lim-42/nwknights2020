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
    string sTeam = GetLocalString (oPlayer, "team");
    location lDest;

    // check if distance between oPlayer and OBJECT_SELF is less than 3.0m
    float fDistance = GetDistanceToObject ( oPlayer );
    if ( fDistance <= 3.0 )
    {
        lDest = GetLocation(GetObjectByTag(mapFullTagName("GOLD_OUT")));
        if (sTeam == "GOLD"){
            AssignCommand(oPlayer, PlaySound("as_mg_telepin1"));
            AssignCommand(oPlayer, ActionJumpToLocation(lDest));
            JumpHenchmen(oPlayer, lDest, 1);
        }
    }
}
