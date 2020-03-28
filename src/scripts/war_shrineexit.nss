// Removes All Regenerate effects on oCreature
void main()
{
    object oCreature = GetExitingObject();
    if(GetIsObjectValid(oCreature))
    {

        effect eEffect = GetFirstEffect(oCreature);
        int i=1;
        //SendMessageToPC(oCreature,"First Effect type is"
        //            +IntToString(GetEffectType(eEffect))
        //            );
        if(GetIsEffectValid(eEffect))
        {
            do
            {
                //SendMessageToPC(oCreature,"In the Loop - counter="+IntToString(i)
                //  +   " Effect type is"
                //  +IntToString(GetEffectType(eEffect))
                //   );

                i++;
                if(GetEffectType(eEffect) == EFFECT_TYPE_REGENERATE)
                {
                   // SendMessageToPC(oCreature,"removing regeneration effect");
                    RemoveEffect(oCreature, eEffect);
                }
                eEffect = GetNextEffect(oCreature);
            }while(GetIsEffectValid(eEffect));
        }
    }
}

