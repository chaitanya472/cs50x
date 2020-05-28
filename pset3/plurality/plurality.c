#include <cs50.h>
#include <stdio.h>
#include <string.h>

// Max number of candidates
#define MAX 9

// Candidates have name and vote count
typedef struct
{
    string name;
    int votes;
}
candidate;

// Array of candidates
candidate candidates[MAX];

// Number of candidates
int candidate_count;

// Function prototypes
bool vote(string name);
void print_winner(void);

int main(int argc, string argv[])
{
    // Check for invalid usage
    if (argc < 2)
    {
        printf("Usage: plurality [candidate ...]\n");
        return 1;
    }

    // Populate array of candidates
    candidate_count = argc - 1;
    if (candidate_count > MAX)
    {
        printf("Maximum number of candidates is %i\n", MAX);
        return 2;
    }
    
    for (int i = 0; i < candidate_count; i++)
    {
        candidates[i].name = argv[i + 1];
        candidates[i].votes = 0;
    }

    int voter_count = get_int("Number of voters: ");

    // Loop over all voters
    for (int i = 0; i < voter_count; i++)
    {
        string name = get_string("Vote: ");

        // Check for invalid vote
        if (!vote(name))
        {
            printf("Invalid vote.\n");
            i -= 1;
        }
    }

    // Display winner of election
    print_winner();
}

// Update vote totals given a new vote
bool vote(string name)
{
    // Checks if the vote was a part of the group candidates 
    //If so return false
    // If not return true
    for (int x = 0; x < candidate_count; x++)
    {
        if (strcmp(name, candidates[x].name) == 0)
        {
            candidates[x].votes += 1;
            return true;
        }
    }
    return false;
}

// Print the winner (or winners) of the election
void print_winner(void)
{
    // Sorts them in order form least to greatest
    int count = candidate_count -= 1;
    for (int m = 0; m < count; m++)
    {
        if (candidates[m].votes >= candidates[m + 1].votes)
        {
            candidate a = candidates[m];
            candidates[m] = candidates[m + 1];
            candidates[m + 1] = a;
        }
    }
    
    //prints out the last element's votes out
    int vote_count = candidates[count].votes;
    printf("%s\n", candidates[count].name);
    
    //Checks each element in the array to see if they are equal to the last element
    //If so print out element name else break
    for (int j = 1 ; j < count + 1; j++)
    {
        if (candidates[count - j].votes == vote_count)
        {
            printf("%s\n", candidates[count - j].name);
        }
    }

    return;
}