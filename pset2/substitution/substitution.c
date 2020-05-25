#include<stdio.h>
#include<cs50.h>
#include<string.h>
#include<ctype.h>


string encrypt(string text, string key);
int main(int argc, string argv[])
{
    //stops code if user didn't gave two command line arguments
    if (argc != 2)
    {
        printf("Usage: ./substitution key\n");
        return 1;
    }
    
    
    string key = argv[1];
    int len = strlen(key);
    
    //stops code if all characters aren't letters
    for (int c = 0; c < len; c++)
    {
        if (!isalpha(key[c]))
        {
            printf("Usage: ./substitution key\n");
            return 1;
        }
        
        //stops code if any of the letters in the key are the same
        for (int n = c + 1 ; n < len; n++)
        {
            if (tolower(key[c]) == tolower(key[n]))
            { 
                printf("Usage: ./substitution key\n");
                return 1;
            }
        }

    }
    
    //stops code if they aren't 26 characters in key
    if (len != 26)
    {
        printf("Key must contain 26 characters.\n");
        return 1;
    }
    
    
    //gets input that will be encrypted
    string text = get_string("plaintext: ");
    
    //prints out the encripted text
    printf("ciphertext: %s\n", encrypt(text, key));
    
    
}

/*
for each letter in input see if it is lower or upper
    if upper mkae y the difference between letter and a
    change letter to be the value in key[y] lowercase
    else if lower mkae y the difference between letter and A
    change letter to be the value in key[y] uppercase
return final text
*/
string encrypt(string text, string key)
{
    for (int x = 0; x < strlen(text); x++)
    {
        if (isupper(text[x]))
        {
            int y = text[x] - 'A';
            text[x] = toupper(key[y]);
        }
        else if (islower(text[x]))
        {
            int y = text[x] - 'a';
            text[x] = tolower(key[y]);
        }
    }
    return text;
}  