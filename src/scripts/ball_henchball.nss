#include "nwk_constants"
#include "nwk_nerf_pc"

void main()
{
object oPC = GetPCSpeaker();
object oHenchMan = GetHenchman (oPC);
if ((GetHenchman (oPC) == OBJECT_INVALID) || (GetTag(oHenchMan) == "LightBall"))
{
string sTeam = GetLocalString(oPC, "team");

if ((sTeam == "SILVER") ||(sTeam == "GOLD") )
{
    AddHenchman (oPC);
}



object  oBroadcast = GetFirstPC();
while(GetIsObjectValid(oBroadcast) == TRUE)
{
     SendMessageToPC(oBroadcast,"The Light Ball is under "+longTeamName(sTeam)+ " control.");
     oBroadcast=GetNextPC();
}

//nerf speed and invisibily
nerfPc(oPC);

//to init the lonely count-down
SetLocalInt(GetModule(), "ball_fallen_timer",-5); //init the value

ActionForceFollowObject (oPC, 0.5);
}
else
{
SpeakString ("You may not carry the Light Ball while you have a Henchman");
}
}
