//pvp_restock
// restock kit items (clock,healing-potions) and ammo (throwing-axes,arrows etc)
//by PENTAGON

//future changes:
//use of GetItemPossessdby with call to specific items(for arrows :do all 4 types)
//to make script maybe faster

#include "nwk_constants"
#include "nwk_flag"
#include "nwk_lord"
#include "war_inc_stun"

/** returns the number of items (identified by sItem) on a pc.
 *  it checks the inventory and all the slots and sums the numbers
 */

int GetNumItems(object oTarget,string sItem)
{
    int nNumItems = 0;
    //loop through all inventory items
    object oItem = GetFirstItemInInventory(oTarget);
    while (GetIsObjectValid(oItem) == TRUE)
    {
        if (GetTag(oItem) == sItem)
        {
            nNumItems = nNumItems + GetNumStackedItems(oItem);
        }
        oItem = GetNextItemInInventory(oTarget);
    }
    //loop through all slots starting with 0 till max_slots(18)
    int slot_num;
    for (slot_num=0;slot_num<NUM_INVENTORY_SLOTS;slot_num++)
    {
        oItem = GetItemInSlot(slot_num,oTarget);
        if (GetIsObjectValid(oItem) == TRUE)
            if (GetTag(oItem) == sItem)
                    nNumItems = nNumItems + GetNumStackedItems(oItem);
    }


   return nNumItems;
}


/* fills the stacked object up till the max value.
 * all the pc inventory(and slots) will be checked and items
 * number summed , if it is lowwer than max , the diffrence
 * will be created by this item resref.
@parameters:
  oPC
  item - the item to check
  max  - max number of items in full stacked pc
 */
void fillStack(object oPC,object oAmmo,int max_ammo)
{
    string resref;
    string sTag = GetTag(oAmmo);

    //check how many pc currently have , if lower than max then create
    int current_num=GetNumItems(oPC,sTag);

  // SpeakString("we got "+IntToString(current_num)+" of "+sTag);

    if (current_num<max_ammo)
    {
        resref=GetResRef(oAmmo);
        CreateItemOnObject(resref, oPC,max_ammo-current_num);
    }
}


/* checks if item-tag is on an object.if so fills the stack for this
 * item and returns 1 , else it uses a givven script(typically creation
 * script) X times with regard to a certain local int(making sure
 * it wo`nt change in the process)
 * Item tag identification is by specific prefix AND sub-string (need both).
 * param: item_per_script - means in one creation script , how many stack items
 *          are gnerated.
 *        sum_or_exist - flag that tells (1=)whether the number in the local_int
            means how many times the script should be performed , or (2=)is it only
            a flag number and in any case , only one script will be done.
            see diff between darts(sum) and sniper_arrow(exist)
  returns 0 if item not found(but created by script)
          1 if item was found and stack filled
          2 on error : paramters=local_int or items_per_script were zero
 */

int restockItem(object oPC,string prefix,string sub_string,
                string script_name , string local_int,
                int items_per_script , int sum_or_exist)
{
     object oAmmo;
     string sTag;
     int Offset=GetStringLength(prefix);

     int local_value= GetLocalInt(oPC,local_int);

     int max_stack;
     if (sum_or_exist==2)   //local_value is only a flag
        max_stack=items_per_script;
     else                   //local_value means number of times
        max_stack= local_value * items_per_script;



     int item_found=0; //flag
     //if pc doesnt suppose to have this item , break!
     if (max_stack<=0)
        return 2;

     oAmmo = GetFirstItemInInventory(oPC);
     while((GetIsObjectValid(oAmmo))&&(!item_found))
     {
        sTag = GetTag(oAmmo);
        if (GetStringLeft(sTag,Offset)==prefix)
            if (FindSubString(sTag,sub_string)>0)
            {
                fillStack(oPC,oAmmo,max_stack);
                item_found=1;

            }
        oAmmo = GetNextItemInInventory(oPC);
      }
      //if we didnt find anything yet , search through slots by
      //looping through all slots starting with 0 till max_slots(18)
      int slot_num;

 if (!item_found)

    for (slot_num=0;slot_num<NUM_INVENTORY_SLOTS;slot_num++)
    {
        oAmmo = GetItemInSlot(slot_num,oPC);
        if (GetIsObjectValid(oAmmo) == TRUE)
        {
            sTag = GetTag(oAmmo);
            if (GetStringLeft(sTag,Offset)==prefix)
                 if (FindSubString(sTag,sub_string)>0)
                 {
                     fillStack(oPC,oAmmo,max_stack);
                     item_found=1;
                     break;  //the loop
                 }

        }
    }


    //check for unfound item, in that case create script.
    int i;
    int max_script;



    if (sum_or_exist==2)   //local_value is only a flag
        max_script=1;
     else                   //local_value means number of times
        max_script= local_value;
    if (!item_found)
    {
          for (i=1;i<=max_script;i++)
              ExecuteScript(script_name,oPC);
          //make sure local int value remains the same.
          SetLocalInt(oPC,local_int,local_value);
          return 0;
    }
    else
          return 1;
}



