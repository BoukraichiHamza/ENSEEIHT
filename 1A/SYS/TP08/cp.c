#include <stdio.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>

#define BUFSIZE 5




int main ( int argc, char * argv []) {
      /*Caractères lus*/
      int readc;
      /*Tampon*/
      char tampon [BUFSIZE];
      
    /*Descripteur de fichier*/
    int fd1;
    int fd2;
    
   if (argc != 3) {
      printf( "Erreur Argument \n");
      exit(1);
   }
   
   /*Ouverture du premier fichier en lecture seule*/
  fd1 = open(argv[1],O_RDONLY);
  if (fd1 == -1 ) {
     perror("Erreur ");
     exit(1);
  }
  
  /*Ouverture en écriture du deuxieme fichier en écriture*/
  fd2 = open(argv[2],O_WRONLY | O_CREAT | O_TRUNC, 00600);
  if (fd2 == -1 ) {
     perror("Erreur ");
     exit(1);
  }

  while ((readc = read(fd1,tampon, BUFSIZE)) > 0) {  
  /*Ecriture des données dans le fichier destination*/
  write(fd2,tampon, readc);
}

if (readc == -1) { 
   perror("Erreur ");
   exit(1);
}

/*Fermeture du descripteur de  fichier source*/
if ((close(fd1) != 0)) {
   perror("Erreur fermeture fichier source : ");
}

/*Fermeture du descripteur de fichier destination*/
if ((close(fd2) != 0)) {
   perror("Erreur fermeture fichier déstination : ");
}
return 0;
}
     
  
   
   
