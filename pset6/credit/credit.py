from cs50 import get_int


def main():

    # Gets number with get in to make sure no letter is inputed instead
    card = get_int("Number : ")

    # Storing the value of the checksum as a string
    value = str(checkSum(card))
    length = len(value)

    # If the last value of value isn't 0 it is Invalid
    if (value[length - 1] != '0'):
        print("INVALID")
        return

    string = str(card)
    number = int(string[0]) * 10
    number += int(string[1])
    length = len(string)

    # Checks to see if it matches the requirements of any card type
    if (length == 16):
        if (number > 50 and number < 56):
            print("MASTERCARD")
            return
        elif (number >= 40 and number <= 49):
            print("VISA")
            return
    elif(length == 15 and (number == 34 or number == 37)):
        print("AMEX")
        return
    elif (length == 13 and number >= 40 and number <= 49):
        print("VISA")
        return
    print("INVALID")


def checkSum(numbers):
    #  checkSum; returns true if value is a valid checksum
    #
    #  Uses Luhn's Algorithm to find the checkSum
    #
    #    1) Multiply every other digit by 2, starting with the number’s second-to-last digit,
    #      and then add those products’ digits together.
    #
    #    2) Add the sum to the sum of the digits that weren’t multiplied by 2.
    #
    #    3) If the total’s last digit is 0 (or, put more formally, if the total modulo 10 is congruent to 0),
    #      the number is valid!

    count = 0
    numbers = str(numbers)
    finalValue = 0
    for digit in reversed(numbers):
        if (count == 0):
            finalValue += int(digit)
            count = 1
        else:
            finalValue += digitSum(int(digit) * 2)
            count = 0
    return finalValue


# Gets the sum of all of the digits in a number
def digitSum(number):
    total = 0
    for x in str(number):
        total += int(x)
    return total


# Calling the main function
main()
