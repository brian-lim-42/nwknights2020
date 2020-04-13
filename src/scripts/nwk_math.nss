//nwk_math


/** retuns X mod Y.
 * example: 10 mod 3 = 1 . calcaule 10/3 = (int)3. do 3x3=9 ,  do 10-9=1
 */
int mod(int x, int y)
{
    int div =  x/y; //truncated to int
    return x - (div * y);
}

/* returns x mod 10 */
int mod10(int x)
{
    string st=IntToString(x);
    string reminder=GetStringRight(st,1);
    return StringToInt(reminder);
}

int bound(int value, int lBound, int uBound) {
    if (value > uBound) {
        return uBound;
    }
    else if (value < lBound) {
        return lBound;
    }
    return value;
}

