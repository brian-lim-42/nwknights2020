/*
  author: shadow_in_the_dark
  name:   nwk_dom_onexit
  date:   05/05/23

  OnExitArea Event of the domination area

*/
#include "nwk_const_teams"
#include "nwk_dom_inc"

void main()
{
    if ( GetIsActiveArea ( OBJECT_SELF ) )
    {
        object oPlayer = GetExitingObject ();
        HandleOnExitDominationAreaEvent ( oPlayer, OBJECT_SELF );
    }

}

