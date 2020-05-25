#include <stdio.h>
#include <cs50.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>

string encrypt(string text, int key);
int main(int argc, string argv[])
{
    //checks to make sure you only put in two command-line arguments 
    // - if not stop code and print Usage: ./caesar key
    if (argc != 2)
    {
        printf("Usage: ./caesar key\n");
        return 1;
    }

    //checks each character to make sure they are all digits
    // - if not stop code and print Usage: ./caesar key    
    for (int i = 0; i < strlen(argv[1]); i++)
    {
        if (!isdigit(argv[1][i]))
        {
            printf("Usage: ./caesar key\n");
            return 1;
        }
    }
    
    //changes string given in command line argument to an interger stored in variable key
    int key = atoi(argv[1]);
    
    //Getting text user wants encrypted
    string text = get_string("plaintext : ");
    
    //Prints out the text after going through encrypt
    printf("ciphertext: %s\n ", encrypt(text, key));
    
}


/*
Takes text and moves each letter up by key letters
Keeps each letter uppercase or lowercase if they were before changing from function
If letter is Z or z change letter to A or a
If
*/
string encrypt(string text, int key)
{
    for (int x = 0; x < strlen(text); x++)
    {
        for (int y = 0; y < key; y++)
        {
            if (islower(text[x]))
            {
                if (text[x] == 'z')
                {
                    text[x] = 'a';
                }
                else
                {
                    text[x] ++;
                }
            }
            else if (isupper(text[x]))
            {
                if (text[x] == 'Z')
                {
                    text[x] = 'A';
                }
                else
                {
                    text[x] ++;
                }
            }
        }
    }
    return text;
}