#include "nw_i0_generic"

#include "sr_mny_trade_inc"

void main()
{
object oPC = GetLastSpeaker();
   if (!adjustAndCheck(GetPCSpeaker(), 5000) )
    {
    ActionPauseConversation();
    SpeakString ("You cannot afford this purchase", TALKVOLUME_TALK);
    }
   else if (GetGold(GetPCSpeaker()) >= 5000)
    {
    location lDest;
    lDest = GetLocation (oPC);
    string sTeam = GetLocalString(oPC, "team");
    TakeGoldFromCreature (5000, oPC, TRUE);
    adjustAllowedMoney ( oPC, GetGold(oPC) - 5000 );

    object oHenchMan = CreateObject(OBJECT_TYPE_CREATURE,"archermercenary",lDest,FALSE);
    AddHenchman (oPC, oHenchMan);
    AssignCommand (oHenchMan, SetAssociateState(NW_ASC_USE_RANGED_WEAPON));
    AssignCommand (oHenchMan, ClearAllActions());
    AssignCommand (oHenchMan, EquipAppropriateWeapons(GetMaster()));
    }
}
