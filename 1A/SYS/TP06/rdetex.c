#include <stdio.h> 
#include <stdlib.h> 
#include <unistd.h> 
#include <sys/wait.h>
#define SIZE = 32

int main(int argc, char *argv[]){
   
   char buf[32]; /*Tableau de caractère pour récupérer la commande entrée au clavier */
   int pid; /*Pid du processus*/
   int status; /*Status du processus*/
   int pid_retour;
   
   /*Boucle infinie*/
   do {
      /*Lecture de la commande*/
      printf("Entrez une commande : ");
      scanf("%s",buf);
      
      /*Execution de la commande*/
      
      pid = fork();
      switch(pid) {
	 case 0  :execlp(buf,buf,NULL);
		  exit(1);
		  
	 case -1 :printf("Erreur Mémoire \n");
		  exit(2);
		  
	 default : pid_retour=wait(&status);
		  if (WIFSIGNALED(status)){
		     printf("Erreur Execution. \n"); 
		  } else if (WIFEXITED(status)) {
		     if (WEXITSTATUS(status) != 0) {
			printf("Commande incorrecte \n");
			}else{
			   printf("Execution réussie \n");
			}
			}else{}
		  break;
      }
   } while(1);
}
