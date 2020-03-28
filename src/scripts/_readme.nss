/*
README

Administration Rights:

You can register an account as Administrator. An Administrator is a normal
Player char with the following additional rights:
- Sanctuary: boot players by talk to the LogMen
- Sanctuary: dump player information to logfile by talk to the LogMen
- Sanctuary: reboot mod by pulling the chain
- NWKnights (Version ... ): change the server website by talk to the guardian

To register an account log in with the DM Client and talk to the Entry Guardian.
After that you have to log in with a player char and tell the shared secret to the
guardian (voice driven)

*/
//shared secret
const string sListenPatternDMregistration = "enterpasswordhere"; //set your own password

/*
Website change and boot players are voice driven and work only with normal player
char or with a visible DM char.


*/

/*
Coding Rule: * not complete*


- Money Trading
Every change on the amount of money a player has (e.g. if he buys something) has
to be monitored by the money trade system ("sr_mny_trade_inc")




*/
