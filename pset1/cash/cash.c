#include <stdio.h>
#include <cs50.h>
#include <math.h>

// setting up global variables for use in the function count
int cents;
int coin_count = 0;
void count(int coin_value);


int main(void)
{
    float dollars;
//Ask the user for the input dollars
//if input is negative it asks for the input again
    do
    {
        dollars = get_float("Change owed: ");
    }
    while (dollars < 0);
//Multiplies dollars by 100 and rounds to get the number of cents 
    cents = round(dollars * 100);
//Runs the function block for the with the number of cents each coin is worth
    count(25);
    count(10);
    count(5);
    count(1);
//prints the number of coins needed
    printf("%i\n", coin_count);
}

//Takes the input- cents each coin is worth and subtracts from the cents until in no longer can
//Adds one to coin count so that it can count each time a coin is needed
void count(int coin_value)
{
    while (cents >= coin_value)
    {
        cents -= coin_value;
        coin_count ++;
    }
}