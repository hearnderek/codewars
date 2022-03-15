int positive_sum(const int *values, size_t count)
{
    int sum = 0;
    for(size_t i = 0; i < count; i++)
    {
        const int val = values[i];
        if(val > 0) {
            sum += val;
        }
    }

    return sum;
}