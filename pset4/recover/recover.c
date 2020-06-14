#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>


int main(int argc, char *argv[])
{
    //Checks code to make sure only one command line argument is given
    if (argc != 2)
    {
        printf("Usage: ./recover key\n");
        return 1;
    }
        
    //Opens and checks given file to make sure it can be read    
    FILE *file = fopen(argv[1], "r");
    if (!file)
    {
        printf("Given file can't be accessed.\n");
        return 1;
    }
    
    int count = 0;
    const int BlockSize = 512;
    FILE *file2 = 0;
    while (1)
    {
        //Making an array that will store all data from the file
        unsigned char buffer[BlockSize];
        
        //Puts the value of a block of 512 bytes into buffer and if there is no data left it breaks
        if (fread(buffer, BlockSize, 1, file) <= 0)
        {
            break;
        }
        
        //Check to see if the data starts with a jpeg file
        if (buffer[0] == 0xff && buffer[1] == 0xd8 && buffer[2] == 0xff && 
            (buffer[3] & 0xf0) == 0xe0)
        {
            //Gets the name to assign to the current new jpeg
            char filename[8];
            sprintf(filename, "%03i.jpg", count);
            
            //If this is not the first time you are making a file close the previous file
            if (file2)
            {
                fclose(file2);
            }
            
            //Opens a new jpeg and writes in all of the information obtained from buffer
            file2 = fopen(filename, "w");
            fwrite(buffer, BlockSize, 1, file2);
            count += 1;
        }
        //Happens if the data doesn't start with a jpeg file
        else
        {
            
            //If you have a jpeg file opened add information from buffer into the current jpeg image
            if (file2)
            {
                fwrite(buffer, BlockSize, 1, file2);
            }
        }
    }
    
    //If you made anoter jpeg close it and close the given file
    if (file2)
    {
        fclose(file2);
    }
    fclose(file);
}


