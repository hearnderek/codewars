#include <iostream>
#include <algorithm>
#include <vector>
#include "6.h"

bool isPrime (int num){

    if(num == 2 || num == 3 || num == 5 || num == 7 || num == 11) {
      return true;
    }
    else if(num < 2 || num % 2 == 0 || num % 3 == 0 || num % 5 == 0 || num % 7 == 0 || num % 11 == 0) {
        return false;
    }

    std::vector<int> primes;
    for(int i = 3; i <= num/i; i+=2) {
        
        bool iIsPrime = ! std::any_of(primes.begin(), primes.end(), [&i](int prime) {
            return i % prime == 0;
        });

        if(iIsPrime) {
            primes.push_back(i);
            if (num % i == 0) {
                return false;
            }
        }
    }
    if( primes.size() == 0){
        primes.push_back(2);
    }
    return true;
}


std::vector<std::string> splitStrings(const std::string &s)
{
    std::vector<std::string> result;
    size_t i = 0;
    auto len = s.length();
    for(; i+1 < s.length(); i+=2){
        result.push_back(s.substr(i, 2));
    }
    if (i < len) {
        result.push_back(s.substr(i, 1) + "_");
    }
    return result;
}

int digital_root(int n)
{
    while (n > 9) {
        int sum = 0;

        while (n > 9) {
            sum += n % 10;
            n /= 10;
        }
        sum += n;

        n = sum;
    }

    return n;
}