#include <cs50.h>
#include <stdio.h>

int main(void)
{
    // Ask the user for the input height
    // If the input isn't 1 or 8 or between the two ask again
    int height = 0;
    do 
    {
        height = get_int("Height: ");
    }
    while (height < 1 || height > 8);
    
    //For i in range 1 to height
    //  For m in range I to height
    //      print a space
    //  For j in range 0 to I
    //      print 1 hastag
    //print new line
    
    for (int i = 1; i <= height; i++)
    {
        for (int m = height - i; m > 0; m--)
        {
            printf(" ");
        }
        for (int j = 0; j < i; j ++)
        {
            printf("#");
        }
        printf("\n");
    }
    
}
