# include<stdio.h>

void mergeSort(int list[], int length);

int main(void)
{
    //making list to be sorted
    int list[] = {4, 12, 3, 19, 21, 7};
    mergeSort(list, 6);
    
    //to check if the code works
    for (int n = 0; n < 6; n++)
    {
        printf("%i\n", list[n]);
    }
}


void mergeSort(int list[], int length)
{
    int len1 = length/2;
    int len2 = length - len1;
    int list1[len1];
    int list2[len2];
    if (length == 1)
    {
        return;
    }
    //copy first half into temperary list 1
    for (int l = 0; l < len1; l++)
    {
        list1[l] = list[l];
    }
    
    //copy 2nd half into temperary list 2
    for (int l = 0; l < len2; l++)
    {
        list2[l] = list[l + len1];
    }
    
    //Sort first half 
    mergeSort(list1, len1);
    
    //sort 2nd half
    mergeSort(list2, len2);
    
    //merge both lists
    for (int i = 0, i1 = 0, i2 = 0; i < length; i++)
    {
        // if first list is exhausted copy from 2nd list
        if (i1 >= len1)
        {
            list[i] = list2[i2];
            i2++;
        }
        
        // if 2nd list is exhausted copy from first list
        else if (i2 >= len2)
        {
            list[1] = list1[i1];
            i1++;
        }
        
        //if both lists still have elemnets copy the smallest
        else if (list1[i1] < list2[i2])
        {
            list[i] = list1[i1];
            i1++;
        }
        else
        {
            list[i] = list2[i2];
            i2++;
        }
    }
    
}