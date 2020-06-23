from cs50 import get_string


def main():
    
    # Gets text from user
    text = get_string("Text: ")
    
    # Sets counter for letters l, word w, and sentences s
    l = 0
    w = 1
    s = 0
    count = 0

    for char in text:
        
        # if char is a letter add 1 to l
        if (char.isalpha()):
            l += 1
        
        # if char is a space and the char before it wasn't a space add on to s
        elif (char == ' ' and (count == 0 or text[count - 1] != ' ')):
            w += 1
                
        # if char is a period, exclamation point, or a question mark add one to s
        elif (char == '.' or char == '!' or char == '?'):
            s += 1
        count += 1
    colemnan_Liau_Formula(l, w, s)

# Using the number of letters words and sentences run the Coleman Liau formula


def colemnan_Liau_Formula(letters, words, sentences):
    
    # Sets letter to be the number of letters for every hundred words
    letters = (letters/words) * 100
    
    # Sets sentences to be the number of sentences for every hundred words
    sentences = (sentences/words) * 100
    
    # Uses the Coleman Liau formula to find the grade level
    gradeLevel = 0.0588 * letters - 0.296 * sentences - 15.8
    
    # Prints out the grade level
    if (gradeLevel < 1):
        print("Before Grade 1")
    elif (gradeLevel >= 16):
        print("Grade 16+")
    else:
        print(f"Grade {round(gradeLevel)}")
        
        
# Calls the main function
main()