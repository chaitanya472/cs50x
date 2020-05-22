# include <stdio.h>
# include <cs50.h>


bool checkSum(long value);
int main(void)
{
    long number;
    int count = 0;
    //Getting a positive number for function number
    do 
    {
        number = get_long("Number: ");
    }
    while (number < 0);

    // return invalid if checkSum is wrong
    if (checkSum(number) == false)
    {
        printf("INVALID\n");
        return 0;
    }
    
    //For each digit in the number until it only has two left add 1 to count
    //Add two more to count to make up for the code stoping before number reached the last digit
    while (number > 99)
    {
        count += 1;
        number /= 10;
    }
    count += 2;
    
    //MasterCard  if it has 16 digits and starts with 50-55
    if (count == 16 && number > 50 && number <= 55)
    {
        printf("MASTERCARD\n");
    }
    //Amex if it has 15 digits and starts with 34 or 37
    else if (count == 15 && (number == 34 || number == 37))
    {
        printf("AMEX\n");
    }
    //Visa if ith has 16 or 13 digits and starts with 4
    else if ((count == 16 || count == 13) && number / 10 == 4)
    {
        printf("VISA\n");
    }
    else 
    {
        printf("INVALID\n");
    }
}

/*
  checkSum; returns true if value is a valid checksum

  Uses Luhn's Algorithm to find the checkSum
  
    1) Multiply every other digit by 2, starting with the number’s second-to-last digit, 
      and then add those products’ digits together.
      
    2) Add the sum to the sum of the digits that weren’t multiplied by 2.
    
    3) If the total’s last digit is 0 (or, put more formally, if the total modulo 10 is congruent to 0),
      the number is valid!
*/
bool checkSum(long value)
{
    int sum = 0;
    for (int type = 0; value > 0; value /= 10)
    {
        // odd digit from end - add to sum
        if (type == 0)
        {
            sum += value % 10;
            type = 1;
        }
        // even digit from end - multiply by 2 and add its digits to sum
        else
        {
            int tmp = (value % 10) * 2;
            while (tmp > 0)
            {
                sum += tmp  % 10;
                tmp /= 10;
            }
            type = 0;
        }
    }
    //If last digit is 0 checkSum is valid
    return sum % 10 == 0 ;
}