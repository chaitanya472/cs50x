from cs50 import get_int

# Prompts user for the value for variable height
# Re-prompts user until they give a value that is between 1 and 8
while (True):

    height = get_int("Height: ")
    if (height >= 1 and height <= 8):
        break
    
for i in range(1, height + 1):
    
    # Prints out height - i spaces and i hastags each line
    print(" " * (height - i), end="#" * i)
    
    # Prints out 2 spaces and i hastags each line
    print(" ", "#" * i)
    