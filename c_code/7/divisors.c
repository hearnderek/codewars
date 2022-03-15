int divisors(int n) {
    if(n == 1){
        return 1;
    }

    int num_divs = 2;


    for(int i = 2; i < n; ++i) {
        if(n % i == 0) {
            num_divs += 1;
        }
    }

    return num_divs;

}