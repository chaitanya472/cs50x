#include<stdio.h>

int main(void)
{
/*
    This method sort by skipping element one
    Take the value of the next/n element and check every single element behind it in the list
    If it is less then any of the elements behind it push the greater elements up one spot
    When done set the list index before all of the elements you moved to n 
    Reapeat proces for each other element
*/
    
    
    //making list that will be sorted
    int list[8] = {13, 17, 82, 9, 3, 42, 99, 12};
    
/*    
    for x = 1 to 8 set n to list[x] and count to 0
        for x - 1 down to -1 or the number of items before list[x]
        check if items beofore are greater 
            if so then set the items before one index up and add one to count
        Set n or original value of list[x] to index x - count or the number of elements 
         you pushed up
        
    
*/
    for (int x = 1; x < 8; x++)
    {
        int n = list[x];
        int count = 0;
        for (int y = x - 1; y > -1; y-- )
        {
            if (list[y] > n)
            {
               list[y + 1] = list[y];
               count += 1;
            }
        }
        list[x - count] = n;
    }
/*    
    to check if the code works
    for (int n = 0; n < 8; n++)
    {
        printf("%i\n", list[n]);
    }
*/
}