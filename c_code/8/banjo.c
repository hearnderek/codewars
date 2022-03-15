#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* are_you_playing_banjo(const char* name) {
  const size_t len = strlen(name);
  char* buffer;
  
  if(name[0] == 'R' || name[0] == 'r') {
    const size_t ssize = sizeof(char) * (13 + len);
    buffer = (char*)malloc(ssize);
    snprintf(buffer, ssize, "%s plays banjo", name);
  }
  else {
    const size_t ssize = sizeof(char) * (21 + len);
    buffer = (char*)malloc(ssize);
    snprintf(buffer, ssize, "%s does not play banjo", name);
  }
  
  return buffer;
}


/*
things to look into:
- asprintf
- calloc
  - const size_t chars = (13 + len);
  - buffer = calloc(chars, sizeof(char));
- the (char*) cast is not needed in C, but it is in c++
*/