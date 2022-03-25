// Simple hello world program


#include <iostream>
#include "8.h"

extern int summation(int num);

int main()
{
    int sum = summation(10);
    std::cout << "Sum of 1 to 10 is: " << sum << std::endl;
    if (sum != 55) {
        std::cout << "FAIL: " << sum << " is != to 55" << std::endl;
    }

    std::cout << "Hello, World!" << std::endl;
    return 0;
}