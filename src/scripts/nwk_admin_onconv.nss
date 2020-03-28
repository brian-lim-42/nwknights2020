#include "nwk_admin"
#include "nwk_constants"
#include "sr_inc_dump"
void main()
{

  // Get who spoke, and the
    int nMatch = GetListenPatternNumber();
    string charName;
    object oSpeaker;
    object oPC;
    if (nMatch==BOOT_CHARACTER_INT) //boot
    {
        //verify it is administrartor
        oSpeaker = GetLastSpeaker();
        if (!isPlayerAdmin(oSpeaker))
            return;

        //get the character name to boot

       charName = GetMatchedSubstring(1); //should retrun the right half
                                                //of the sentence
        //take the right part of the string (without boot and one space)
       // string charName=GetSubString(   sSpoken,
       //                                 GetStringLength(BOOT_CHARACTER_PREFIX),
       //                                 GetStringLength(sSpoken)
       //                             );
        SendMessageToPC(oSpeaker,"Going to boot: ["+charName+"]. make sure name match exactly");

        //now search for a character with this exact name. If exist ban it!
        oPC = GetFirstPC();
        while (GetIsObjectValid(oPC))
        {
            if ( ( GetName ( oPC ) == charName ) ||
                 ( GetPCPlayerName ( oPC ) == charName ))
            {
                sendMessageToAllPlayer("",charName +" is booted by the Admin");
                DelayCommand(5.0,BootPC(oPC));
                break;
            }
            oPC = GetNextPC();
        }




    } else if ( nMatch == DUMP_CHARACTER_INT ) //DUMP
    {
        oSpeaker = GetLastSpeaker ();
        if ( ! isPlayerAdmin ( oSpeaker ) )
            return;
        charName = GetMatchedSubstring ( 1 );
        oPC = GetFirstPC ();
        while ( GetIsObjectValid ( oPC ) &&
                ( GetName ( oPC ) != charName ) &&
                ( GetPCPlayerName ( oPC ) != charName ) )
        {
            oPC = GetNextPC();
        }
        SendMessageToPC ( oSpeaker, "Create Log dump for: [" + charName + "]" );
        string sMessage = CreateDumpMessage ( oPC );
        WriteTimestampedLogEntry ( sMessage );
        SendMessageToPC ( oSpeaker, sMessage );
    } else if ( nMatch == ABUSE_CHARACTER_INT ) // abuse report
    {
        oSpeaker = GetLastSpeaker ();
        charName = GetMatchedSubstring ( 1 );
        // string should be of kind:
        // "name of char";Reason for abuse report in plain text
        int nPosBreak = FindSubString ( charName, ";" );
        string sReport = GetStringRight ( charName, GetStringLength ( charName) - nPosBreak - 1 ) + "\n";
        charName = GetSubString ( charName, 1, nPosBreak - 2 );
        oPC = GetFirstPC ();
        while ( GetIsObjectValid ( oPC ) &&
                ( GetName ( oPC ) != charName ) &&
                ( GetPCPlayerName ( oPC ) != charName ) )
        {
            oPC = GetNextPC();
        }
        SendMessageToPC ( oSpeaker, "Create Log dump for: [" + charName + "]" );
        string sMessage = CreateDumpMessage ( oPC );
        WriteTimestampedLogEntry ( "\n+ " +
                                   "ABUSE REPORT: Reporter: " + GetPCPlayerName ( oSpeaker ) + " [" + GetPCPublicCDKey ( oSpeaker, TRUE ) + "]\n" +
                                   "ABUSE Message: " + sReport + sMessage );

    }


}
