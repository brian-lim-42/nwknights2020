#include "nwk_mvp"
void main()
{
object oPC=GetLastPCRested();
ExecuteScript("pvp_nerf_monks",oPC);
quickMvpCheck(oPC);
}
