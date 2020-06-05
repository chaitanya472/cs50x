#include<stdio.h>

int main(void)
{
/*
    This sort method pushes higher valued elements towards the right and lower value to the left
    It works by selecting every pair of elements and seeing if the lower value element
    is before the higer valued element
    If so swap the two elemets
    When one elemnt is pushed to the very end that element is no longer counted in the sorting 
    procces
    Keep on doing this till you program can no longer swap any more elements
*/

    //Makes list that will be sorted
    int list[] = {4, 12, 3, 19, 21, 7};
/*
Set swapcount to 1 - will set it to 0 later but set to 1 now so that the for loop 
on line 14 can run
*/
    int swapCount = 1;
    
    //Set x to 6 and increase by one every time
    //While there has been at least one swap done to the list keep running for loop
    for (int x = 6; swapCount != 0 ; x--)
    {
        //now that loop has started set swap count to 0
        swapCount = 0;
     
        /*   
        in range 0 to x -1 check one item on the list and item after
        if item before is greater swap the two
        after swap increase swap count by 1
        */
        
        for (int y = 0; y < x - 1; y++)
        {
            if (list[y] > list[y + 1]) 
            {
                int a = list[y];
                list[y] = list[y + 1];
                list[y + 1] = a;
                swapCount += 1;
            }
        }

    }
/*    
    to check if the code works
    for (int n = 0; n < 6; n++)
    {
        printf("%i\n", list[n]);
    }
*/
}