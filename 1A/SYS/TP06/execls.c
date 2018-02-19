#include <stdio.h> 
#include <stdlib.h> 
#include <unistd.h> 
#include <sys/wait.h>

int main(int argc, char *argv[]){
   
   char * fichier;
   int pid;
   int status;
   int pid_retour;
   
   if (argc != 2) {
      printf("Error. \n");
      printf("man : Commande <Fichier> \n");
   } else {
      
      fichier = argv[1];
      pid = fork();
      
      switch(pid) {
	 
	 case 0 : execlp("ls","ls","-l",fichier,NULL);
		  exit(1);
	 
	 case -1 : printf("Erreur Mémoire \n");
		   exit(2);
	 
	 default : pid_retour=wait(&status);
		  if (WIFSIGNALED(status)){
		     printf("Erreur Execution. \n"); 
		  } else if (WIFEXITED(status)) {
		     printf("Execution réussie. \n");
		    } else {}
	 break;
      }
   }
   return 0;
   }
	 
	 
   
   
