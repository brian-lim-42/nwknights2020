/** make the flag count from max to 0 time
  if and when the flag is  destroyed , the counting will
  auto stop ,cause obj isnt valid
*/


#include "nwk_constants"
#include "nwk_flag"
void main()
{
int time =nwk_stopper_upper_limit()  ;

object obj=OBJECT_SELF;



int i;
for (i=time;i>0;i--)
    DelayCommand(IntToFloat(time-i),  ActionSpeakString(IntToString(i)  ));

//dont need it , if obj destroyed , then
// destroy flag will not happen at allDelayCommand(IntToFloat(time),ExecuteScript("flag_changefalls",GetModule());
DelayCommand(IntToFloat(time),ExecuteScript("flag_destroyflag",obj));



}

