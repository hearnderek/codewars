// Simple hello world program


#include <iostream>
#include "8.h"
#include "6.h"

int main()
{
    int sum = summation(10);
    std::cout << "Sum of 1 to 10 is: " << sum << std::endl;
    if (sum != 55) {
        std::cout << "FAIL: " << sum << " is != to 55" << std::endl;
    }

    std::string slicedstr = sliceString("Hello World!");
    std::cout << "Slice of 'Hello World!' is: " << slicedstr << std::endl;

    double bmi_result;
    bmi(86.7, 1.7, bmi_result);
    std::string myBmi = bmi(86.7, 1.7);
    std::cout << "BMI of 86.7 and 1.7 is: " << myBmi << " " << bmi_result << std::endl;
    
    std::string fakeBinResult = fakeBin("45385593107843568");
    std::cout << "Fake binary of '45385593107843568' is: " << fakeBinResult << std::endl;
    
    std::cout << "Century of year 2000 is: " << centuryFromYear(2000) << std::endl;
    std::cout << "Century of year 1 is: " << centuryFromYear(1) << std::endl;
    
    std::string reverseStringResult = reverseString("Hello World!");
    std::cout << "Reverse of 'Hello World!' is: " << reverseStringResult << std::endl;


    std::cout << std::endl;

    std::cout << std::endl;
    std::cout << "Entering Level 6" << std::endl;

    // for(int i= 0; i < 1000; i++){
    //     isPrime(196785);
    // }
    std::cout << "isPrimeResult of 1629636223: " << isPrime(1629636223) << std::endl;


    std::cout << "split strings: abcde" << std::endl;
    std::vector<std::string> splitStringsResult = splitStrings("abcde");
    for(int i = 0; i < splitStringsResult.size(); i++){
        std::cout << splitStringsResult[i] << " ";
    }

    std::cout << "split strings: LovesPizza" << std::endl;
    splitStringsResult = splitStrings("LovesPizza");
    for(int i = 0; i < splitStringsResult.size(); i++){
        std::cout << splitStringsResult[i] << " ";
    }

    return 0;
}