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
    // check if distance between oPlayer and OBJECT_SELF is less than 3.0m
    float fDistance = GetDistanceToObject ( oPlayer );
    if ( fDistance <= 3.0 )
    {

        string sTeam = GetLocalString (oPlayer, "team");

        location lDest;

        lDest = GetLocation(GetObjectByTag(mapFullTagName("SILVER_OUT")));
        if (sTeam == "SILVER"){
            AssignCommand(oPlayer, PlaySound("as_mg_telepin1"));
            AssignCommand(oPlayer, ActionJumpToLocation(lDest));
            JumpHenchmen(oPlayer, lDest, 1);
        }
    }
}
