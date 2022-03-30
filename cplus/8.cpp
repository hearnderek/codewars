#include <string>
#include "6.h"

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


std::string sliceString(std::string str){
  return str.substr(1, str.length()-2);
}

void bmi(double w, double h, double& result) {
  result = w / (h * h);
}
std::string bmi(double w, double h) {
  double bmi = w / (h*h);
  if (bmi >= 30.0001) {
    return "Obese";
  }
  else if (bmi > 25) {
    return "Overweight";
  }
  else if (bmi > 18.5) {
    return "Normal";
  }
  else {
    return "Underweight";
  }
}

std::string fakeBin(std::string str) {
  for (int i = 0; i < str.length(); i++) {
    switch (str[i])
    {
    case '1': case '2': case '3': case '4':
      str[i] = '0';
      break;
    case '5': case '6': case '7': case '8': case '9':
      str[i] = '1';
      break;
    }
  }
  return str;
}

int centuryFromYear(int year){
  return (year - 1) / 100 + 1;
}

std::string reverseString (std::string str){
  for (int i = 0; i < str.length()/2; i++)
  {
    char temp = str[i];
    str[i] = str[str.length()-1-i];
    str[str.length()-1-i] = temp;
  }

  return str;
}

int basicOp(char op, int val1, int val2) {
  switch (op)
  {
  case '+': return val1 + val2;
  case '-': return val1 - val2;
  case '*': return val1 * val2;
  case '/': return val1 / val2;
  default: return -1;
  }
}