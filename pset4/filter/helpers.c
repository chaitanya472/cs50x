#include "helpers.h"
#include <math.h>
RGBTRIPLE blurPixel(int i, int j, int height, int width, RGBTRIPLE image[height][width]);

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

// Convert image to sepia
void sepia(int height, int width, RGBTRIPLE image[height][width])
{
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            RGBTRIPLE pixel = image[i][j];
            //Uses the sepia formula to change the color amount for each pixel
            int sepiaBlue = round(.272 * pixel.rgbtRed + .534 * pixel.rgbtGreen + .131 * pixel.rgbtBlue);
            int sepiaRed = round(.393 * pixel.rgbtRed + .769 * pixel.rgbtGreen + .189 * pixel.rgbtBlue);
            int sepiaGreen = round(.349 * pixel.rgbtRed + .686 * pixel.rgbtGreen + .168 * pixel.rgbtBlue);      
        
            //If sepia formula grants a pixel color of over 255 set it to 255
            pixel.rgbtBlue = (sepiaBlue > 255) ? 255 : sepiaBlue;
            pixel.rgbtRed = (sepiaRed > 255) ? 255 : sepiaRed;
            pixel.rgbtGreen = (sepiaGreen > 255) ? 255 : sepiaGreen;
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
    for (int row = (i > 0) ? i - 1 : i; 
         row <= i + 1 && row < height ; row++)
    { 
        for (int col = (j > 0) ? j - 1 : j; 
             col <= j + 1 && col < width; col++)
        {
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