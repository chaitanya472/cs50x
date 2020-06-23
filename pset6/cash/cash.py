from cs50 import get_float

CHANGE = -1


def main():
    global CHANGE

    # Makes sure the value of change is positive
    while (CHANGE < 0):
        CHANGE = get_float("Change owed: ")

    # Rounds and multiplies CHANGE by 100 to make sure the variable is accurate
    CHANGE *= 100
    round(CHANGE)

    # Adds the value of the function coins with the value of a quarter, dime, nickel, and penny
    coinCount = coins(25) + coins(10) + coins(5) + coins(1)
    print(f"{coinCount}")


def coins(cents):
    global CHANGE
    count = 0
    while (CHANGE >= cents):
        CHANGE -= cents

        # Add one to count while CHANGE is  greater cents
        count += 1
    return count


# Runs the main function
main()