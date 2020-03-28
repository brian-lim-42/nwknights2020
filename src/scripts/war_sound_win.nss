//Winning sound
#include "nwk_team_onscore"

//PlaySound plays it when the origin of the sound is the script main creature.
//so someone far won`t hear anything.
//so this script does the trick - we make the PC itself call it and thus it
//originates from it`s current location.

void main()
{
    playWinRegularSound();
}
