from cs50 import SQL
from sys import argv

# The main function of the code


def main():
    
    # Checks to make sure the right amount of command line arguments were given
    if (len(argv) != 2):
        print("Usage: python roster.py house")
        return

    # Opens the database and assigns the users given input to a variable house
    db = SQL("sqlite:///students.db")
    house = argv[1]
    
    # Assigns all of the values other then house in the database where house equals the variable house 
    database = db.execute("SELECT first, middle, last, birth FROM students WHERE house = ? GROUP BY first ORDER BY last", house)
    
    # Gets each row of input ontained from the database
    for x in database:
        data = []
        check = 0
        
        # Gets each dict from the row
        for y in x:
            
            # Checks to see if value middle is null for the row
            if (x[y] is None):
                check = 1
                continue
            
            # Adds value into list data
            data.append(x[y])
            
        # If value middle was null print out response without including value middle
        if (check == 1):
            print(f"{data[0]} {data[1]}, born {data[2]}")
            continue
        
        # Prints out response with all values obtained from database
        print(f"{data[0]} {data[1]} {data[2]}, born {data[3]}")
        
      
main()