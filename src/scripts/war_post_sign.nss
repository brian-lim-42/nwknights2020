//on post signs

#include "nwk_maps"
#include "nwk_mvp"






void main()
{
    object PC=GetLastUsedBy();
    object sign=OBJECT_SELF;

    string silver_score=IntToString(GetLocalInt(GetModule(),"silverscore"));
    string gold_score=IntToString(GetLocalInt(GetModule(),"goldscore"));

    string other_team,pc_team=GetLocalString(PC,"team");
    string pc_team_score,other_team_score;

    if (pc_team=="SILVER")
    {
        pc_team_score=silver_score;
        other_team_score=gold_score;
        other_team="GOLD";
    }
    else if (pc_team=="GOLD")
    {
        pc_team_score=gold_score;
        other_team_score=silver_score;
        other_team="SILVER";
    }

    int total_score=GetLocalInt(PC,"kill_points")+ MVP_TEAM_POINT_VALUE * GetLocalInt(PC,"personalscore") ;
    string kills=IntToString(GetLocalInt(PC,"kill_points"));
    string goals=IntToString(GetLocalInt(PC,"personalscore"));
    string dyings=IntToString(GetLocalInt(PC,"dying_points"));


    //check flag status , if it is a flag map
    string flagStatusReport="";
    if ( getMapType(GetLocalInt(GetModule(),"map_number"))==MAP_TYPE_FLAG )
    {
        flagStatusReport = getFlagsStatusReport() ;
    }





   SpeakString("\ \n"+" Team Points :  "+goals+
                               "\nKill Points :  "+kills+
                               "\nMVP  Points :  "+IntToString(total_score)+
                        "\nThe score stands at: \n" +longTeamName(pc_team) +" : "+
                        pc_team_score + " points \n"+
                        longTeamName(other_team) +" : "+other_team_score+
                        " points.\n" + flagStatusReport );





}
