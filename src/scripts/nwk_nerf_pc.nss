/* nerfPc
 * decrease the Pc movement rate ,hide&move-silently skills.
 * used on flag/ball capture.
 */
#include "nw_i0_spells"
#include "nwk_flag"
#include "nwk_ball"
//void main(){}

//seperated from nerPC to have chance that spell effect of FoM are vanished
void AddSpeedMalus (object oPC)
{
    //avoid malus on char without flag/ball
    if ( GetHasFlag ( oPC ) || GetHasBall ( oPC ) )
    {
        /* get the movement rate. if too fast , decrease it.
         * check monk and barb level.
         */
        int monk_level=GetLevelByClass(CLASS_TYPE_MONK,oPC) ;
        int barb_level=GetLevelByClass(CLASS_TYPE_BARBARIAN,oPC);
        int pc_speed= 100; //regular PC
        int malus;

        //deal with monk levels,each 3 lev give +10%
        //but last (15-17)(18-20) give only 5%
        if (monk_level>=3) {
            pc_speed+=10;
             if (monk_level>=6) {
                 pc_speed+=10;
                  if (monk_level>=9) {
                   pc_speed+=10;
                      if (monk_level>=12) {
                        pc_speed+=10;
                        if (monk_level>=15) {
                                 pc_speed+=5;
                                 if (monk_level>=18) {
                                    pc_speed+=5;

                                 }
                        }
                     }
                 }
              }
        }
        if (barb_level>=1)
             pc_speed+=10;


        //thats the real malus check. base malus is 60% , the faster the pc ,
        //the bigger the malus
        if (pc_speed>=150)
            malus=60;
        else if (pc_speed>=145)
            malus=55;
        else if (pc_speed>=140)
            malus=50;      //35;
        else if (pc_speed>=130)
            malus=40;
        else if (pc_speed>=120)
            malus=30;
        else if (pc_speed>=110)
            malus=20;
        else malus=10;

        //add more
        malus=malus+5;


        effect eSpeed;
        eSpeed= EffectMovementSpeedDecrease(malus);
        eSpeed=ExtraordinaryEffect(eSpeed);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT,eSpeed,oPC);

    }

}





void nerfPc(object oPC)
{
    //remove spells  of direct invis
    removeInvisibilitySpell(oPC);
//remove additions to hide/move-silent etc
    RemoveEffectsFromSpell ( oPC, SPELL_MASS_CAMOFLAGE );
    RemoveEffectsFromSpell ( oPC, SPELL_CAMOFLAGE );
    RemoveEffectsFromSpell ( oPC, SPELL_ONE_WITH_THE_LAND );


 RemoveEffectsFromSpell ( oPC, SPELL_FREEDOM_OF_MOVEMENT );
    RemoveSpecificEffect(EFFECT_TYPE_MOVEMENT_SPEED_INCREASE, oPC);

    //change silent/hide to minus great + remove invisibility and sanctuary
    int skill=GetSkillRank(SKILL_MOVE_SILENTLY,oPC);
    effect silent_decrease =EffectSkillDecrease(SKILL_MOVE_SILENTLY,skill);
    silent_decrease=ExtraordinaryEffect(silent_decrease);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,silent_decrease,oPC);

    skill=GetSkillRank(SKILL_HIDE,oPC);
    effect hide_decrease=   EffectSkillDecrease(SKILL_HIDE,skill);
    hide_decrease = ExtraordinaryEffect(hide_decrease);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT,hide_decrease,oPC);

    AssignCommand ( oPC, DelayCommand ( 1.0, AddSpeedMalus ( oPC ) ) );

}






