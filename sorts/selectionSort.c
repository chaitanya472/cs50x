#include<stdio.h>

int main(void)
{
/*
    This method sorts by moving the smallest value elemnts to the start then stops sorting them
    It works by going along the list and picks the lowest value element
    After its done it swaps that element with the first element
    When smallest element is swapped it is no longer count in the sorting method
    It keeps on going till every single number is sorted even if they are already in order
*/
    //Makes list that will be sorted
    int list[] = {23, 94, 2, 50, 18, 7, 49, 11};
/*
    for 0 to 8 or number of items in list
        set n to list[x] or the current lowest value
*/
    for(int x = 0; x < 8; x++)
    {
        int n = list[x];
        int m;
        
/*
        for x+1 to 8 check to see if and items on the list are lesser then or equal to n
        set n to that item in the list
        set m to the index to of that item
*/
        for(int y = x + 1; y < 8; y++ )
        {
            if (n >= list[y])
            {
                n = list[y];
                m = y;
            }
        }
        //set list[m] or index of the lowest item to list[x]
        list[m] = list[x];
        
        //set list[x] to n or the value of the lowest item
        list[x] = n;
    }

/*
    to check if the code works

    for (int n = 0; n < 6; n++)
    {
        printf("%i\n", list[n]);
    }
*/

}