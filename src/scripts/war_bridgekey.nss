void main()
{
    object oPC = GetClickingObject();
    object oGate = OBJECT_SELF;
    object oEquip = GetFirstItemInInventory(oPC);
    while(GetIsObjectValid(oEquip))
    {
      if (GetTag(oEquip) == "BridgeKey")
      {
          DestroyObject(oEquip);
          ActionOpenDoor (oGate);
          PlaySound ("as_dr_woodvlgop2");
          DelayCommand(10.0, SetLocked (oGate, TRUE));
          DelayCommand(10.0, AssignCommand(oGate,ActionCloseDoor(oGate)));
          DelayCommand(10.0, PlaySound ("as_dr_woodvlgop2"));

          return;
      }

    oEquip = GetNextItemInInventory(oPC);
    }
}

////////////old lever script//////////////
//object oGate = GetObjectByTag("BRIDGE_GATE");
//SetLocked (oGate, FALSE);
//AssignCommand(oGate,ActionOpenDoor(oGate));
//PlayAnimation (ANIMATION_PLACEABLE_ACTIVATE);
//PlaySound ("as_dr_woodvlgop2");
//DelayCommand(13.0, SetLocked (oGate, TRUE));
//DelayCommand(13.0, AssignCommand(oGate,ActionCloseDoor(oGate)));
//DelayCommand(13.0, PlayAnimation (ANIMATION_PLACEABLE_DEACTIVATE));
//DelayCommand(13.0, PlaySound ("as_dr_woodvlgop2"));

