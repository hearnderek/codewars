#include "5.h"

class DirReduction
{
public:
    static std::vector<std::string> dirReduc(std::vector<std::string> &arr){
        std::vector<std::string> vec;

        size_t len = arr.size();
        if(len < 1)
            return vec;

        vec.push_back(arr[0]);
        size_t ivec = 0;

        for(size_t i = 1; i < len; i++){
            if (ivec == -1 || vec[ivec] == arr[i]){
                goto add;
            }

            char fst, snd;
            if(vec[ivec][0] < arr[i][0]){
                fst = vec[ivec][0]; snd = arr[i][0];
            }
            else {
                fst = arr[i][0]; snd = vec[ivec][0];
            }
            
            // sorted into ENSW
            if((fst == 'E' && snd == 'W') || (fst == 'N' && snd == 'S')){
                vec.pop_back();
                ivec--;
                continue;
            }

add:
            vec.push_back(arr[i]);
            ivec++;
        }
        return vec;
    }
};


std::vector<std::string> dirReduce(std::vector<std::string> &arr){
    return DirReduction::dirReduc(arr);
}
