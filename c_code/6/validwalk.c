bool isValidWalk(const char *walk) {
    int x = 0;
    int y = 0;
    int i = 0;
    for(; walk[i] != '\0' && i <= 10; ++i){
      switch (walk[i])
      {
          case 'n': y +=  1; break;
          case 's': y += -1; break;
          case 'w': x += -1; break;
          case 'e': x +=  1; break;
      }
    }
    return i == 10 && x == 0 && y == 0;
}