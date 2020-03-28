/*
  author: shadow_in_the_dark
  name:   sr_dump_char
  date:   05/03/12

  dump the char information to the logfile.

*/
#include "sr_inc_dump"

void main()
{
    object oTarget = OBJECT_SELF;
    string sMessage = CreateDumpMessage ( oTarget );

    WriteTimestampedLogEntry ( "\n" + sMessage );

}

