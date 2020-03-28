//::///////////////////////////////////////////////
//:: Storm of Vengeance: Heartbeat
//:: NW_S0_StormVenC.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Creates an AOE that decimates the enemies of
    the cleric over a 30ft radius around the caster
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 8, 2001
//:://////////////////////////////////////////////

#include "NW_I0_SPELLS"
void main()
{
    //Declare major variables
    effect eAcid = EffectDamage(d6(3), DAMAGE_TYPE_ACID);
    effect eElec = EffectDamage(d6(6), DAMAGE_TYPE_ELECTRICAL);
  //  effect eStun = EffectStunned();
    effect eVisAcid = EffectVisualEffect(VFX_IMP_ACID_S);
    effect eVisElec = EffectVisualEffect(VFX_IMP_LIGHTNING_M);
    effect eVisStun = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_DISABLED);
    effect eDur = EffectVisualEffect(VFX_DUR_CESSATE_NEGATIVE);
  //  effect eLink = EffectLinkEffects(eStun, eVisStun);
  //  eLink = EffectLinkEffects(eLink, eDur);
    float fDelay;
    //Get first target in spell area
    object oTarget = GetFirstInPersistentObject();
    while(GetIsObjectValid(oTarget))
    {
        if(!GetIsFriend(oTarget, GetAreaOfEffectCreator()) && !GetIsReactionTypeFriendly(oTarget, GetAreaOfEffectCreator()))
        {
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(GetAreaOfEffectCreator(), SPELL_STORM_OF_VENGEANCE));
            //Make an SR Check
            fDelay = GetRandomDelay(0.5, 2.0);
            if(MyResistSpell(GetAreaOfEffectCreator(), oTarget, fDelay) == 0)
            {
                //Make a saving throw check
                if(MySavingThrow(SAVING_THROW_REFLEX, oTarget, GetSpellSaveDC(), SAVING_THROW_TYPE_ELECTRICITY, GetAreaOfEffectCreator(), fDelay) == 0)
                {
                    //Apply the VFX impact and effects
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisElec, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eElec, oTarget));
                 //   DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eLink, oTarget, RoundsToSeconds(2)));
                }
                else
                {
                    //Apply the VFX impact and effects
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisAcid, oTarget));
                    DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eAcid, oTarget));
                }
            }
        }
        //Get next target in spell area
        oTarget = GetNextInPersistentObject();
    }
}
