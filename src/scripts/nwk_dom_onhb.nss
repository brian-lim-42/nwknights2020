/*
  author: shadow_in_the_dark
  name:   nwk_dom_onhb
  date:   05/05/23

  On heartbeat script for the Domination map type.

*/
#include "nwk_team_onscore"
#include "nwk_dom_inc"

void main()
{
//    WriteTimestampedLogEntry ( "\n**************************************************************************************" +
//                               "\n*** NWK DEBUG: Domination Area Heartbeat" );
    // get map number
    int nMap = GetLocalInt ( GetModule (), "map_number" );

    object oArea = GetArea ( OBJECT_SELF );
    int nNumberOfSpots = GetLocalInt ( oArea, sNumberOfDomArea );
    int nDomArea;
    for ( nDomArea = 1; nDomArea < ( nNumberOfSpots + 1 ); nDomArea++ )
    {
        string sDomAreaTag = sDomAreaBaseTag +
                             IntToString ( nMap ) +
                             "_" +
                             IntToString ( nDomArea );
        object oDomArea =  GetObjectByTag ( sDomAreaTag );
        object oDominator = GetLocalObject ( oDomArea, sDominator );
//        WriteTimestampedLogEntry ( "\n*** " + GetName ( oDominator ) + " dominates " + sDomAreaTag );
        if ( GetIsObjectValid ( oDominator ) )
        {
        ////////////////////////////////////////////////////////////////////////////////
        // give trophy to player on each 10 points. This does not change team points ///
        ////////////////////////////////////////////////////////////////////////////////
            int nTotalScore = GetLocalInt(oDominator, "personalscore");
            int  nScoreAfterLastPoint  = DOM_SCORE_AT_INTERVALL + GetLocalInt ( oDominator, "domination_score");
            //give him trophy on 10,20...points
            if (nScoreAfterLastPoint >= DOM_SCORE_POINT_LIMIT)
            {
                DestroyObject ( CreateObject ( OBJECT_TYPE_CREATURE, GetLocalString ( oDomArea, sDominionOfArea ), GetLocation ( oDomArea ), TRUE ), 6.0 * IntToFloat ( DOM_SCORE_POINT_LIMIT ) );
                nScoreAfterLastPoint = 0;
                nTotalScore += DOM_SCORE_AT_INTERVALL;
                CreateItemOnObject ("Trophy", oDominator );

                SetLocalInt ( oDominator, "personalscore", nTotalScore );
                calcuateMvp ( oDominator );
            }
            else
            {
                SendMessageToPC(oDominator, "Team point will be reached in " +
                                             IntToString (DOM_SCORE_POINT_LIMIT - nScoreAfterLastPoint));
            }
            //save player points
            SetLocalInt(oDominator, "domination_score", nScoreAfterLastPoint);

        ////////////////////////////////////////////////////////////////////////////////
            executeOnTeamPoint( oDominator,
                            DOM_WIN_POINTS ,    //onking  = 100      //flag=5
                            DOM_SCORE_AT_INTERVALL ,    //point bonus amount = 1  //flag= 10
                            DOM_SCORE_BROADCAST //inking = 20//flag=1
                          ) ;

         ////////////////////////////////////////////////////////////////////////////////
        }

    }
//    WriteTimestampedLogEntry ( "\n**************************************************************************************" );
}

