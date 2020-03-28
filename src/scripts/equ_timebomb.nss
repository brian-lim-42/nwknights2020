///////////Fired by OnItemLost - Actives Time Bomb////////////////////


void main()
{

       object oItem = OBJECT_SELF;
       object oPossessor = GetItemPossessor(oItem);

       location oBombplace = GetLocation (oItem);
       effect ePuff;
       effect eFire;
       ePuff=EffectVisualEffect(VFX_FNF_HOWL_ODD);
       eFire=EffectVisualEffect(VFX_FNF_FIREBALL);
       effect visual_effect = EffectVisualEffect(VFX_FNF_SCREEN_SHAKE);

       if (!GetIsPC(oPossessor))
       {
       ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eFire, oBombplace);
       DelayCommand (1.0, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, ePuff, oBombplace));
       DelayCommand (1.0,DestroyObject (oItem));
       object oFireTarget = GetFirstObjectInShape(SHAPE_CUBE, 15.0, oBombplace, OBJECT_TYPE_CREATURE);
            while(GetIsObjectValid(oFireTarget))
            {
            AssignCommand (oFireTarget, DelayCommand(1.0, ApplyEffectToObject (DURATION_TYPE_TEMPORARY, EffectDamage(d6(17), DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_ENERGY), oFireTarget)));
            DelayCommand(1.0, ApplyEffectToObject(DURATION_TYPE_INSTANT, visual_effect, oFireTarget));
            oFireTarget = GetNextObjectInShape(SHAPE_CUBE, 15.0, oBombplace, OBJECT_TYPE_CREATURE);
            }
       object oTarget;
       int nOpened;
       oTarget = GetFirstObjectInShape(SHAPE_CUBE, 15.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
            while(GetIsObjectValid(oTarget))
            {
                 if(GetLocked(oTarget))
                 {
                 nOpened = GetLocalInt(oTarget, "open") + 50;
                 SetLocalInt(oTarget, "open", nOpened);
                 AssignCommand(oTarget,ActionSpeakString(IntToString(150-nOpened)));
                 }
            oTarget = GetNextObjectInShape(SHAPE_SPHERE, 50.0, GetLocation(OBJECT_SELF), FALSE, OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
            }
       }
}
