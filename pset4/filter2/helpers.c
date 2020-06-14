#include "helpers.h"
#include <math.h>
RGBTRIPLE blurPixel(int i, int j, int height, int width, RGBTRIPLE image[height][width]);
RGBTRIPLE sobelOperator(int i, int j, int height, int width, RGBTRIPLE image[height][width]);

// Convert image to grayscale
void grayscale(int height, int width, RGBTRIPLE image[height][width])
{
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            RGBTRIPLE pixel = image[i][j];
            //Takes average of all 3 colors and makes each color equal to the average
            int avg = round((pixel.rgbtBlue + pixel.rgbtGreen + pixel.rgbtRed) / 3.0);
            pixel.rgbtBlue = avg;
            pixel.rgbtRed = avg;
            pixel.rgbtGreen = avg;
            image[i][j] = pixel;
        }
    }
}


// Reflect image horizontally
void reflect(int height, int width, RGBTRIPLE image[height][width])
{
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width / 2; j++)
        {
            int place = width - j - 1;
            RGBTRIPLE tem = image[i][j];
            image[i][j] = image[i][place];
            image[i][place] = tem;
        }
    }
}

//Using the box blur method 1 pixel at a time
void blur(int height, int width, RGBTRIPLE image[height][width])
{
    RGBTRIPLE changedImage[height][width];
    
    // Makes a replicate image that is blured 
    //So that the blured pixels can be stored without affecting the rest of the pixels
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            changedImage[i][j] = blurPixel(i, j, height, width, image);
        }
    }
    
    //Puts blured pixels into main image 
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            image[i][j] = changedImage[i][j];
        }
    }
}

//Blurs image using box blur method
RGBTRIPLE blurPixel(int i, int j, int height, int width, RGBTRIPLE image[height][width])
{
    int red = 0, blue = 0, green = 0;
    int count = 0;
    
    //Gets the 3 by 3 grid of pixels aroud the main pixel taking care of border cases
    for (int row = i - 1; row <= i + 1; row++)
    { 
        if (row < 0 || row >= height)
        {
            continue;
        }
        for (int col = j - 1; col <= j + 1; col++)
        {
            if (col < 0 || col >= width)
            {
                continue;
            }
            //Adds the color fro each pixel into the varaibles
            red += image[row][col].rgbtRed;
            blue += image[row][col].rgbtBlue;
            green += image[row][col].rgbtGreen;
            count += 1;
        }
    }
    //Averages out each color amount
    RGBTRIPLE pixel;
    pixel.rgbtRed = round(red / (float)count);
    pixel.rgbtBlue = round(blue / (float)count);
    pixel.rgbtGreen = round(green / (float)count);
    return pixel;
}


// Uses the sobel operator to filter the image
void edges(int height, int width, RGBTRIPLE image[height][width])
{
    RGBTRIPLE changedImage[height][width];
    
    //Make a replicate image that is filtered
    //So that the filtered pixels don't interupt with the other pixels
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            changedImage[i][j] = sobelOperator(i, j, height, width, image);
        }
    }
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            image[i][j] = changedImage[i][j];
        }
    }
}

//Makes a grid for each kernel used in the sobel operater
int gridx[3][3] = { {-1, 0, 1}, {-2, 0, 2 }, {-1, 0, 1} };
int gridy[3][3] = { {-1, -2, -1}, {0, 0, 0}, {1, 2, 1} };


RGBTRIPLE sobelOperator(int i, int j, int height, int width, RGBTRIPLE image[height][width])
{
    int Gx_Red = 0, Gx_Blue = 0, Gx_Green = 0, Gy_Red = 0, Gy_Blue = 0, Gy_Green = 0;
    
    //Gets vertical and horizontal edges around the pixel
    for (int row =  i - 1; row <= i + 1; row ++)
    {
        
        //Continues code if there is a point to the left
        if (row < 0 || row >= height)
        {
            continue;
        }
        for (int col = j - 1; col <= j + 1; col++)
        {
            
            //Continues code if there is a point underneath 
            if (col < 0 || col >= width) 
            {
                continue;
            }
            
            int valuex = gridx[row - (i - 1)][col - (j -  1)];
            int valuey = gridy[row - (i - 1)][col - (j - 1)];
            
            //Adds all values at the given point multiplied by the coresponding value in their kernel
            Gx_Red += image[row][col].rgbtRed * valuex;
            Gx_Blue += image[row][col].rgbtBlue * valuex;
            Gx_Green += image[row][col].rgbtGreen * valuex;
            Gy_Green += image[row][col].rgbtGreen * valuey;
            Gy_Blue += image[row][col].rgbtBlue * valuey;
            Gy_Red += image[row][col].rgbtRed * valuey;
        }
    }
    //Geting a final value to return
    RGBTRIPLE pixel; 
    Gx_Red = round(sqrt(Gx_Red * Gx_Red + Gy_Red * Gy_Red));
    Gx_Blue = round(sqrt(Gx_Blue * Gx_Blue + Gy_Blue * Gy_Blue));
    Gx_Green = round(sqrt(Gx_Green * Gx_Green + Gy_Green * Gy_Green));
    
    pixel.rgbtRed = (Gx_Red < 255) ? Gx_Red : 255;
    pixel.rgbtBlue = (Gx_Blue < 255) ? Gx_Blue : 255;
    pixel.rgbtGreen = (Gx_Green < 255) ? Gx_Green : 255;
    return pixel;
}
