#include <iostream>
#include <algorithm>
#include <vector>

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