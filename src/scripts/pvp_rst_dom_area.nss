/*
  author: shadow_in_the_dark
  name:   pvp_rst_dom_area
  date:   05/05/31

  Reset the domination areas forn a player

  Call is seperatet in single script to avoid to much statement error

*/
#include "nwk_dom_inc"
void main()
{
    ResetDominationAreaForPlayer ( OBJECT_SELF );
}

