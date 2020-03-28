
/**
PROBLEM : I think that the number of spells does not decrease in the script
      even if the spell is casted (maybe on end of script it all happen)
      so we cannot check whether or not a spell was casted with this thing.

    so , we will stick we simple solution - casting only regular spells
    (when casting emp./max. I think that they cost only as regulars)
*/
/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * simple fast-buffing of the spells.
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * visual effects:
 * 1. there will be no pre-casting visual effect(no caster moving hands).
 * 2. all ending effects are shown quicly.
 * 3. any constant effect will be shown (skin of barkskin, Freedom_of_movment
 *  circle etc).
 * 4. to add a big visual effect of floor designs to show things did happen.
 *  just for beatity , so can be deleted - these are the last rows of this
 *  function.
 * choose it from this :VFX_FNF_LOS_EVIL_30 - medium red rune circle //can be 10/20 too
 *          VFX_FNF_LOS_HOLY_30 - yellow             //can be 10/20 too
 *          VFX_FNF_NATURES_BALANCE -green
 *          VFX_FNF_PWKILL -red with lighting
 *          VFX_FNF_TIME_STOP -blue
 *          VFX_FNF_WORD -yellow big
 *
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *


/** MUST BE CHECKED ON VERSION CHANGESSSSS
    checks the cleric domains.
    if pre_checked_domain=0 starts from the beginnig and retrieve
    one . if pre_checked_domain=ANY DOMAIN , it checks for the next
    one and returns it.
    on no feat returns 0.
*/
int GetClericDomains(object PC,int pre_checked_domain)
{
    int i,start,temp;

    if (pre_checked_domain<306)
       start=306;
    else
       start=pre_checked_domain+1;

    for (i=start;i<=308;i++)
    {
        temp=GetHasFeat(i,PC);

        SpeakString("for the "+ IntToString(i)+ "th feat,cause HasFeat returned:" +IntToString(temp));
        if (temp==1)
            return i;
}
    //jump on LUCK DOMAIN = 309
    if (i==309)
        i++;

    for (;i<=325;i++)
    {
        temp=GetHasFeat(i,PC);

            SpeakString("for the "+ IntToString(i)+ "th feat,cause HasFeat returned:" +IntToString(temp));
        if (temp==1)
            return i;
    }
    return 0;
}



int GetIsPolymorphed ( object oPC )
{
    int bResult = FALSE;
    effect e=GetFirstEffect(oPC);
    while (GetIsEffectValid(e))
    {
        if ( GetEffectType ( e ) == EFFECT_TYPE_POLYMORPH )
        {
            bResult = TRUE;
        }
        e=GetNextEffect(oPC);
    }
    return bResult;
}








/** check if pc has spell , if he does , cast it and make him wait a bit.
 *  if pc is a cleric with a domain , cast the domain spell on him by
 *  the placeable object ,  cause regular spell casting is bugged.
 *  @parameters : domain - 1 if pc has cleric domain that casts this spell , 0 else.
 *  @returns : 1 if rebuff succedd , 0 if not.
 */
int buff_spell(int curr_spell,object pc,int domain)
{
    int num_of_spells_before =GetHasSpell(curr_spell,pc);

    if (num_of_spells_before ==0)
        return 0;

    if (domain==0)
    {
        AssignCommand(pc,
            ActionCastSpellAtObject(curr_spell,pc,METAMAGIC_ANY,FALSE,
                                0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE)); //instant
    }
    else if (domain==1)
    {
        // cast domain spell
        // the 3rd argument is "TRUE" cause pc doesnt have to be able to cast
        // the spell.
   /*    DecrementRemainingSpellUses(pc,curr_spell);
      //    DecrementRemainingFeatUses(pc,curr_spell);
       AssignCommand(pc,
              ActionCastSpellAtObject(curr_spell,pc,METAMAGIC_ANY,TRUE,
                            0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE) //instant
              );
       SignalEvent(pc, EventSpellCastAt(OBJECT_SELF, curr_spell, FALSE));
            //debug//
      /*      AssignCommand(pc,
            ActionCastSpellAtObject(curr_spell,pc,METAMAGIC_ANY,FALSE,
                               0,PROJECTILE_PATH_TYPE_DEFAULT,TRUE));
                   */             //end//
    }


   return 1;
}





