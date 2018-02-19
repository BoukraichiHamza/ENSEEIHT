#include <stdio.h> 
#include <stdlib.h> 
#include <unistd.h> 

int vglob = 0;
int main(int argc, char *argv[]){ 
  int tp, tf, rf, i; 
  int vloc;
  tp=120; tf=60;           /*durée du père et du fils par défaut en s*/ 
  if (argc == 3) { 
tp=atoi(argv[1]);    /*1er argument converti en entier pour initialiser la durée du père*/ 
tf=atoi(argv[2]);    /*durée du fils*/ 
  } 
  printf("Temps d’attente du père : %d \nTemps d’attente du fils :%d\n", tp, tf) ; 
  vloc =0;
  rf=fork();  
  if (rf == -1) { 
     printf("Erreur execution fork\n"); exit(1); 
  } 
  if (rf == 0) {      /* FILS */ 
     printf("processus numéro %d, de père %d\n", (int) getpid(), (int) getppid()); 
     vglob = vglob + 100;
     vloc = vloc + 100;
     printf("vglob = %d - vloc = %d \n",vglob,vloc);
     for (i=1 ; i<=10 ; i++) { 
     printf("Fils : tour numéro %d \n",i) ; 
          sleep(tf/10) ;  /* attente pendant tf secondes */ 
     } 
printf("fin du fils\n") ; exit(0) ; 
  }
    else {             /* PERE */ 
     printf("processus numéro %d, de père %d\n", (int) getpid(), (int) getppid());
     sleep(tp) ;
     vglob = vglob + 10;
     vloc  = vloc + 10;
     printf("vglob = %d - vloc = %d \n",vglob,vloc); 
     printf("fin du père\n") ; 
  } 
  return(0); 
} 
