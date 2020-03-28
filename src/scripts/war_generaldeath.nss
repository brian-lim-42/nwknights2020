// Creates nEffectID on oPlayer for fDuration, then explodes oPlayer
void ExplodeAtLocation(object oPlayer,int nEffectID,float fDuration);

void main()
{
object oPC = GetLastSpeaker();
ExplodeAtLocation(oPC,VFX_BEAM_ODD,4.0f);

}

void ExplodeAtLocation(object oPlayer,int nEffectID,float fDuration)
{
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectVisualEffect(nEffectID),oPlayer,fDuration);
DelayCommand(fDuration,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_COM_CHUNK_RED_LARGE),GetLocation(oPlayer)));
DelayCommand(fDuration,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(TRUE,TRUE),oPlayer,0.0f));


}