/**
the spells that recieve special treatment are:
1. Stoneskin will be cast only if Greater stoneskin wasn`t cast before.
2. protection-from-evil has priority over protection-from-good if
   player got only one slot of the protection-from-alignment spell.
   if player has 2 slots or more , both spells will be casted.
3. same rule goes for magic-circle-against-alignment
//turns duration spells
4. if mink-blank buff exist, don`t use lesser-mind-blank

[shadow]- if player is polymorphed, number of spells will not be decreased
*/

void main() {

object pc=GetLastUsedBy();

// no cast if PC is polymorphed
if ( GetIsPolymorphed ( pc ) )
{
   SendMessageToPC ( pc, "you can't cast any spells" );
   return;
}
int curr_spell;

//check cleric domain

/*int domain1,domain2;

domain1=GetClericDomains(pc,0);
if (domain1>0)
    domain2=GetClericDomains(pc,domain1);

SpeakString("pc domains are:"+IntToString(domain1)+" "+ IntToString(domain2));


SpeakString("domains:war and good "+
                        IntToString(FEAT_WAR_DOMAIN_POWER)+" "

                         +IntToString(FEAT_GOOD_DOMAIN_POWER)+" "
                      );
*/
//if pc doesnt have domains(isnt a cleric) do all the buff quicly
//and quit function
//if (domain1==0)
//{
buff_spell(SPELL_BULLS_STRENGTH ,pc,0);
buff_spell(SPELL_BARKSKIN   ,pc,0);
buff_spell(SPELL_CATS_GRACE ,pc,0);
//buff_spell(SPELL_DEATH_WARD ,pc,0);
buff_spell(SPELL_EAGLE_SPLEDOR  ,pc,0);
buff_spell(438     ,pc,0);//Owl_Insight
buff_spell(SPELL_ENDURANCE  ,pc,0);
buff_spell(SPELL_ENDURE_ELEMENTS,pc,0);
buff_spell(SPELL_FOXS_CUNNING   ,pc,0);
buff_spell(SPELL_MAGE_ARMOR ,pc,0);
buff_spell(SPELL_OWLS_WISDOM    ,pc,0);
buff_spell( SPELL_PREMONITION   ,pc,0);
buff_spell(SPELL_PROTECTION_FROM_ELEMENTS,pc,0);
// if player got both greater and regular stoneskin ,cast only greater.
if ( buff_spell(SPELL_GREATER_STONESKIN,pc,0)==0)
        buff_spell(SPELL_STONESKIN,pc,0);
//if pc has 2 slots ready ,cast verses good too.
if (GetHasSpell(SPELL_MAGIC_CIRCLE_AGAINST_EVIL,pc)>=2)
    buff_spell(SPELL_MAGIC_CIRCLE_AGAINST_GOOD,pc,0);

buff_spell(SPELL_MAGIC_CIRCLE_AGAINST_EVIL,pc,0);
if (GetHasSpell(SPELL_PROTECTION_FROM_EVIL,pc)>=2)
    buff_spell(SPELL_PROTECTION_FROM_GOOD,pc,0);
buff_spell(SPELL_PROTECTION_FROM_EVIL,pc,0);

//Added Expansion Spells///
buff_spell(SPELL_ONE_WITH_THE_LAND     ,pc,0);
buff_spell(SPELL_CAMOFLAGE     ,pc,0);
buff_spell(SPELL_MASS_CAMOFLAGE     ,pc,0);
buff_spell(SPELL_ENTROPIC_SHIELD     ,pc,0);
buff_spell(SPELL_SHIELD_OF_FAITH     ,pc,0);
buff_spell(SPELL_AURAOFGLORY     ,pc,0);
buff_spell(SPELL_SHIELD     ,pc,0);

//buff all the turn too.
buff_spell(SPELL_AID     ,pc,0);
buff_spell(SPELL_BLESS   ,pc,0);
buff_spell(SPELL_ENERGY_BUFFER  ,pc,0);
buff_spell(SPELL_FREEDOM_OF_MOVEMENT  ,pc,0);
buff_spell(SPELL_GHOSTLY_VISAGE     ,pc,0);
//buff_spell(SPELL_IMPROVED_INVISIBILITY,pc,0);
//buff_spell(SPELL_INVISIBILITY_SPHERE    ,pc,0);
buff_spell(SPELL_LEGEND_LORE        ,pc,0);
buff_spell(SPELL_NEGATIVE_ENERGY_PROTECTION ,pc,0);
buff_spell(SPELL_RESIST_ELEMENTS    ,pc,0);
buff_spell(SPELL_SEE_INVISIBILITY   ,pc,0);
buff_spell(SPELL_SHADOW_SHIELD  ,pc,0);
buff_spell(SPELL_SPELL_RESISTANCE   ,pc,0);
//buff_spell(SPELL_TRUE_SEEING    ,pc,0);
//if (buff_spell(SPELL_MIND_BLANK ,pc,0)==0)
buff_spell(SPELL_LESSER_MIND_BLANK ,pc,0);

return; //THE END OF REGULAR BUFFING
//}




//CLERIC BUFFING
//for every spell , check if pc has domain in it
//if pc do have , tell it to the buff_spell func
//FUTURE CHANGES
//when added spell:ultravision ,add it with knowledge domain
//                  clairudience/clairvoyance
// Its still AB order , hour duration then turns duration
/*
buff_spell(SPELL_BULLS_STRENGTH ,pc,0);

//SPELL_BARKSKIN ,domain : Planet,War
if ( (domain1==FEAT_PLANT_DOMAIN_POWER)||
     (domain2==FEAT_PLANT_DOMAIN_POWER)||
     (domain1==FEAT_WAR_DOMAIN_POWER)  ||
     (domain2==FEAT_WAR_DOMAIN_POWER)    )
    buff_spell(SPELL_BARKSKIN ,pc,1);
else
    buff_spell(SPELL_BARKSKIN ,pc,0);


//cats grace = ANIMAL DOMAIN or WAR DOMAIN
if ( (domain1==FEAT_ANIMAL_DOMAIN_POWER)||
     (domain2==FEAT_ANIMAL_DOMAIN_POWER)||
     (domain1==FEAT_WAR_DOMAIN_POWER)   ||
     (domain2==FEAT_WAR_DOMAIN_POWER)         )
    buff_spell(SPELL_CATS_GRACE ,pc,1);
else
    buff_spell(SPELL_CATS_GRACE ,pc,0);


buff_spell(SPELL_DEATH_WARD ,pc,0);
buff_spell(SPELL_EAGLE_SPLEDOR  ,pc,0);
buff_spell(SPELL_ENDURANCE  ,pc,0);
buff_spell(SPELL_ENDURE_ELEMENTS,pc,0);
buff_spell(SPELL_FOXS_CUNNING   ,pc,0);



//SPELL_MAGE_ARMOR  , domains : Magic
if ( (domain1==FEAT_MAGIC_DOMAIN_POWER)||
     (domain2==FEAT_MAGIC_DOMAIN_POWER)  )
    buff_spell(SPELL_MAGE_ARMOR ,pc,1);
else
    buff_spell(SPELL_MAGE_ARMOR ,pc,0);


buff_spell(SPELL_OWLS_WISDOM    ,pc,0);
buff_spell( SPELL_PREMONITION   ,pc,0);
buff_spell(SPELL_PROTECTION_FROM_ELEMENTS,pc,0);


// if player got both greater and regular stoneskin ,cast only greater.
if ( buff_spell(SPELL_GREATER_STONESKIN,pc,0)==0)
{
//SPELL_STONESKIN  - DOMAINS: Earth , Good , Magic , Strength
if ( (domain1==FEAT_EARTH_DOMAIN_POWER) ||
     (domain2==FEAT_EARTH_DOMAIN_POWER) ||
     (domain1==FEAT_GOOD_DOMAIN_POWER)  ||
     (domain2==FEAT_GOOD_DOMAIN_POWER)  ||
     (domain1==FEAT_MAGIC_DOMAIN_POWER) ||
     (domain2==FEAT_MAGIC_DOMAIN_POWER) ||
     (domain1==FEAT_STRENGTH_DOMAIN_POWER)||
     (domain2==FEAT_STRENGTH_DOMAIN_POWER)  )

    buff_spell(SPELL_STONESKIN ,pc,1);
else
    buff_spell(SPELL_STONESKIN ,pc,0);
}



//if pc has 2 slots ready ,cast verses good too.
if (GetHasSpell(SPELL_MAGIC_CIRCLE_AGAINST_EVIL,pc)>=2)
    buff_spell(SPELL_MAGIC_CIRCLE_AGAINST_GOOD,pc,0);
buff_spell(SPELL_MAGIC_CIRCLE_AGAINST_EVIL,pc,0);

if (GetHasSpell(SPELL_PROTECTION_FROM_EVIL,pc)>=2)
    buff_spell(SPELL_PROTECTION_FROM_GOOD,pc,0);
buff_spell(SPELL_PROTECTION_FROM_EVIL,pc,0);



//buff all the turn too.
buff_spell(SPELL_AID     ,pc,0);
buff_spell(SPELL_BLESS   ,pc,0);


//SPELL_ENERGY_BUFFER  - DOMAINS: Earth,Fire,Protection
if ( (domain1==FEAT_EARTH_DOMAIN_POWER)||
     (domain2==FEAT_EARTH_DOMAIN_POWER)||
     (domain1==FEAT_PROTECTION_DOMAIN_POWER)||
     (domain2==FEAT_PROTECTION_DOMAIN_POWER)||
     (domain1==FEAT_FIRE_DOMAIN_POWER)||
     (domain2==FEAT_FIRE_DOMAIN_POWER)   )
    buff_spell(SPELL_ENERGY_BUFFER ,pc,1);
else
    buff_spell(SPELL_ENERGY_BUFFER ,pc,0);




//SPELL_FREEDOM_OF_MOVEMENT  - DOMAINS: Travel
if ( (domain1==FEAT_TRAVEL_DOMAIN_POWER)||
     (domain2==FEAT_TRAVEL_DOMAIN_POWER)   )
    buff_spell(SPELL_FREEDOM_OF_MOVEMENT ,pc,1);
else
    buff_spell(SPELL_FREEDOM_OF_MOVEMENT ,pc,0);






buff_spell(SPELL_GHOSTLY_VISAGE     ,pc,0);




//SPELL_IMPROVED_INVISIBILITY  - DOMAINS: Trickery
if ( (domain1==FEAT_TRICKERY_DOMAIN_POWER)||
     (domain2==FEAT_TRICKERY_DOMAIN_POWER)   )
    buff_spell(SPELL_IMPROVED_INVISIBILITY ,pc,1);
else
    buff_spell(SPELL_IMPROVED_INVISIBILITY ,pc,0);





buff_spell(SPELL_INVISIBILITY_PURGE     ,pc,0);
buff_spell(SPELL_INVISIBILITY_SPHERE    ,pc,0);



//SPELL_LEGEND_LORE=  Knowledge
if ( (domain1==FEAT_KNOWLEDGE_DOMAIN_POWER) ||
     (domain2==FEAT_KNOWLEDGE_DOMAIN_POWER)   )
    buff_spell(SPELL_LEGEND_LORE ,pc,1);
else
    buff_spell(SPELL_LEGEND_LORE ,pc,0);







buff_spell(SPELL_NEGATIVE_ENERGY_PROTECTION ,pc,0);
buff_spell(SPELL_RESIST_ELEMENTS    ,pc,0);
buff_spell(SPELL_SEE_INVISIBILITY   ,pc,0);
buff_spell(SPELL_SHADOW_SHIELD  ,pc,0);
buff_spell(SPELL_SPELL_RESISTANCE   ,pc,0);



//SPELL_TRUE_SEEING= Animal , Knowledge
if ( (domain1==FEAT_ANIMAL_DOMAIN_POWER)    ||
     (domain2==FEAT_ANIMAL_DOMAIN_POWER)    ||
     (domain1==FEAT_KNOWLEDGE_DOMAIN_POWER) ||
     (domain2==FEAT_KNOWLEDGE_DOMAIN_POWER)   )
    buff_spell(SPELL_TRUE_SEEING ,pc,1);
else
    buff_spell(SPELL_TRUE_SEEING ,pc,0);



if (buff_spell(SPELL_MIND_BLANK ,pc,0)==0)
    buff_spell(SPELL_LESSER_MIND_BLANK ,pc,0);

//Ultravision
//DARKVISION????






*/






//////////////////// ENDING BIG VISUAL EFFECT ////////////////////////////
//Create the new visual effect , then apply it to object.
//effect visual_effect = EffectVisualEffect(VFX_FNF_TIME_STOP);
//ApplyEffectToObject(DURATION_TYPE_INSTANT, visual_effect, pc);
//DelayCommandApplyEffectToObject(DURATION_TYPE_PERMANENT, visual_effect, pc);

//AssignCommand(pc,ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_LEFT, 0.2));
//AssignCommand(pc,ActionPlayAnimation(ANIMATION_FIREFORGET_HEAD_TURN_RIGHT, 0.2));

//effect dominated=EffectCutsceneDominated();
//ExtraordinaryEffect( dominated);
//DelayCommand(3.0,ApplyEffectToObject(DURATION_TYPE_TEMPORARY,dominated,pc,10.0));
//DelayCommand(5.0,ExecuteScript("pvp_buffingvisua",pc));



}   //the end//


