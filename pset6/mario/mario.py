from cs50 import get_int

# Prompts user for the value for variable height
# Re-prompts user until they give a value that is between 1 and 8
while(True):
    height = get_int("Height: ")
    if (height >= 1 and height <= 8):
        break

for i in range(1, height + 1):
    
    # Prints out height - 1 spaces and i hastags on each line
    print(" " * (height - i), end="#" * i)
    print()