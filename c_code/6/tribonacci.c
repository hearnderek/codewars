#include <stdlib.h>

long long* tribonacci(const long long signature[3], size_t n) {
    long long a = signature[0];
    long long b = signature[1];
    long long c = signature[2];
    

    if(n <= 0) {
        return NULL;
    }
    long long* seq = calloc(n, sizeof(long long));
    seq[0] = a;
    if(n == 1) {
        return seq;
    }

    seq[1] = b;
    if(n == 2) {
        return seq;
    }

    seq[2] = c;
    
    for(int i = 3; i < n; i++) {
        seq[i] = a + b + c;
        a = b;
        b = c;
        c = seq[i];
    }

    return seq;
}