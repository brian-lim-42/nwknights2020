#include "nwk_constants"
#include "nwk_colors"

// make him friendy to all
void setNeutral ( object oPlayer )
{
    SetLocalString ( oPlayer, "team", "NONE" );
    object oPC = GetFirstPC ();
    while ( GetIsObjectValid ( oPC ) )
    {
        SetPCLike ( oPlayer,oPC );
        SetPCLike ( oPC,oPlayer );
        oPC = GetNextPC ();
    }
}


void main()
{
    object oPC = GetEnteringObject ();

    AddJournalQuestEntry( "Quick Guide for New Players",1,oPC,FALSE);
    AddJournalQuestEntry( "NWKnights Forum",1,oPC,FALSE);
    AddJournalQuestEntry( "NWKnights Spells1",1,oPC,FALSE);
    AddJournalQuestEntry( "NWKnights Spells2",1,oPC,FALSE);
    AddJournalQuestEntry( "NWKnights Spells3",1,oPC,FALSE);
    AddJournalQuestEntry( "NWKnights Equipment",1,oPC,FALSE);
    AddJournalQuestEntry( "NWKnights Equipment_1",1,oPC,FALSE);
    AddJournalQuestEntry( "NWKnights Equipment_0",1,oPC,FALSE);
    AddJournalQuestEntry( "NWKnights Cloaks",1,oPC,FALSE);
    AddJournalQuestEntry( "NWKnights Abuse Report",1,oPC,FALSE);
    if ( ! GetIsDM ( oPC ) )
    {

        // also delete the local variables of this pc if not deleted before
        // the idea was fine, but it force action cancels - I let it in to avoid
        // re-implementing
        // setNeutral (oPC);

        // remove all effects before removal of the equipment
        effect eEffect;
        int wait = 0;

        eEffect = GetFirstEffect(oPC);

        while ( GetIsEffectValid(eEffect))
        {
            if (GetEffectType(eEffect) == EFFECT_TYPE_POLYMORPH)
            {
                RemoveEffect(oPC,eEffect);
                wait = 1;
            }
            eEffect = GetNextEffect(oPC);
        }
        // allow polymorphie to disappear.
        if (wait == 1) ActionWait(7.0);
        emptyPc(oPC);

        ExecuteScript("pvp_nerf_monks",oPC);
        checkIsRegistered(oPC);


        object oGuardian = GetObjectByTag ("EntryGuardian");
        string sNameTag = GetPCPlayerName (oPC);
        string sSound = "vs_ncelestf_hi";
        vector oDirection = GetPosition (oPC);
        DelayCommand (2.0, AssignCommand (oGuardian, SetFacingPoint (oDirection)));
        DelayCommand (2.0, AssignCommand (oGuardian, ActionPlayAnimation (ANIMATION_FIREFORGET_BOW, 1.0)));
        DelayCommand (2.0, AssignCommand (oGuardian, SpeakString(ColorString("Welcome to NWKnights!" +
                                                                  "\n"+sNameTag,COLOR_LIGHT_BLUE))));
        DelayCommand (2.0, AssignCommand (oGuardian, PlaySound (sSound)));


    }
}
