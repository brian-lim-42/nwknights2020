/*
  author: shadow_in_the_dark
  name:   sr_admin_reg
  date:   05/01/02

  pre - register a DM as administrator
  activation has to be done at the entry guardian

# DM can register himself as "admin" at the Entry Guardian
# cd-key will be stored in a database (NWN)
# in game authentification compare if cd-key is registered
# benefits:
- each server provider becomes the special "admin" rights
- no account name depending authentification
- no mod change to introduce "new" admin

*/
#include "sr_admin_inc"
void main()
{
    StorePreAdminKey ( GetPCSpeaker () );
}

