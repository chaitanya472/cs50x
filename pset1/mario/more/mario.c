
#include <stdio.h>
#include <cs50.h>

//Saves the function blocks
void blocks(int block_count);
int main(void)
{
    // Ask the user for the input height
    // If the input isn't 1 or 8 or between the two ask again
    int height;
    do
    {
        height = get_int("Height: ");
    }
    while (height < 1 || height > 8);

    //For i in range 1 to height
    //  For m in range i - height to 0
    //      print a space
    //  Runs the function blocks
    //  print two spaces
    //  runs the function blocks
    //  prints a new line

    for (int i = 1; i <= height; i++)
    {
        for (int m = height - i; m > 0; m--)
        {
            printf(" ");
        }
        blocks(i);
        printf("  ");
        blocks(i);
        printf("\n");
    }
}

//code for function blocks - takes one input block_count
//  for j in range 0 to block_count
void blocks(int block_count)
{
    for (int j = 0; j < block_count ; j++)
    {
        printf("#");
    }
}