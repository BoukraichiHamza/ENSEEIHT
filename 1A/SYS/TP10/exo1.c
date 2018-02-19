#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>
#include <sys/mman.h> 
#include <sys/wait.h>



int main () {
   
   int i;
   int n;
   int status;
   char * b;
   
   
   /*Descripteur fichier.*/
   int fd;
   
   /*Récupération de la taille d'une page.*/
   long pagesize = sysconf(_SC_PAGESIZE);
   
   /*Ouverture du fichier.*/
   fd = open("Test", O_WRONLY | O_CREAT | O_TRUNC,00777);
   if (fd == -1) {
      perror("Open :");
      exit(1);
   }

   /*Ecriture des deux pages de 'a'.*/
   for( i =1; i<= pagesize; i++) {
      if (write(fd,"aa",2) == -1) {
	 perror("Write :");
	 exit(1);
      }
   }
   
   /*Fermeture du fichier.*/
   if (close(fd) == -1) {
      perror("Close :");
      exit(1);
   }
   
   /*Ouverture du fichier en Lecture/Ecriture */
   fd = open("Test1", O_RDWR,00777);
   if (fd == -1) {
      perror("Open :");
      exit(1);
   }
   
   /*Couplage du segment mémoire et du fichier.*/
   b = mmap(0, 2*pagesize, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
   
   /*Création du processus fils.*/
    n = fork();
    
    switch(n) {
       case -1 : perror("fork :");
	         exit(1);
		 
       case 0 : sleep(2);
	        /*Récupération et affichage des 10 premiers octets des deux pages.*/
		printf("10 premiers octets de la 1ere page : \n");	
		for (i=0;i<10;i++) {
		   printf(" Elément %d : %c \n" ,i, b[i]);
		}
		printf("10 premiers octets de la 2ieme page : \n");
		for (i=0;i<10;i++) {
		   printf(" Elément %d : %c \n" ,i, b[pagesize+i]);
		}
		/*Remplissage des 10 premiers caracteres de la page une avec 'c'*/
		for (i=0;i<10;i++) {
		   b[i] = 'c';
		}
		break;
		
       default : /*Remplissage des 10 premiers caracteres de la 
		  page deux avec 'b'*/
		for (i=0;i<10;i++) {
		   b[pagesize+i] = 'b';
		}
		
		/*Attendre la fin du fils.*/
		waitpid(n,&status,WUNTRACED);
		
		/*Affichage des 10 premiers octets de la premiere page.*/
	       printf("10 premiers octets de la 1ere page : \n");
		for (i=0;i<10;i++) {
		   printf(" Elément %d : %c \n" ,i, b[i]);
		}
		break;
	     }
   return 0;
}
