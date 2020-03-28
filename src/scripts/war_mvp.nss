#include "nwk_constants"
//#include "nwk_mvp"





void main()
{

   object oMvp,PC=GetLastUsedBy();
   string   name,player_name;
   string message="";
   int   score,i  ;




   for (i=1;i<=MAX_MVP;i++)
   {
        name=getMvpName(i);
        //get player name , if it`s a PC
        oMvp=getMvpObj(i);
        if (GetIsPC(oMvp))
            player_name=GetPCPlayerName(oMvp);
        else
            player_name="NWKnight NPC" ;

        score=getMvpScore(i);

        if ((name!="") && (score>0))
        {
            message=message+ "\n" +IntToString(i)+ "):   "+name+" ["+ player_name+"]"+
                    " with "+IntToString(score)+" points.";
        }
        else
            break;
    }
    SpeakString(message);

}



