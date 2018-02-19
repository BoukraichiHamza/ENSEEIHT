#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int main (int argc, char* argv[]) {
  int fd;
  fd = open(argv[1],O_CREAT | O_TRUNC | O_WRONLY);
  dup2(fd,1);
  close(fd);
  execlp("ls","ls","-t",NULL);
  return 0;
}
