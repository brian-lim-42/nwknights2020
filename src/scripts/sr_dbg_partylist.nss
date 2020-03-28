/*
  author: shadow_in_the_dark
  name:   sr_dbg__partylist
  date:   05/04/23

  Show the party membership of all active players

*/
#include "nwk_party"
void main()
{
    SendMessageToAllDMs ( "\n" + CreatePartyList () );
}
