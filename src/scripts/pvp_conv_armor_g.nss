//::///////////////////////////////////////////////
//:: SetListeningPatterns
//:: NW_C2_DEFAULT4
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines the course of action to be taken
    by the generic script after dialogue or a
    shout is initiated.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 24, 2001
//:://////////////////////////////////////////////

#include "NW_I0_GENERIC"

void main()
{
    int nMatch = GetListenPatternNumber();
    object oShouter = GetLastSpeaker();
    object oIntruder;

    if (nMatch == -1 && GetCommandable(OBJECT_SELF))
    {
        ClearAllActions();
        object oAlternative = GetObjectByTag ("GoldArmor01");
        object oAlternati02 = GetObjectByTag ("GoldArmor02");
        if ((IsInConversation(oAlternative)) && (IsInConversation(oAlternati02)))
        {
        BeginConversation();
        }
        else if (IsInConversation(oAlternative))
        {
        AssignCommand (oShouter, ActionStartConversation(oAlternati02, "goldarmory"));
        }
        else
        {
        AssignCommand (oShouter, ActionStartConversation(oAlternative, "goldarmory"));
        }
        SetFacingPoint (GetPosition (oShouter));
        PlaySound ("vs_nintdevm_hi");
        ActionPlayAnimation (ANIMATION_FIREFORGET_GREETING);
    }
    else
    if(nMatch != -1 && GetIsObjectValid(oShouter) && !GetIsPC(oShouter) && GetIsFriend(oShouter))
    {
        if(nMatch == 4)
        {
            oIntruder = GetLocalObject(oShouter, "NW_BLOCKER_INTRUDER");
        }
        else if (nMatch == 5)
        {
            oIntruder = GetLastHostileActor(oShouter);
            if(!GetIsObjectValid(oIntruder))
            {
                oIntruder = GetAttemptedAttackTarget();
                if(!GetIsObjectValid(oIntruder))
                {
                    oIntruder = GetAttemptedSpellTarget();
                    if(!GetIsObjectValid(oIntruder))
                    {
                        oIntruder = OBJECT_INVALID;
                    }
                }
            }
        }
        RespondToShout(oShouter, nMatch, oIntruder);
    }


    if(GetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1004));
    }
}
