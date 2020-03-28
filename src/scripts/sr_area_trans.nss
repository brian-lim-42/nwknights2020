/*
  author: shadow_in_the_dark
  name:   sr_area_trans
  date:   2007-10-13

  Area transition to the target location provided as local string

*/
const string TARGET_LOCATION = "target";
void main()
{
    object oPC = GetLastUsedBy ();
    object oTarget;
    location lTarget;
    oTarget = GetWaypointByTag ( GetLocalString ( OBJECT_SELF, TARGET_LOCATION ) );
    if ( GetIsObjectValid ( oTarget ) )
    {
        if ( GetArea ( oTarget ) == GetArea ( OBJECT_SELF ) )
        {
            lTarget = GetLocation(oTarget);
            DelayCommand(1.0, AssignCommand(oPC, ActionJumpToLocation(lTarget)));
        } else
        {
            WriteTimestampedLogEntry ( "ERROR : transport target of portal: " +
                                       GetName ( GetArea ( OBJECT_SELF ) ) + "/" +
                                       GetName ( OBJECT_SELF ) + " in different area" );
        }
    }
    else
    {
        WriteTimestampedLogEntry ( "ERROR : No transport target for portal: " +
                                   GetName ( GetArea ( OBJECT_SELF ) ) + "/" +
                                   GetName ( OBJECT_SELF ) );
    }
}

