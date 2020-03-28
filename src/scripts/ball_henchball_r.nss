#include "nwk_ball"

void main()
{
object oPC = GetPCSpeaker();

object LightBall = GetHenchman (oPC);
    if (GetTag(LightBall) == "LightBall")
         jumpFallenBall(LightBall) ;

RemoveHenchman(oPC);
ClearAllActions();


object  oBroadcast = GetFirstPC();
while(GetIsObjectValid(oBroadcast) == TRUE)
{
     SendMessageToPC(oBroadcast,"The Light Ball is now FREE!.");
     oBroadcast=GetNextPC();
}

//remove all bad effects
 effect eEffect = GetFirstEffect(oPC);

   while ( GetIsEffectValid(eEffect) == TRUE )
    {

        if (GetEffectSubType(eEffect)==SUBTYPE_EXTRAORDINARY)
               RemoveEffect(oPC,eEffect);

        eEffect = GetNextEffect(oPC);
    }










SetStandardFactionReputation (STANDARD_FACTION_COMMONER, 100, OBJECT_SELF);
}

