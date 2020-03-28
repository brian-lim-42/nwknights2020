/*
  author: shadow_in_the_dark
  name:   nwk_mod_spell
  date:   06/02/05

  Module override spell script, registered in the OnLoadMod event.

*/
#include "x2_inc_switches"
#include "nwk_onhitcast"
#include "sr_inc_dump"
#include "sr_admin_inc"
#include "NW_I0_SPELLS"
const string sSemaphore =  "SR_ON_SPELL_ENTER";

// nerf caster - avoid counterspell
void PreSpell ( string sScriptName, object oCaster )
{
        // set enter
     SetLocalInt (oCaster, sSemaphore, TRUE);
    // WriteTimestampedLogEntry ( "nwk_mod_spell: Set Semaphore call script: " + sScriptName + ", Caster: " + GetName (oCaster));
     ExecuteScript ( sScriptName, oCaster );

}

// don't call the original spell script
void PostSpell ( object oCaster )
{
    SetModuleOverrideSpellScriptFinished();
    // WriteTimestampedLogEntry ( "nwk_mod_spell: set Spell finished" );
    effect eNervCaster = EffectCutsceneParalyze ();
    ApplyEffectToObject ( DURATION_TYPE_TEMPORARY, eNervCaster, oCaster, 0.5 );
    // set exit
    // WriteTimestampedLogEntry ( "nwk_mod_spell: Unset Semaphore");
    DeleteLocalInt ( oCaster, sSemaphore );
}

void SpellDisabled ( object oCaster )
{
    SetModuleOverrideSpellScriptFinished();
    SendMessageToPC (oCaster, "This spell currently doesnt work in NWKnights");
}

void main()
{

    object oCaster = OBJECT_SELF;
    // WriteTimestampedLogEntry ( "nwk_mod_spell: Enter Spellscript - Caster: " + GetName (oCaster) );
    // check if already in this script - avoid multiple calls
    if ( ! GetLocalInt (oCaster, sSemaphore))
    {
        // send the name of the casted spell to all DM if caster is selected
        // by the SpellObserver
        if ( GetLocalObject ( GetModule (), sSpellObserver ) == oCaster )
        {
            SendMessageToAllDMs ( GetName ( oCaster ) + " cast spell " + SpellToString ( GetSpellId () ) );
        }
        object oTarget = GetAttemptedSpellTarget ();
        // nerfs for all caster
        ApplySneakMalus ( oCaster );
        RemoveSpecificEffect ( EFFECT_TYPE_ETHEREAL, oCaster );
        RemoveSpecificEffect ( EFFECT_TYPE_SANCTUARY, oCaster );

        int nMetaMagic = GetMetaMagicFeat ();

         // check for metamagic feat bug
        // here we have to convert METAMAGIC_ to FEAT_ constants
        switch ( nMetaMagic )
        {
            case METAMAGIC_EMPOWER  : nMetaMagic = FEAT_EMPOWER_SPELL;
            break;
            case METAMAGIC_EXTEND   : nMetaMagic = FEAT_EXTEND_SPELL;
            break;
            case METAMAGIC_MAXIMIZE : nMetaMagic = FEAT_MAXIMIZE_SPELL;
            break;
            case METAMAGIC_QUICKEN  : nMetaMagic = FEAT_QUICKEN_SPELL;
            break;
            case METAMAGIC_SILENT   : nMetaMagic = FEAT_SILENCE_SPELL;
            break;
            case METAMAGIC_STILL    : nMetaMagic = FEAT_STILL_SPELL;
            break;
            default : nMetaMagic = -1;
        }
        if ( nMetaMagic != -1 )
        {
            if ( ! GetHasFeat ( nMetaMagic, oCaster ) )
            {
                // time to boot
                string sLogEntry = "<B>" + GetName( oCaster ) + "</B> Use of Metamagic in spell " + SpellToString ( GetLastSpell() ) + " without necessary feature " + FeatureToString ( nMetaMagic );
                WriteTimestampedLogEntry(sLogEntry);
                SendMessageToPC(oCaster,"*** Use of Metamagic without the necessary feature detected! Your character will be booted in few seconds!");
                ExecuteScript ( "sr_dump_char", oCaster );
                DelayCommand(22.0, BootPC(oCaster));

            }
        }
        /*bug description:
        Druids and shapeshifters being able to cast while polymorphed. The trick is to
        polymorph while pressing the quickbar spell button which gives you the little
        star cursor thing, and after polymorphed, you can cast. You can only cast 1
        spell and it's pretty limited, however: It dosen't take a spell-slot. So this
        means that druids realistically gets 11 more spell-slots and shifters-infinite.
        */

        effect eEffect;
        eEffect = GetFirstEffect ( oCaster );
        while ( GetIsEffectValid ( eEffect ) )
        {
            if ( GetEffectType ( eEffect ) == EFFECT_TYPE_POLYMORPH )
            {
                // prevents to cast spells while polyformed
                 SetModuleOverrideSpellScriptFinished();
                // maybe add a nerf like stun to the caster to avoid further missuse
            }

            eEffect = GetNextEffect ( oCaster );
        }


        switch ( GetSpellId() )
        {
            case 352 : // greater shadow conjunction - spiderweb
            // disable spell - speed bug for high strength chars
                SpellDisabled ( oCaster );
                break;
            default:


        }
    }
}
