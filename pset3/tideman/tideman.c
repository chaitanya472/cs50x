#include <cs50.h>
#include <stdio.h>
#include <string.h>

// Max number of candidates
#define MAX 9

// preferences[i][j] is number of voters who prefer i over j
int preferences[MAX][MAX];

// locked[i][j] means i is locked in over j
bool locked[MAX][MAX];

// Each pair has a winner, loser
typedef struct
{
    int winner;
    int loser;
}
pair;

// Array of candidates
string candidates[MAX];
pair pairs[MAX * (MAX - 1) / 2];
int pair_count;
int candidate_count;

// Function prototypes
bool vote(int rank, string name, int ranks[]);
void record_preferences(int ranks[]);
void add_pairs(void);
void sort_pairs(void);
void lock_pairs(void);
void print_winner(void);
bool checkPath(int point1, int ponit2);

int main(int argc, string argv[])
{
    // Check for invalid usage
    if (argc < 2)
    {
        printf("Usage: tideman [candidate ...]\n");
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
        candidates[i] = argv[i + 1];
    }

    // Clear graph of locked in pairs
    for (int i = 0; i < candidate_count; i++)
    {
        for (int j = 0; j < candidate_count; j++)
        {
            locked[i][j] = false;
        }
    }

    pair_count = 0;
    int voter_count = get_int("Number of voters: ");

    // Query for votes
    for (int i = 0; i < voter_count; i++)
    {
        // ranks[i] is voter's ith preference
        int ranks[candidate_count];

        // Query for each rank
        for (int j = 0; j < candidate_count; j++)
        {
            string name = get_string("Rank %i: ", j + 1);

            if (!vote(j, name, ranks))
            {
                printf("Invalid vote.\n");
                return 3;
            }
        }

        record_preferences(ranks);

        printf("\n");
    }

    add_pairs();
    sort_pairs();
    lock_pairs();
    print_winner();
    return 0;
}

// Update ranks given a new vote
bool vote(int rank, string name, int ranks[])
{
    for (int c = 0; c < candidate_count; c++)
    {
        if (strcmp(name, candidates[c]) == 0)
        {
            ranks[rank] = c;
            return true;
        }
    }
    return false;
}

// Update preferences given one voter's ranks
void record_preferences(int ranks[])
{
    for (int i = 0; i < candidate_count; i++)
    {
        for (int j = i + 1; j < candidate_count; j++)
        {
            preferences[ranks[i]][ranks[j]] += 1;
        }
    }
}

// Record pairs of candidates where one is preferred over the other
void add_pairs(void)
{
    pair_count = 0;
    for (int x = 0; x < candidate_count; x++)
    {
        for (int y = x + 1; y < candidate_count; y++)
        {  
            if (preferences[x][y] > preferences[y][x])
            {
                pairs[pair_count].winner = x;
                pairs[pair_count].loser = y;
                pair_count++;
            }
            else if (preferences[y][x] > preferences[x][y])
            {
                pairs[pair_count].winner = y;
                pairs[pair_count].loser = x;
                pair_count++;
            }
        }
    }
}

// Sort pairs in decreasing order by strength of victory
void sort_pairs(void)
{
    for (int x = 1; x < pair_count ; x++)
    {
        int n = preferences[pairs[x].winner][pairs[x].loser];
        pair pair = pairs[x];
        int count = 0;
        for (int y = x - 1; y >= 0; y--)
        {
            int m = preferences[pairs[y].winner][pairs[y].loser];
            if (n > m)
            {
                pairs[y + 1] = pairs[y];
                count += 1;
            }
        }
        pairs[x - count] = pair;
    }
}

// Lock pairs into the candidate graph in order, without creating cycles
void lock_pairs(void)
{
    // TODO
    for (int x = 0; x < pair_count; x++)
    {
        if (checkPath(pairs[x].loser, pairs[x].winner) == false)
        {
            locked[pairs[x].winner][pairs[x].loser] = true;
        }
    }
    
    return;
}

// Print the winner of the election
void print_winner(void)
{
    // TODO
    for (int i = 0; i < candidate_count; i++)
    {
        int m = 0;
        for (int j = 0; j < candidate_count; j++)
        {
            if (locked[j][i] == true)
            {
                m = 1;
                break;
            }

        }
        if (m == 0)
        {
            printf("%s\n", candidates[i]);
        }
    }
}







//Checks if their is path from point 1 to point 2
bool checkPath(int point1, int point2)
{
    if (locked[point1][point2] == true)
    {
        return true;
    }

    for (int i = 0; i < pair_count; i++)
    {
        if (locked[point1][i] == true)
        {
            if (checkPath(i, point2) == true)
            {
                return true;
            }
        }
    }
    return false;
}
