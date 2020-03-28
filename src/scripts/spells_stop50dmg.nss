/* spells_stopstun
 * this is a script that should be used by all the stun spells.
 * it checks if the target recieved any dmg during last round and if so,
 * stops the stun effect.
 * this script should be called every round of the spell duration.
 *
 * there will be a local int on the pc that tell how much hp did he have
 * on spell start , and this script will check if te hp decreased from that.
 * (not just changed , cause he could been healed)
 * the var is called "hp_before_stun"
 */
 // NEED TO CHECK IF REMOVE TAKES ALL LINKED VISUAL EFFECTS OR NOT
#include "nwk_debug"

void main()
{
    object PC=OBJECT_SELF;
    int hp_before_stun=GetLocalInt(PC,"hp_before_stun");
    int curr_hp=GetCurrentHitPoints();
    object oPC = GetFirstPC();
   // SendMessageToPC(oPC,"hp before: "+IntToString(hp_before_stun)+
   //             " hp now: " +IntToString(curr_hp));

    if (curr_hp<hp_before_stun)
    {
        //search for all stunning effects and remove them
        //to save time , first check if it is temporary one ,
        //and only then dwell in.
        effect  e=GetFirstEffect(OBJECT_SELF);
        int e_type;
        while (GetIsEffectValid(e))// CAN HAVE 2 OR MORE EFFECTS SIMULTANISLY// && not_found_yet)
        {
          if (GetEffectDurationType(e)==DURATION_TYPE_TEMPORARY)
          {
 // SendMessageToPC(oPC,"insude the remove effect loop");
             e_type=GetEffectType(e);
             if((e_type==EFFECT_TYPE_CHARMED)||
                (e_type==EFFECT_TYPE_CONFUSED)||
                (e_type==EFFECT_TYPE_DAZED)||
                (e_type== EFFECT_TYPE_FRIGHTENED )||
                (e_type==EFFECT_TYPE_DOMINATED)||
                (e_type==EFFECT_TYPE_PARALYZE)||
                (e_type==EFFECT_TYPE_STUNNED) )
             {
                RemoveEffect(PC,e);
              ////CAN HAVE 2 OR MORE EFFECTS SIMULTANISLY////  not_found_yet=0;
             }
          }
          e=GetNextEffect(PC);
        }//of while

     } //of first script if
     else if (curr_hp>hp_before_stun)
        SetLocalInt(PC,"hp_before_stun",curr_hp);

    //SpeakString("total dealt is:"+IntToString(GetTotalDamageDealt()));

}
