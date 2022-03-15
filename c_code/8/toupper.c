#include <string.h>


char* makeUpperCase (char* string){
    size_t len = strlen(string);
    
    const char dif = 'A' - 'a';
    for(size_t i = 0; i < len; ++i){
        const char c = string[i];
        if (c >= 'a' && c <= 'z') {
            string[i] = c + dif;
        }
    }
  
    return string;
}