/*
  author: shadow_in_the_dark
  name:   a_dbg_item
  date:   05/03/28

  OnActivate Event script for the debug Item.

  - Store last target to the activator
  - call the dbg dialogue

*/
#include "sr_admin_inc"
void main()
{
    SetLocalObject ( OBJECT_SELF, sDebugTarget, GetItemActivatedTarget () );
    AssignCommand ( OBJECT_SELF, ClearAllActions ( TRUE ) );
    AssignCommand ( OBJECT_SELF, ActionStartConversation ( OBJECT_SELF, "sr_debug", TRUE, FALSE ) );

}