/* gets a cloak_tag and returns the kit-creation-script for the
 * entire kit.
 * for example : cloak_tag = "ktDefenceCloak"
 *              will return (script) "pvp_ktdefence"
 * REMARK:when changing kits , this table must be also changed.
 */
string getScriptByCloak(string cloak_tag)
{
  if      (cloak_tag=="ktSoundMindCloak") return "pvp_ktsound";
  else if (cloak_tag=="ktArcherCloak") return "pvp_ktarcher_1";
  else if (cloak_tag=="ktDefenseCloak") return "pvp_ktdefense";
  else if (cloak_tag=="ktDispelCloak") return "pvp_ktdispel";
  else if (cloak_tag=="ktElementAResistanceCloak") return "pvp_ktelement";
  else if (cloak_tag=="ktElementIResistanceCloak") return "pvp_ktelementice";
  else if (cloak_tag=="ktElementFResistanceCloak") return "pvp_ktelementfir";
  else if (cloak_tag=="ktElementLResistanceCloak") return "pvp_ktelementlig";
  else if (cloak_tag=="ktHealerCloak") return "pvp_kthealer";
  else if (cloak_tag=="ktMageCloak") return "pvp_ktmage";
  else if (cloak_tag=="ktOffenseCloak") return "pvp_ktoffense";
  else if (cloak_tag=="ktScoutCloak") return "pvp_ktscout";
  else if (cloak_tag=="ktSpellResistanceCloak") return "pvp_ktspell";
  else if (cloak_tag=="ktSpyCloak")    return "pvp_ktspy";
  else return "ERROR";
}


/**NOT IMPLEMENTED for now
   for ranged weapons we will use a local string that contains the
    following : (each unit means number of this weapon chosen ,from 1 to 3
    st[0] = darts
    st[1] = shurikans
    st[2] = thorwing-axes
    st[3] = arrows
    st[4] = bolts
    st[5] = bullets
    st[6] = ?
    all are refrenced with interface functions.

    returns how many times user has a specified selection.
*/
/*int GetUserSelection(object PC,int item)
{
    string selections=GetLocalString(PC,"selections");
    string "GetSubString
*/



/* we first unequip slots of ammo and cloak (not weapons)
   then check 1. clock  2.ammo and restock them
 //in general we dont want to destroy items in quick-slots(F1,F2 etc)
 //so we dont destroy stackable but do destroy one item with lots of charges
 //cause we dont know how to restore it`s uses without rest
*/

