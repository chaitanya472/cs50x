#include <cs50.h>
#include <stdio.h>
#include <string.h>

// Max voters and candidates
#define MAX_VOTERS 100
#define MAX_CANDIDATES 9

// preferences[i][j] is jth preference for voter i
int preferences[MAX_VOTERS][MAX_CANDIDATES];

// Candidates have name, vote count, eliminated status
typedef struct
{
    string name;
    int votes;
    bool eliminated;
}
candidate;

// Array of candidates
candidate candidates[MAX_CANDIDATES];

// Numbers of voters and candidates
int voter_count;
int candidate_count;

// Function prototypes
bool vote(int voter, int rank, string name);
void tabulate(void);
bool print_winner(void);
int find_min(void);
bool is_tie(int min);
void eliminate(int min);

int main(int argc, string argv[])
{
    // Check for invalid usage
    if (argc < 2)
    {
        printf("Usage: runoff [candidate ...]\n");
        return 1;
    }

    // Populate array of candidates
    candidate_count = argc - 1;
    if (candidate_count > MAX_CANDIDATES)
    {
        printf("Maximum number of candidates is %i\n", MAX_CANDIDATES);
        return 2;
    }
    for (int i = 0; i < candidate_count; i++)
    {
        candidates[i].name = argv[i + 1];
        candidates[i].votes = 0;
        candidates[i].eliminated = false;
    }

    voter_count = get_int("Number of voters: ");
    if (voter_count > MAX_VOTERS)
    {
        printf("Maximum number of voters is %i\n", MAX_VOTERS);
        return 3;
    }

    // Keep querying for votes
    for (int i = 0; i < voter_count; i++)
    {

        // Query for each rank
        for (int j = 0; j < candidate_count; j++)
        {
            string name = get_string("Rank %i: ", j + 1);
            
            // Record vote, unless it's invalid
            if (!vote(i, j, name))
            {
                printf("Invalid vote.\n");
                return 4;
            }
        }
        printf("\n");
    }

    // Keep holding runoffs until winner exists
    while (true)
    {
        // Calculate votes given remaining candidates
        tabulate();

        // Check if election has been won
        bool won = print_winner();
        if (won)
        {
            break;
        }

        // Eliminate last-place candidates
        int min = find_min();
        bool tie = is_tie(min);

        // If tie, everyone wins
        if (tie)
        {
            for (int i = 0; i < candidate_count; i++)
            {
                if (!candidates[i].eliminated)
                {
                    printf("%s\n", candidates[i].name);
                }
            }
            break;
        }

        // Eliminate anyone with minimum number of votes
        eliminate(min);

        // Reset vote counts back to zero
        for (int i = 0; i < candidate_count; i++)
        {
            candidates[i].votes = 0;
        }
    }
    return 0;
}

// Record preference if vote is valid
bool vote(int voter, int rank, string name)
{
    for (int c = 0; c < candidate_count; c++)
    {
        if (strcmp(name, candidates[c].name) == 0) 
        {
            preferences[voter][rank] = c;
            return true;
        }
    }
    return false;
}













// Tabulate votes for non-eliminated candidates
// If eliminated checks the voters next non elimnated preference
void tabulate(void)
{
    for (int p = 0; p < candidate_count; p++)
    {
        candidates[p].votes = 0;
    }
    for (int m = 0; m < voter_count; m++)
    {
        for (int p = 0; p < candidate_count; p++)
        {
            if (candidates[preferences[m][0]].name == candidates[p].name)
            {
                if (candidates[p].eliminated == false)
                {
                    candidates[p].votes += 1;
                }
                else
                {
                    int y = 1;
                    for (int s = 1; s < candidate_count; s++)
                    {
                        if (y == 0)
                        {
                            break;
                        }
                        for (int j = 0; j < candidate_count - 1; j++)
                        {
                            if (y == 0)
                            {
                                break;
                            }
                            if (strcmp(candidates[preferences[m][s]].name, candidates[j].name) == 0 
                                && candidates[j].eliminated == false)
                            {
                                candidates[j].votes += 1;
                                y = 0;
                            }
                        }
                    }
                }
            }
        }
    }
}

// Print the winner of the election, if there is one
bool print_winner(void)
{
    int y = 0;
    float halfVotes = (float) voter_count;
    halfVotes /= 2;
    
    for (int w = 0; w < candidate_count; w++)
    {
        if (candidates[w].votes > halfVotes)
        {
            printf("%s\n", candidates[w].name);
            y += 1;
        }
    }
    if (y != 0)
    {
        return true;
    }
    return false;
}

// Return the minimum number of votes any remaining candidate has
int find_min(void)
{
    int min = 101;
    for (int q = 0; q < candidate_count; q++)
    {
        if (min > candidates[q].votes && candidates[q].eliminated == false)
        {
            min = candidates[q].votes;
        }
    }
    return min;
}

// Return true if the election is tied between all candidates, false otherwise
bool is_tie(int min)
{
    int x = 0;
    int y = 0;
    for (int r = 0; r < candidate_count; r++)
    {
        if (candidates[r]. votes == min && candidates[r].eliminated == false)
        {
            x += 1;
        }
        if (candidates[r]. eliminated == false)
        {
            y += 1;
        }
    }
    if (x == y)
    {
        return true;
    }
    return false;
}

// Eliminate the candidate (or candidiates) in last place
void eliminate(int min)
{
    for (int e = 0; e < candidate_count; e++)
    {
        if (candidates[e].votes == min && candidates[e].eliminated == false)
        {
            candidates[e].eliminated = true;
        }
    }
    return;
}
