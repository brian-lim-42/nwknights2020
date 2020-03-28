//nwk_hb_include
const string VAR_NAME_WAS_IN_SNEAK_MODE = "varnameWasInSneakMode" ;
const int SNEAKER_SPEED_MULUS_PERCENT = 30;
const float SNEAKER_SPEED_MULUS_DURATION_SECONDS = 3.0;
const float SNEAKER_HIDE_MULUS_DURATION_SECONDS = 20.0;
const int RANGED_SPEED_MULUS_PERCENT = 30;
const float RANGED_SPEED_MULUS_DURATION_SECONDS = 3.0;

void giveHideMalus(object oPC);
void giveSpeedMalus(object oPC);
void giveSpeedRangedMalus(object oPC);
int checkForOutOfSneakMalus(object oPC);
//int dealWithForDeathAttackParalasis(object oPC);

void main()
{
    object oPC = GetFirstPC();
    while (oPC != OBJECT_INVALID)
    {
        //dealWithForDeathAttackParalasis(oPC);

        if (  !(checkForOutOfSneakMalus(oPC)) )
        {
            //ranged attack check only if not malus - so ranged sneaks will not
            //get multiple maluses.

            //check : 1. attacking 2. using ranged weapon
            if (GetIsObjectValid(GetAttackTarget(oPC)))
            {
                object weapon;
//                int isHoldingRangedWeapon = FALSE;

                //try right then left hands
                weapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oPC);
                if (GetIsObjectValid(weapon) && (GetWeaponRanged(weapon)))
                {
/*
It's not possible to wear range weapon in left hand
                    isHoldingRangedWeapon= TRUE;

                }
                else
                {
                    weapon = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oPC);
                    if (GetIsObjectValid(weapon) && (GetWeaponRanged(weapon)))
                     {
                       isHoldingRangedWeapon= TRUE;
                     }
                }
                if (isHoldingRangedWeapon)
                {
*/
                    giveSpeedRangedMalus(oPC); //as the sneak weapon
                }
           }
       }   //end of: if (  !(checkForOutOfSneakMalus(oPC)) )



        //these checks are conducted only on one not ATTACKING nor has attack
        //action in his queue (by trying to melle attack far creature)
        //CURRENTLY WORK ALL THE TIME
        //if (!GetIsObjectValid(GetAttemptedAttackTarget(oPC))
        //{

       /*     if (GetActionMode(oPC, ACTION_MODE_EXPERTISE))
            {
                effect eEffect = EffectMovementSpeedDecrease(25);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, 7.0);
            }
            else if (GetActionMode(oPC, ACTION_MODE_IMPROVED_EXPERTISE))
            {
                effect eEffect = EffectMovementSpeedDecrease(50);
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, 7.0);
            }    */
       //}




     oPC = GetNextPC();
    }


}




//sneak: purpose: give sneakers a malus to both thier speed and hide/silent for a certain
//amount of rounds after they attack out of sneak. so no sneak-run-hide is possible.
//the flow for sneaker is:
// on being in sneak mode , a local variable (VAR_NAME_WAS_IN_SNEAK_MODE ) is set to TRUE
// on every round , everybody is checked whether they are in combat . If they are , and they got
// out of sneak (now they are not sneakers , but last round they were - check Variable) ,
// then give the out-of-sneak guys a temporary malus.
// it will also work on sneaker which was surprised and attacked . tough. thats life.
//return TRUE if he got the malus


int checkForOutOfSneakMalus(object oPC)
{
    int gotTheMalus = FALSE;

    if  (GetActionMode(oPC, ACTION_MODE_STEALTH))
    {
      SetLocalInt(oPC,VAR_NAME_WAS_IN_SNEAK_MODE,TRUE);
    }
    else
    {
        int wasInSneakMode = GetLocalInt(oPC,VAR_NAME_WAS_IN_SNEAK_MODE);
        //if he is in combat, mulus him
        if (wasInSneakMode)
        {
            if (GetIsInCombat(oPC))
            {
                giveSpeedMalus(oPC);
                //if shadowdancer  or cobolod-comando , or in general has feat
//                if (    (GetLevelByClass(CLASS_TYPE_SHADOWDANCER, oPC) > 0)
//                    ||  (GetAppearanceType(oPC,APPEARANCE_TYPE_KOBOLD_A)
//                   )
                if (GetHasFeat(FEAT_HIDE_IN_PLAIN_SIGHT,oPC))
                {
                    giveHideMalus(oPC);
                }
                gotTheMalus=TRUE;
            }
            //in any case , if he is not sneaking right now , change the variable back
            SetLocalInt(oPC,VAR_NAME_WAS_IN_SNEAK_MODE,FALSE);
        }
    }
    return gotTheMalus;
}







void giveHideMalus(object oPC)
{
    //change silent/hide
    int skill=GetSkillRank(SKILL_MOVE_SILENTLY,oPC);
    effect silent_decrease = ExtraordinaryEffect ( EffectSkillDecrease(SKILL_MOVE_SILENTLY,skill) );
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                        silent_decrease,
                        oPC,
                        SNEAKER_HIDE_MULUS_DURATION_SECONDS
                        );

    skill=GetSkillRank(SKILL_HIDE,oPC);
    effect hide_decrease=   ExtraordinaryEffect ( EffectSkillDecrease(SKILL_HIDE,skill) );
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                        hide_decrease,
                        oPC,
                        SNEAKER_HIDE_MULUS_DURATION_SECONDS
                        );
   FloatingTextStringOnCreature("Hide Malus for "
              +  FloatToString(SNEAKER_HIDE_MULUS_DURATION_SECONDS,2,0)
              + " seconds" , oPC, FALSE )   ;
}





void giveSpeedMalus(object oPC)
{
    effect eSpeed;
    eSpeed= ExtraordinaryEffect ( EffectMovementSpeedDecrease(SNEAKER_SPEED_MULUS_PERCENT) );
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSpeed,oPC,SNEAKER_SPEED_MULUS_DURATION_SECONDS);
     //FloatingTextStringOnCreature("Temporary Speed Malus",oPC);
}

void giveSpeedRangedMalus(object oPC)
{
    effect eSpeed;
    eSpeed= ExtraordinaryEffect ( EffectMovementSpeedDecrease(RANGED_SPEED_MULUS_PERCENT) );
    ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eSpeed,oPC,RANGED_SPEED_MULUS_DURATION_SECONDS);
    //FloatingTextStringOnCreature("Temporary Speed Malus",oPC);
}

/** death attack paralasis should work according to NWKnights meaning:
1. Duration will be no more than 3 rounds.
2. Paralasis will ware off on first damage.
Most of the other stuns are handled in the spells scripts as delayed scripts which
are checked 1,2 and 3 seconds after the spells started.
I do not know which script is called for assasign death attack , so I have to implement
it here.
The implementation:
1. if some one have a paralisis effect (from any kind , including assasign source)
    1.1 see what is his current hp amount (use the firs time to compare)
    1.2 save as counter the number of hb which happened during the time is was
        paralized . 0 at first , but counting up as time passes.
    1.3 check

   Currently not implemened , cause there is no quick way to check for a specific effect
   on a pc , but to loop through all of them. it is too time consuming to run on
   a HB script.
*/
//int dealWithForDeathAttackParalasis(object oPC)






