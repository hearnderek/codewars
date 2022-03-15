void count_positives_sum_negatives(int *values, size_t count, int *positivesCount, int *negativesSum) 
{
  for(size_t i = 0; i < count; ++i){
    const int val = values[i];
    if(val == 0) {  
    }
    else if(val > 0) {
      *positivesCount += 1;
    } else {
      *negativesSum += val;
    }
  }
}  