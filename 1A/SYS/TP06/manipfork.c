#include <stdio.h>
#include <unistd.h>

int main(){
  fork(); 
  printf("fork1 : je suis le processus numéro %d; de père %d\n", (int) getpid(), (int) getppid());
  fork(); printf("fork2 : je suis le processus numéro %d; de père %d\n", (int) getpid(), (int) getppid());
  fork(); printf("fork3 : je suis le processus numéro %d; de père %d\n", (int) getpid(), (int) getppid());
  sleep(180);
  return(0);
}
