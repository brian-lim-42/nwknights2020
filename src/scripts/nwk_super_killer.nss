// check if the killer is a cheater that deals to much damage in 1 hit.
// this script is run on any dieing man
void ExplodeAtLocation(object oPlayer,int nEffectID,float fDuration);

void main()
{
  object killer;
  if (GetTotalDamageDealt()>=250)
  {
    killer=GetLastDamager();
    SendMessageToPC(killer,"You are a cheater and will be booted. If you are not , Then: sorry! please report the forum");
    ExplodeAtLocation(killer,VFX_BEAM_ODD,1.0f);
    DelayCommand(10.0, BootPC(killer));

  }
}




void ExplodeAtLocation(object oPlayer,int nEffectID,float fDuration)
{
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(nEffectID),oPlayer,fDuration);
//DelayCommand(fDuration,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_COM_CHUNK_RED_LARGE),GetLocation(oPlayer)));
DelayCommand(fDuration,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(TRUE,TRUE),oPlayer,0.0f));
}


