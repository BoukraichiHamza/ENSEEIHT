#include <stdio.h>
#include <signal.h>
#define intervalle 5
#define duree 60

int compteur;


void traitantglobal ( int sig) {
   printf("Signal %d reçu \n",sig);
}

void traitant_alarme( int sig) {
   compteur--;
   printf("Toujours actif \n");
   alarm(5);
}
int main () {
   int i;
   for (i=1; i<=NSIG; i++) {
      signal(i,traitantglobal);
   }
   signal(SIGALRM,traitant_alarme);
   compteur=12;
   alarm(5);
   while(1){
	 if (compteur == 0){
	    exit(1);
	 }
      }
      return(0);
}
