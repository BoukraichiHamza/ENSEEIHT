#include <stdio.h>
#include <stdlib.h>

extern char **environ;

int main () {
   while ( *environ != NULL) {
      printf("%s \n", *environ);
      environ++;
   }
   return 0;
}
