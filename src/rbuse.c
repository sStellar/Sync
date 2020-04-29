#include <stdlib.h>

int main( char *argv[]) {
  system("/bin/bash --login\n");
  system( ("rvm use %s\n", argv[0]) );

  return(0);
}
