//::///////////////////////////////////////////////
//:: User Defined OnHitCastSpell code
//:: x2_s3_onhitcast
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This file can hold your module specific
    OnHitCastSpell definitions

    How to use:
    - Add the Item Property OnHitCastSpell: UniquePower (OnHit)
    - Add code to this spellscript (see below)

   WARNING!
   This item property can be a major performance hog when used
   extensively in a multi player module. Especially in higher
   levels, with each player having multiple attacks, having numerous
   of OnHitCastSpell items in your module this can be a problem.

   It is always a good idea to keep any code in this script as
   optimized as possible.

   If the Item is an armor the attacker gets NWKnight nerfs


*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-07-22
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Changed By: shadow_in_the_dark
//:: Changed On: 2005-02-18
//:://////////////////////////////////////////////


#include "nwk_onhitcast"
#include "x2_inc_switches"

void main()
{

   object oItem;        // The item casting triggering this spellscript
   object oSpellTarget; // On a weapon: The one being hit. On an armor: The one hitting the armor
   object oSpellOrigin; // On a weapon: The one wielding the weapon. On an armor: The one wearing an armor

   // fill the variables
   oSpellOrigin = OBJECT_SELF;
   oSpellTarget = GetSpellTargetObject();
   oItem        =  GetSpellCastItem();

   if (GetIsObjectValid(oItem))
   {

     NerfAttacker ( oItem, oSpellTarget );

   }
   else
   {
     WriteTimestampedLogEntry ( "*************************************************" +
                         "\n" + "NWK DEBUG: " + "OnHitCastSpell stopped by Invalid Item" +
                         "\n" + "*************************************************" );
   }
}
