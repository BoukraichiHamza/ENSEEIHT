#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>
#include <sys/mman.h> 
#include <sys/types.h>
#include <sys/wait.h>



int main () {
   
   int i;
   int n;
   char * b;
   
   
   /*Descripteur fichier.*/
   int fd;
   
   /*Récupération de la taille d'une page.*/
   long pagesize = sysconf(_SC_PAGESIZE);
   
   /*Ouverture du fichier.*/
   fd = open("Test2", O_WRONLY | O_CREAT | O_TRUNC,00777);
   if (fd == -1) {
      perror("Open :");
      exit(1);
   }

   /*Ecriture des deux pages de 'a'.*/
   for( i =1; i<= pagesize; i++) {
      if (write(fd,"aaa",3) == -1) {
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
   fd = open("Test2", O_RDWR,00777);
   if (fd == -1) {
      perror("Open :");
      exit(1);
   }
   
   /*Couplage du segment mémoire et du fichier.*/
   b = mmap(0, 3*pagesize, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
   
   /*Création du processus fils.*/
    n = fork();
    
    switch(n) {
       case -1 : perror("fork :");
	         exit(1);
		 
       case 0 : /*Couplage du segment mémoire et du fichier.*/
		  b = mmap(0, 3*pagesize, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
		  
	        /*Récupération et affichage des 10 premiers octets de la premiere page.*/
		printf("10 premiers octets de la 1ere page : \n");	
		for (i=0;i<10;i++) {
		   printf(" Elément %d : %c \n" ,i, b[i]);
		}
		
		sleep(4);
		
		/*Récupération et affichage des 10 premiers octets de la premiere page.*/
		printf("10 premiers octets de la 1ere page : \n");	
		for (i=0;i<10;i++) {
		   printf(" Elément %d : %c \n" ,i, b[i]);
		}
		
		/*Récupération et affichage des 10 premiers octets de la deuxieme page.*/
		printf("10 premiers octets de la 2ieme page : \n");	
		for (i=0;i<10;i++) {
		   printf(" Elément %d : %c \n" ,i, b[pagesize + i]);
		}
		/*Récupération et affichage des 10 premiers octets de la troisieme page.*/
		printf("10 premiers octets de la 3ieme page : \n");
		for (i=0;i<10;i++) {
		   printf(" Elément %d : %c \n" ,i, b[2*pagesize+i]);
		}
		/*Remplissage des 10 premiers caracteres de la page 2 avec 'd'*/
		for (i=0;i<10;i++) {
		   b[pagesize+i] = 'd';
		}
		   
	        sleep(8);
		
		/*Récupération et affichage des 10 premiers octets de la premiere page.*/
		printf("10 premiers octets de la 1ere page : \n");	
		for (i=0;i<10;i++) {
		   printf(" Elément %d : %c \n" ,i, b[i]);
		}
		
		/*Récupération et affichage des 10 premiers octets de la deuxieme page.*/
		printf("10 premiers octets de la 2ieme page : \n");	
		for (i=0;i<10;i++) {
		   printf(" Elément %d : %c \n" ,i, b[pagesize + i]);
		}
		/*Récupération et affichage des 10 premiers octets de la troisieme page.*/
		printf("10 premiers octets de la 3ieme page : \n");
		for (i=0;i<10;i++) {
		   printf(" Elément %d : %c \n" ,i, b[2*pagesize+i]);
		}

		break;
		
       default : sleep(1);
		
	    /*Remplissage des  pages une et deux avec 'b'*/
		for (i=0;i<pagesize;i++) {
		   b[pagesize+i] = 'b';
		   b[i] = 'b';
		}
		
		sleep(6);
		
		 /*Remplissage de la page 3 avec 'c'*/
		for (i=0;i<pagesize;i++) {
		   b[2*pagesize+i] = 'c';
		}

		break;
	     }
   return 0;
}
