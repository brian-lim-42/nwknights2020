
int nwk_ball_team_bonus()   {return 1;}
int nwk_ball_player_bonus() {return 1;}
int nwk_ball_win_points()   {return 5;}  //5
int nwk_ball_close_to_end() {return 4;}
int nwk_ball_stopper_limit() {return 40;}


#include "nwk_maps"
#include "nwk_team_onscore"


/**
 * when players that has the BALL leaves/dies , the ball stays on the floor
 * next to him. if no one picks it in X seconds it jumps to the middle
 */
void jumpFallenBall(object oBall)
{
    int stopper_upper_limit=nwk_ball_stopper_limit();


    SetLocalInt(GetModule(), "ball_fallen_timer", stopper_upper_limit); //he doesn`t have it anymore
    int i;

    for (i=stopper_upper_limit;i>=0;i--)
     DelayCommand(IntToFloat(stopper_upper_limit-i),  ExecuteScript("ball_lonely_ball",oBall)  );

}




/////////////////////////////////////////////////////////////////////


int GetHasBall ( object oPC )
{
    object LightBall = GetHenchman (oPC);
    return (GetTag(LightBall) == "LightBall");

}


/* ball triger generic script.
 */
void ballGeneralTrigger(object PC,string pc_needed_color)
{


    object LightBall = GetHenchman (PC);

    if (GetTag(LightBall) == "LightBall")
    {
      if (GetLocalString(PC,"team")!=pc_needed_color)
      {
        SendMessageToPC(PC,"you are at the wrong goal , you Clutz");
        return;
      }

       RemoveHenchman(PC, LightBall);
       AssignCommand (LightBall, ClearAllActions());
       SetStandardFactionReputation (STANDARD_FACTION_COMMONER, 100, LightBall);
      // SpeakString("jumping to ball start way-point");
      //first save the map number(casue it will change in miliseconds) then use
      //the saved num for the fulltagname
      int curr_map=GetLocalInt(GetModule(),"map_number");
       AssignCommand(LightBall,ActionJumpToObject(GetObjectByTag(fullTagNameInMap("WP_LIGHTBALL",curr_map))));

    }
      else
        return;


////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int ball_team_bonus=    nwk_ball_team_bonus();
int ball_player_bonus=  nwk_ball_player_bonus();
int ball_win_points=    nwk_ball_win_points();
int ball_close_to_end=  nwk_ball_close_to_end();
//int total_maps_number=  nwk_total_maps_number();


string ball_bringer_team=GetLocalString(PC,"team");


// get the name of the PC that captured the ball
string sWinner = GetName(PC);
string sTeam;

// grab him as an object as well for scoring purposes
object oWinner = PC;

object oTrophy = CreateItemOnObject ("Trophy", oWinner);


// give the the player  bonus points
SetLocalInt(oWinner, "personalscore",
GetLocalInt(oWinner, "personalscore")+ball_player_bonus);

///////////effects addon
   effect eEffect = GetFirstEffect(oWinner);
   int type;

   while ( GetIsEffectValid(eEffect) == TRUE )
    {

        if ((GetEffectSubType(eEffect)==SUBTYPE_EXTRAORDINARY)&&
            (GetEffectType(eEffect)!=EFFECT_TYPE_ULTRAVISION)) //for MVP effect
                                                                //linked with Ultra
               RemoveEffect(oWinner,eEffect);

        eEffect = GetNextEffect(oWinner);
    }
////////////////////////////////
    calcuateMvp(oWinner);



   executeOnTeamPoint( PC,// scorerPC,
                      nwk_ball_win_points() ,
                      nwk_ball_team_bonus() ,   //team bonus
                      nwk_ball_team_bonus() // broadcastEveryPointAmount .like bonus
                                            // meaning every flag!
                     );

















}
