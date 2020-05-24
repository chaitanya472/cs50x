# include<stdio.h>
# include<cs50.h>
#include<string.h>
#include<ctype.h>
#include<math.h>

int count_letters(string text);
int count_words(string text);
int count_sentences(string text);
int main(void)
{
    // Getting an input for a string
    string text = get_string("Text: ");
    
    int letters = count_letters(text);
    int words = count_words(text);
    int sentences = count_sentences(text);
    
    // l finds letters per 100 words in text
    float l = ((float) letters / words) * 100;
    
    //s findes sentenes per 100 words
    float s = ((float) sentences / words) * 100;
    
    //finds grade level using Coleman_Liau index
    float index = 0.0588 * l - 0.296 * s - 15.8;
    
    //print grade level
    if (index < 1)
    {
        printf("Before Grade 1\n");
    }
    else if (index >= 16)
    {
        printf("Grade 16+\n");
    }
    else
    {
        printf("Grade %0.f\n", round(index));
    }
    //printf("%i %i %i %0.2f %.2f %0.2f\n",letters, words, sentences, l, s, index);

}

/*
finds number of letters in the string given
    checks if each character if either upercase or lowercase 
    if they are add one to letterCount
    return letterCount as value for the function
*/
int count_letters(string text)
{
    int letterCount = 0;
    for (int l = 0; l <  strlen(text); l++)
    {
        if (islower(text[l]) || isupper(text[l]))
        {
            letterCount ++;
        }
    }
    return letterCount;
}


/*
finds number of words in the string given
    checks if each character is a space and if either have a upercase or lowercase character afterwards
    if they do add one to wordCount
    return wordCount as value for the function
*/
int count_words(string text)
{
    int wordCount = 1;
    for (int w = 0; w < strlen(text); w++)
    {    
        if (isblank(text[w]) && !isblank(text[w + 1]))
        {
            wordCount ++;
        }
    }
    return wordCount;
}

/*
finds number of sentences in the string given
    checks if each character if either . or ! or ? 
    if they are add one to sentenceCount
    return sentenceCount as value for the function
*/
int count_sentences(string text)
{
    int sentenceCount = 0;
    for (int s = 0; s < strlen(text); s++)
    {    
        if (text[s] == '.' || text[s] == '!' || text[s] == '?') 
        {
            sentenceCount += 1;
        }
    }    
    return sentenceCount;
}