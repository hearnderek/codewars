#include <stdlib.h>

unsigned long long square_digits (unsigned n)
{
    if(n < 2) {
        return n;
    }
    
    unsigned long long coefficient = 1;
    unsigned long long x = 0;

    while(n > 0) {
        const unsigned digit = n%10;
        unsigned long long squared = (unsigned long long)digit * digit;
        x += coefficient * squared;
        if (squared == 0) {
            coefficient *= 10;
        }
        while(squared > 0) {
            squared /= 10;
            coefficient *= 10;
        }

        n /= 10;
    }

	return x;
}