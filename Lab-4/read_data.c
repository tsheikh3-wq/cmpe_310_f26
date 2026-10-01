// Objectives for c-file
    // Read data from a text file 
    // Store each line's data in a memory array
    // First line of text file give number of points to be added


#include <stdio.h>
int sum_array(int array[], int count); // sum_array function

int main(int argc, char *argv[]) {  //Reading from command line
FILE *file;
file = fopen(argv[1],"r");  //opening the file in read mode


//Checking if the file didnt open
if (file == NULL){
    printf("Error: File cannot open");
    return 1;
}
//Reading data from the file
int count;

fscanf(file , "%d", &count);  // first line as it has the points

int array[count];
for (int i = 0; i < count; i++) {
    fscanf(file,"%d", &array[i]);  // automatically puts what we read into the array
}

int sum = sum_array(array, count);  // automaticall
// testing to see if the array actual works
//  for(int i = 0; i < count; i++){
//      printf("the array is %d\n", array[i]);
//  }

printf("The sum is %d . \n", sum);
fclose(file);
return 0;
}