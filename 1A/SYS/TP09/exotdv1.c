#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <errno.h> 
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <signal.h>
#include <ctype.h>



#define BUFFER 5

/*-----------Exercice TD Interactions Processus-----------------------*/

   
int main () {
   int p[2];
   int n ; 
   int desc;
   int cread;
   int creadpere;
   char * commande;
   char * BUF;
   char * BUFPERE;
   fd_set  ldfl;
   
   if ((commande = malloc(sizeof(char))) == NULL) {
      perror("Malloc : ");
   }
   
   commande = "R";
   
   if ((BUF=malloc(BUFFER*sizeof(char))) == NULL) {
      perror("Malloc : ");
      exit(1);
   }
   
   if ((BUFPERE=malloc(200*sizeof(char))) == NULL) {
      perror("Malloc : ");
      exit(1);
   }
   
   if (pipe(p)== - 1) {
      perror("Pipe :");
   }
   
   n = fork();
   
   switch(n) {
      
      case -1 : perror("Fork : ");
	       exit(1);
	       
      case 0 : 
	       if (close(p[0]) == -1) {
		  perror("Close : ");
		  exit(1);
	       }
	       
	       /*Ouverture du fichier de lecture*/
	       if ((desc = open("test.txt", RD_ONLY, 00777)) == -1) {
		  perror("Open : ");
	       }
	       /*Lecture dans le fichier et ecriture dans le pipe.*/
	       while (  (cread = read(desc,BUF,BUFFER)) > 0) {
		  write(p[0],BUF,cread);
	       }
	       
	       /*Fermeture du fichier de lecture.*/
	       if (close(desc) == -1) {
		  perror("Close : ");
		  exit(1);
	       }
	       break;
	       
      default : 
	       if (close(p[1]) == -1) {
		  perror("Close : ");
		  exit(1);
	       }
	            
	       /*Lecture de la commande.*/	       
	       while(1) {
		  printf("Q : Quitter || M : Majuscules || m : minuscules || X : Rien afficher || R : Affichage sans filtres. \n");
		  printf("Veuillez entrer une commande : ");
		  
		  FD_ZERO(&ldfl);
		  FD_SET(p[0],&ldfl);
		  FD_SET(0,&ldfl);
		  select(p[0]+1,&ldfl,NULL,NULL,NULL);		  
		  if (FD_ISSET(p[0],&ldfl)) {
		      while ((creadpere = read(p[0],BUFPERE,BUFFER)) > 0) {
			if(strcmp(commande,"Q")){
			   exit(0);
			} else if (strcmp(commande,"M")) {
			toupper(BUFPERE);
			printf("%s \n",BUFPERE);
		       } else if(strcmp(commande,"m")) {
			   tolower(BUFPERE);
			   printf("%s \n",BUFPERE);
			} else if(strcmp(commande,"X")) {
			} else if(strcmp(commande,"R")) {
			      printf(BUFPERE);
			   } else {
			      printf("Commande inconnue. \n");
			   }
			} 
		     }else if (FD_ISSET(0,&ldfl)) {		     
		     scanf("%s",commande);
		     }
	       }
   }
   return 0;
}
   
   
   
