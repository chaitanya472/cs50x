
#include <stdio.h>
#include <cs50.h>

void blocks(int block_count, char type);
int main(void)
{
    int height;
    do
    {
        height = get_int("Height: ");
    }
    while(height < 1 || height > 8);

    for ( int i = 1; i <= height; i++)
    {
        blocks(i - height , ' '  );
        blocks(-i, '#');
        printf("  ");
        blocks(-i, '#');
        printf("\n");
    }
}

void blocks(int block_count, char type)
{
        for (int m = block_count;  m < 0; m++)
        {
            printf("%c", type);
        }
}