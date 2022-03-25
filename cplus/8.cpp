/**
 * Write a program that finds the summation of every number from 1 to num. 
 * The number will always be a positive integer greater than 0.
 */
int summation(int num){
    int sum = 0;
    for(int i = 1; i <= num; i++) {
        sum += i;   
    }
    return sum;
}