void main()
{
object oMaster = GetLastSpeaker ();
object oHenchMan = GetHenchman (oMaster);
DestroyObject (oHenchMan);
}