void main()
{
    object oPC = GetLastUsedBy();

////////do not allow restock if  carries flag
    // only let the PC through if he is silver team and not carrying the flag or ball
    if ( GetHasFlag ( oPC ) )
    {
        SpeakString("You cannot use this , if you are are carrying the flag");
        return;
    }
///////////////////////////////////////


 PlayAnimation (ANIMATION_PLACEABLE_OPEN);



 string prefix;
 string sTag;
 object oCloak;
 object oItem;

  //loop through all the items in the inventory
 //destroy all things related to a kit (not including special arrows)
 //use the cloak tag to save the cloak- type
 //script : pvp_ktdefence
 //cloak:ktDefenceCloak
 string cloak_type;  //will have the name of the kit
 prefix="kt";
 int Offset=GetStringLength(prefix);


//destroy all effects on target
 RemovePcEffects( oPC) ;
 DeleteLocalInt ( oPC, sStunChecksLeft );


 oCloak = GetFirstItemInInventory(oPC);

 while(GetIsObjectValid(oCloak))
 {
        sTag = GetTag(oCloak);
        if (GetStringLeft(sTag,Offset)==prefix)
        {
            //if it`s a cloak remeber it`s name
            if (GetStringRight(sTag,5)=="Cloak")
            {
                cloak_type=sTag;
              // SpeakString("found cloak,it`s tag is:"+sTag);
            }
            //destroys it if it`s not an arrow -was buged / Arrows DO need to be destroyed
            if (FindSubString(sTag,"Arrow")<0)
                DestroyObject(oCloak);
        }
        oCloak = GetNextItemInInventory(oPC);
 }
 //loop through all slots starting with 0 till max_slots(18)
 int slot_num;
 for (slot_num=0;slot_num<NUM_INVENTORY_SLOTS;slot_num++)
 {
     oCloak = GetItemInSlot(slot_num,oPC);
     if (GetIsObjectValid(oCloak) == TRUE)
     {
         sTag = GetTag(oCloak);
         if (GetStringLeft(sTag,Offset)==prefix)
         {
            //if it`s a cloak remeber it`s name
            if (GetStringRight(sTag,5)=="Cloak")
            {
                cloak_type=sTag;
                //SpeakString("found cloak,it`s tag is:"+sTag);
            }
            //destroys it if it`s not an arrow
             if (FindSubString(sTag,"Arrow")<0)
                  DestroyObject(oCloak);
        }
     }
 }

 /* now create the kit again , using the kit-creation script */
 string script_name=getScriptByCloak(cloak_type);
 if (script_name!="ERROR")
    ExecuteScript(script_name,oPC);



///////////////////////////////////////////////////////////////////////////

/* check the "arrows" local int , if pc got a special arrow
    give it to him   */
   int arrow=GetLocalInt(oPC,"kit_arrows");

     //use Arrowqq in purpose , IT WILL NOT BE FOUND  , and thus no prob
     // ktCriticalArrows
     // ktDispelArrows
     // ktPoisonArrows
     // ktSniperArrows
   if (arrow>0)
   {
    if (arrow==1)
       restockItem(oPC,"kt","Arrow","pvp_ktardispel" ,"arrows",10,2);
   //  restockItem(oPC,"kt","Arrowqq","pvp_ktardispel" ,"arrows",10,2);
    else if (arrow==2)
      restockItem(oPC,"kt","Arrow","pvp_ktarpoison" ,"arrows",10,2);
   //  restockItem(oPC,"kt","Arrowqq","pvp_ktarpoison" ,"arrows",10,2);
    else if (arrow==3)
       restockItem(oPC,"kt","Arrow","pvp_ktarsniper" ,"arrows",5,2);
    // restockItem(oPC,"kt","Arrowqq","pvp_ktarsniper" ,"arrows",10,2);
    else if (arrow==4)
        restockItem(oPC,"kt","Arrow","pvp_ktarcritical" ,"arrows",10,2);
    // restockItem(oPC,"kt","Arrowqq","pvp_ktarcritical" ,"arrows",50,2);
    }



///////////////////////////////////////////////////////////////////

 restockItem(oPC,"wp2","Darts",      "pvp_wdarts" ,     "darts",        50,1);
 restockItem(oPC,"wp2","Shuriken",   "pvp_wshuriken",   "shurikens",    50,1);
 restockItem(oPC,"wp2","ThrowingAxe","pvp_wthrowingaxe","throwing_axes",15,1);





/* now we need to work on the arrows(regular)/bullets/bolts
*/
 restockItem(oPC,"wp","Arrow", "pvp_wp3arrows","arrows",   99,1);
 restockItem(oPC,"wp","Bolt",  "pvp_wp3bolts"  ,"bolts",    99,1);
 restockItem(oPC,"wp","Bullet","pvp_wp3bullets","bullets",  99,1);

 AddLordProperties ( oPC );

 // if someone stole the item to set the respawn position give it back to player
 object oToggleRespawnItem = GetItemPossessedBy ( oPC, "toggle_respawn" );
 if ( ! GetIsObjectValid ( oToggleRespawnItem ) )
 {
     CreateItemOnObject ("toggle_respawn", oPC);
 }

 // replace "dead shifters friend" if necessary
 object oShiftersFriend = GetItemPossessedBy ( oPC, "shifter_frnd" );
 if ( ! GetIsObjectValid ( oShiftersFriend ) )
 {
     CreateItemOnObject ("sr_shifter_frnd", oPC);
 }

DelayCommand (2.0, PlayAnimation (ANIMATION_PLACEABLE_CLOSE));

// remove UV-BUG
ExecuteScript ( "sr_dbg_uv_bug", oPC );

}
