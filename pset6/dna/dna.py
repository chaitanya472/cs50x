from sys import argv
from csv import reader
import os


# The main function of the code
def main():

    # If  2 command like arguments aren't given prints an error message
    if (len(argv) != 3):
        print("Usage: python dna.py data.csv sequence.txt")
        return
    directory, file = argv[1].split('/')

    # Goes to the folder where csv file is held so it can open the csv file
    os.chdir(directory)
    with open(file, 'r') as csvfile:

        # Puts the contens of the csv file into the list database
        database = reader(csvfile)

        # Gets only the strs from database and puts them into list strs
        strs = getStrTypes(next(database))
        count = []

        # For each str find the highest amount of times they are repeated consecutively
        for x in strs:
            count.append(checkSequence(x))

        compareData(strs, count, database)

# Gets all of the types of strs from the csv file into a list


def getStrTypes(strNames):
    strTypes = []

    # Gets and returns the str names from the given input
    for x in range(len(strNames) - 1):
        strTypes.append(strNames[x + 1])
    return strTypes

# Checks the give txt file and puts it in memory then checks to see the most amount of times an str was
# consecutively repeated


def checkSequence(strs):

    # Goes to directory sequences so it can open the text file
    directory, file = argv[2].split('/')
    os.chdir("..")
    os.chdir(directory)
    with open(file, 'r') as txtfile:

        # Takes the contents of the file and puts it into the string sequence
        sequence = txtfile.readline()
    length = len(strs)
    current = 0
    final = 0
    i = 0

    # Repeats until it has checked every char to see if they are part of the str
    while(i < len(sequence)):

        # Checks to see if the char i is the start of the str
        if (sequence[i:i + length] == strs):

            # Adds one to the current amount of consecutive strs and move i so it won't check any of the
            # chars in the str
            current += 1
            i += length - 1

        # Checks to see if the current consecutive strs has stopped
        elif (current > 0):

            # Checks if current consecutive str count is greater then the greatest consecutive str count
            if (current > final):

                # Changes the greatest consecutive str count to the current consecutive str
                final = current

            # Sets the current count to 0
            current = 0
        i += 1

    # Makes one lest check to see if current is greater then final
    if (current > final):
        final = current
    return final

# Compares the greatest consecutive counts from the file with the dna in the database


def compareData(strs, count, database):
    check = 1
    name = ''

    # For every row in database repeate the following
    for row in database:

        # Starts from 1 so it won't run the names through the code
        for l in range(1, len(row)):

            # If the count value is equal to the value in row for the Str
            # Set up the variable for name and keep check as 0
            if (int(count[l - 1]) == int(row[l])):
                check = 0
                name = row[0]

            # Else set check to 1 and break
            else:
                check = 1
                break

        # If the earlier check was still 0 so t never went through the else statement it prints row
        # and returns the function
        if (check == 0):
            print(name)
            return
    # If none of the Str counts matched print no match
    print("No match")


# Calls the main function
main()