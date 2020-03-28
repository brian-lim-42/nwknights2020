#include "nwk_constants"
#include "nwk_king"

void main()
{
  object oChair = OBJECT_SELF;
  object oKing;
  if(!GetIsObjectValid(GetSittingCreature(oChair)))
  {
    AssignCommand(GetLastUsedBy(), ActionSit(oChair));
    int usedCounter = GetLocalInt(oChair,VARNAME_USE_COUNTER);
    SetLocalInt(oChair,VARNAME_USE_COUNTER,usedCounter+1);
    oKing=GetLastUsedBy();
    string sKingTeam =GetLocalString(oKing, "team");
    string sKing = GetName(oKing);

    if (sKingTeam=="GOLD")
    {
        CreateObject(OBJECT_TYPE_PLACEABLE,"solorange",GetLocation(oChair));
//        CreateObject(OBJECT_TYPE_PLACEABLE,"solorange",GetLocation(oChair));
        DestroyMultipleObjects("KingShaftofLightWhite",0.0) ;
    }
    else
    {
        CreateObject(OBJECT_TYPE_PLACEABLE,"solwhite",GetLocation(oChair));
//        CreateObject(OBJECT_TYPE_PLACEABLE,"solwhite",GetLocation(oChair));
        DestroyMultipleObjects("KingShaftofLightOrange",0.0) ;
    }

    ApplyKingNerfs ( oKing );



    object oBroadcast = GetFirstPC();
    //broadcast only every 10 points
    while (GetIsObjectValid(oBroadcast) == TRUE)
    {
          SendMessageToPC(oBroadcast, sKing+" from the " +longTeamName(sKingTeam) + " team is King of the Hill!  ");
          oBroadcast=GetNextPC();
    }



  }
}
