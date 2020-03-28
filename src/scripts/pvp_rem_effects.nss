/*
  author: shadow_in_the_dark
  name:   pvp_rem_effects
  date:   05/02/28

*/
#include "nwk_mvp"
void main()
{
    object oPC = GetPCSpeaker();
    //remove first all effects to avoid a problem with shapeshifters
    RemovePcEffects( oPC);


    // remove all henchmen and companions
    if (GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC) != OBJECT_INVALID)
        DestroyObject(GetAssociate(ASSOCIATE_TYPE_ANIMALCOMPANION, oPC), 0.5);
    if (GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC) != OBJECT_INVALID)
        DestroyObject(GetAssociate(ASSOCIATE_TYPE_SUMMONED, oPC), 0.5);
    if (GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC) != OBJECT_INVALID)
        DestroyObject(GetAssociate(ASSOCIATE_TYPE_FAMILIAR, oPC), 0.5);


}

