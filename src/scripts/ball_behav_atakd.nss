void main()
{
object oMaster = GetMaster ();
object oAttacker = GetLastAttacker ();

PlaySound ("c_bat_yes");
SendMessageToPC (oAttacker, "the LightBall cannot be hurt");

if (GetIsObjectValid (oMaster) == TRUE)
{
ActionForceFollowObject (oMaster);
}

}
