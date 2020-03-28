void main()
{
object oPlayer = GetLastUsedBy();
        location eLocation = GetLocation (oPlayer);
        effect eVisual = EffectVisualEffect(VFX_IMP_HEALING_X);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVisual, eLocation);
}
