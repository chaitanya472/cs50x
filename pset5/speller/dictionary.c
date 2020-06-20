// Implements a dictionary's functionality

#include <stdbool.h>
#include <stdio.h>
#include "dictionary.h"
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <ctype.h>

// Represents a node in a hash table
typedef struct node
{
    char word[LENGTH + 1];
    struct node *next;
}
node;

// Number of buckets in hash table
const unsigned int N = 26 * 26 * 26;

//Number of items in dictionary
int SIZE = 0;

// Hash table
node *table[N];

// Returns true if word is in dictionary else false
bool check(const char *word)
{
    //Finds and goes to it hash index
    int hashPlace = hash(word);

    //Checks each word in the linked list at hash index to see if the match the given word
    //If a word does match return true if not return false
    for (node *tmp = table[hashPlace]->next; tmp != NULL; tmp = tmp->next)
    {
        if (strcasecmp(tmp->word, word) == 0)
        {
            return true;
        }
    }
    return false;
}

// Hashes word to a number
unsigned int hash(const char *word)
{
    int l1 = (int) tolower(word[0]);
    l1 -= 'a';
    l1 *= 26 * 26;
    int l2 = 0;
    int l3 = 0;
    if (strlen(word) > 1)
    {
        l2 = (int) tolower(word[1]);
        l2 -= 'a';
        l2 *= 26;
        if (strlen(word) > 2)
        {
            l3 = (int) tolower(word[2]);
            l3 -= 'a';
        }
    }
    int hashValue = l1 + l2 + l3;
    return hashValue;
}

// Loads dictionary into memory, returning true if successful else false
bool load(const char *dictionary)
{
    setNull();
    //Opens and makes sure the dictionary can be accessed
    FILE *file = fopen(dictionary, "r");
    if (!file)
    {
        fclose(file);
        return false;
    }
    int check;

    //Will repeat til there are no items left in the file
    while (1 == 1)
    {
        char word[LENGTH + 1];
        const char *point = &word[0];

        //Takes one string at a tiem from the file and runs it through the hash function
        check = fscanf(file, "%s", word);
        if (check == EOF)
        {
            break;
        }
        int hashPlace = hash(point);

        //Finds the last node in the array at the hashPlace index
        node *tmp = table[hashPlace];
        node *current;
        while (tmp != NULL)
        {
            current = tmp;
            tmp = tmp->next;
            
        }

        //Makes a new node with the current word as word and NULL for the pointer in next
        current->next = malloc(sizeof(node));
        tmp = current->next;
        if (tmp == NULL)
        {
            fclose(file);
            return false;
        }
        strcpy(tmp->word, point);
        tmp->next = NULL;
        SIZE += 1;
    }

    //Closes the file and returns true
    fclose(file);
    return true;
}

// Returns number of words in dictionary if loaded else 0 if not yet loaded
unsigned int size(void)
{
    return SIZE;
}

// Unloads dictionary from memory, returning true if successful else false
bool unload(void)
{
    for (int x = 0; x < N; x++)
    {
        node *tmp = table[x];
        do
        {
            node *del = tmp;
            tmp = tmp->next;
            free(del);
        }
        while (tmp != NULL);
    }
    return true;
}

//Sets the first pointers for every array to null
void setNull(void)
{
    for (int n = 0; n < N; n++)
    {
        table[n] = malloc(sizeof(node));
        table[n]->next = NULL;
    }
}