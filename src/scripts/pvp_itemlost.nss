#include "nwk_colors"
#include "nwk_var_names"

void main()
{
object oItem   = GetModuleItemLost();
object oLoser  = GetModuleItemLostBy();
object oGainer = GetItemPossessor ( oItem );
string  sTag;
sTag = GetTag(oItem);

/////////////////////////////////////////////////////////////////////////////
// if Item is invalid stop here
if ( !GetIsObjectValid ( oItem ) )
{
    //WriteTimestampedLogEntry ( "NWK DEBUG: Invalid Item lost by " + GetName ( oLoser ) );
    return;
}




//2.91 addon - if the object is dropped , destroy it right away.
//some abusers of the minor bug specified above, have multiple arrows!

// simple check if new owner is valid - if so delete it in his inventory

if ((!GetIsObjectValid(oLoser))&&(!GetStolenFlag(oItem))&&(GetStringLeft(sTag,2)!="wp"))
{
    if ( GetIsObjectValid ( oGainer ) )
    {
        DelayCommand(10.0,DestroyObject(oItem));
    } else
    {
        DestroyObject(oItem);
    }
    return;
}
if ((GetStolenFlag (oItem)) && ( (GetTag(oItem) == "Trophy")||(GetTag(oItem) == "Skull")))
{
   effect eEffect = GetFirstEffect(oLoser);
   int paralyze = FALSE;
   int stunned = FALSE;
   int petrify = FALSE;
   int frightened = FALSE;
   int dominated = FALSE;
   int dazed = FALSE;
   int confused = FALSE;
   int charmed = FALSE;
   while(GetIsEffectValid(eEffect))
   {
      int nType = GetEffectType(eEffect);
      if(nType == EFFECT_TYPE_PARALYZE)
         paralyze = TRUE;
      else if(nType == EFFECT_TYPE_STUNNED)
         stunned = TRUE;
      else if(nType == EFFECT_TYPE_PETRIFY)
         petrify = TRUE;
      else if(nType == EFFECT_TYPE_FRIGHTENED)
         frightened = TRUE;
      else if(nType == EFFECT_TYPE_DOMINATED)
         dominated = TRUE;
      else if(nType == EFFECT_TYPE_DAZED)
         dazed = TRUE;
      else if(nType == EFFECT_TYPE_CONFUSED)
         confused = TRUE;
      else if(nType == EFFECT_TYPE_CHARMED)
         charmed = TRUE;
      else if(nType == EFFECT_TYPE_CUTSCENE_PARALYZE)
         paralyze = TRUE;
      eEffect = GetNextEffect(oLoser);
   }

   if (paralyze == TRUE || stunned == TRUE || petrify == TRUE || frightened == TRUE || dominated == TRUE || dazed == TRUE || confused == TRUE || charmed == TRUE||(GetIsDead(oLoser)==TRUE))
    {
    if (GetTag(oItem) == "Trophy")
    {
    DelayCommand(10.0, DestroyObject(oItem));
    object oItem = CreateItemOnObject ("Trophy", oLoser);
    FloatingTextStringOnCreature ("Target disabled, Trophy cannot be stolen", oLoser);
    FloatingTextStringOnCreature ("Target disabled, Trophy cannot be stolen", oGainer);
    }
    else if (GetTag(oItem) == "Skull")
    {
    DelayCommand(10.0, DestroyObject(oItem));
    object oItem = CreateItemOnObject ("Skull", oLoser);
    FloatingTextStringOnCreature ("Target disabled, Skull cannot be stolen", oLoser);
    FloatingTextStringOnCreature ("Target disabled, Skull cannot be stolen", oGainer);
    }
    }
   else
    {
    if (GetTag(oItem) == "Trophy")
    {
    FloatingTextStringOnCreature ("Trophy Stolen", oLoser);
    }
    else if (GetTag(oItem) == "Skull")
    {
    FloatingTextStringOnCreature ("Skull Stolen", oLoser);
    }
    }
}
////////////////////////Return Disarmed Weapon//////////////////////////////
else if ((GetStringLeft(sTag,2)=="wp") && (!GetStolenFlag (oItem)))
{
    if (GetIsObjectValid(oGainer))
    {
       DelayCommand(10.0,DestroyObject(oItem));
    } else
    {
       SetLocalObject (oItem, "owner", oLoser);
       DelayCommand(18.0,ExecuteScript ("nwk_disarm", oItem));
    }
}
//////////////////////////////Booby Trapped Skulls///////////////////////////
else if ((GetStolenFlag (oItem)) && ((GetTag(oItem) == "BoobyTrappedSkull")))
{
FloatingTextStringOnCreature ("Booby Trapped Skull Stolen", oLoser);
if(GetGender(oGainer) == GENDER_FEMALE)
{
AssignCommand (oGainer, PlaySound ("as_pl_screamf5"));
}
else if(GetGender(oGainer) == GENDER_MALE)
{
AssignCommand (oGainer, PlaySound ("as_pl_screamm4"));
}
effect eSkillDec = EffectSkillDecrease(SKILL_HIDE, 100);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eSkillDec, oGainer, 10.0f);
DelayCommand(3.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_FIREBALL),GetLocation(oGainer)));
DelayCommand(3.0,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_COM_CHUNK_RED_LARGE),GetLocation(oGainer)));
DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(TRUE,TRUE),oGainer,0.0f));
DelayCommand(3.0,DestroyObject (oItem));
CreateItemOnObject ("Skull", oLoser);
}
///////////////////////////////////Time Bomb/////////////////////////////////
else if ((!GetStolenFlag (oItem)) && ((GetTag(oItem) == "TimeBomb")))
{
    if (GetIsObjectValid(oGainer))
    {
       DelayCommand(10.0,DestroyObject(oItem));
    } else
    {
       SetItemCursedFlag (oItem, TRUE);
       FloatingTextStringOnCreature ("Bomb Planted", oLoser);
       DelayCommand (1.0, AssignCommand (oItem, SpeakString(ColorString("10",COLOR_ORANGE))));
       DelayCommand (2.0, AssignCommand (oItem, SpeakString(ColorString("9",COLOR_ORANGE))));
       DelayCommand (3.0, AssignCommand (oItem, SpeakString(ColorString("8",COLOR_ORANGE))));
       DelayCommand (4.0, AssignCommand (oItem, SpeakString(ColorString("7",COLOR_ORANGE))));
       DelayCommand (5.0, AssignCommand (oItem, SpeakString(ColorString("6",COLOR_ORANGE))));
       DelayCommand (6.0, AssignCommand (oItem, SpeakString(ColorString("5",COLOR_ORANGE))));;
       DelayCommand (7.0, AssignCommand (oItem, SpeakString(ColorString("4",COLOR_ORANGE))));
       DelayCommand (8.0, AssignCommand (oItem, SpeakString(ColorString("3",COLOR_ORANGE))));
       DelayCommand (9.0, AssignCommand (oItem, SpeakString(ColorString("2",COLOR_ORANGE))));
       DelayCommand (10.0, AssignCommand (oItem, SpeakString(ColorString("1",COLOR_ORANGE))));
       DelayCommand (10.5,ExecuteScript ("equ_timebomb", oItem));
    }
}

/////////////////////////////////////////////////////////////////////////////
else
{
    if (GetIsObjectValid(oGainer))
    {
        DelayCommand(10.0,DestroyObject(oItem));
    } else
    {
        DestroyObject(oItem);
        // destroy traps set in sanctuary
        object oSanctuary = GetArea ( GetObjectByTag ( "SILVERSTART" ) );
        if ( GetArea ( oLoser ) == oSanctuary )
        {
            // player dropped something in sanctuary, search for traps and destroy them
            object oObject = GetFirstObjectInArea ( oSanctuary );
            while ( GetIsObjectValid ( oObject ) )
            {
                if ( GetIsTrapped ( oObject ) )
                {
                    SetTrapDisabled ( oObject );
                    SendMessageToAllDMs ( "trap disabled in sanctuary" );
                }
                oObject = GetNextObjectInArea ( oSanctuary );
            }
        }
    }
    return;
}
}



