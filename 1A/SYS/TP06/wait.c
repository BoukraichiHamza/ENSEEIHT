#include <stdio.h> 
#include <stdlib.h> 
#include <unistd.h> 
int main(int argc, char *argv[]){ 
  int tp, tf, rf, i; 
  pid_t fw;
  int rw;
  
  tp=120; tf=60;           /*durée du père et du fils par défaut en s*/ 
  if (argc == 3) { 
tp=atoi(argv[1]);    /*1er argument converti en entier pour initialiser la durée du père*/ 
tf=atoi(argv[2]);    /*durée du fils*/ 
  } 
  printf("Temps d’attente du père : %d \nTemps d’attente du fils :%d\n", tp, tf) ; 
  rf=fork();  
  if (rf == -1) { 
     printf("Erreur execution fork\n"); exit(1); 
  } 
  if (rf == 0) {      /* FILS */ 
     printf("processus numéro %d, de père %d\n", (int) getpid(), (int) getppid()); 
     for (i=1 ; i<=10 ; i++) { 
     printf("Fils : tour numéro %d \n",i) ; 
          sleep(tf/10) ;  /* attente pendant tf secondes */ 
     } 
printf("fin du fils\n") ; exit(0) ; 
  }
    else {             /* PERE */ 
     printf("processus numéro %d, de père %d\n", (int) getpid(), (int) getppid()); 
     
      fw = wait(&rw) ;
      /* attente de la fin du fils, et recupération du contexte de terminaison dans la variable rw*/ 
      
      if (WIFEXITED(rw)) printf("fils %d mort par exit %d\n", fw, WEXITSTATUS(rw));
      
      /* Les macros WIFEXITED et WEXITSTATUS interprètent rw et fournissent le résultat indiqué dans leur nom (fin avec exit, valeur du exit) */ 
      
      else printf("fils %d mort par signal %d\n", fw, WTERMSIG(rw)); 
      /* WTERMSIG fournit le numéro du signal ayant tué le fil */  
      
  printf("fin du père\n") ; 
  } 
  return(0); 
} 
