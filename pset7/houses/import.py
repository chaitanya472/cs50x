from cs50 import SQL
from csv import reader
from sys import argv


# The main function of the code
def main():
    # Makes sure the correct amount of command line arguments are given
    if (len(argv) != 2):
        print("Usage: python roster.py characters.csv")
        exit()
    
    # Takes all of the information from the csv file and puts it into a variable
    with open(argv[1]) as file:
        text = reader(file)
        
        # Removes the first line of reader for the function add to Database
        next(text)
        addToDatabase(text)

# Adds all of the values from the csv file into the database    


def addToDatabase(reader):
    
    # Gets into the SQL database
    db = SQL("sqlite:///students.db")
    
    db.execute("DELETE FROM students")
    
    for row in reader:
        nameNumb = countNames(row[0])
        
        # If there are 3 names it checks row for a first middle and last name
        if (nameNumb == 3):
            first, middle, last = row[0].split(' ')
            # Adds in the seperated names, house, and date into the database
            db.execute("INSERT INTO students (first, middle, last, house, birth) VALUES(?, ?, ?, ?, ?)",
                       first, middle, last, row[1], row[2])
        
        # If there are 2 names it only checks for a first and last name then sets middle to none
        else:
            first, last = row[0].split(' ')
            
            # Adds in the first and last names, house, and date into the database
            db.execute("INSERT INTO students (first, last, house, birth) VALUES(?, ?, ?, ?)",
                       first, last, row[1], row[2])

# Counts the number of names in the given full name


def countNames(name):
    
    # Starts count as 1 then everytime there is a space adds 1 to count
    # Once done returns count
    count = 1
    for l in name:
        if (l.isspace()):
            count += 1
    return count
 
     
# Calling the main function        
main()