#include <stdio.h>
/*************************************************************************/

/* Puissance(i/r) : calcul de nieme puissance de x
 * Paramètres : x : double (*D*) : le nombre dont la puissance est calculée
		n : entier (*D*) : l'esxposant
 * Resultat retourné : x
 * Préconditions : n>=0
 * Postconditions : aucune */

/*************************************************************************/

/*Version Itérative*/
double puissancei ( double x, int n) {
  int exposant; /*Exposant actuel*/
  double puiss; /*Resultat retourné*/

  /*Initialisations*/
  puiss=1;

  /*Calcul de la puissance*/
  for (exposant =1; exposant <= n;exposant++) {
    puiss=puiss*x;
  }

  return puiss;
}

/*************************************************************************/

/*Version récursive*/
double puissancer (double x, int n) {
  double puiss; /*Resultat retourné*/
  if (n==0) {
    puiss=1;
  }
  else {
    puiss=puissancer(x,n-1)*x;
  }
  return puiss;
}

/*************************************************************************/

/*Test des fonctions*/
int main () {

  /*Exposant*/
  int n;

  /*Nombre dont la puissance est calculé*/
  double x;

  /*Resultat = x^n*/
  double puissn;

  /************************************************/

  /*Test Version itérative 1*/
  printf("Test Version itérative 1\n");

  /*Lecture du nombre et de l'exposant*/

  /*Lecture du nombre*/
  printf("Entrez un nombre : ");
  scanf("%lf",&x);
  
  /*Lecture de l'exposant*/
  do {
    printf("Entrez l'exposant : ");
    scanf("%d",&n);
  } while (n<0);

  /*Calcul de la puissance*/
  puissn = puissancei(x,n);

  /*Affichage du resultat*/
  printf("%f à la puissance %d = %f \n ",x,n,puissn);

  /************************************************/

  /*Test Version itérative 2*/
  printf("Test Version itérative 2\n");

  /*Lecture du nombre et de l'exposant*/

  /*Lecture du nombre*/
  printf("Entrez un nombre : ");
  scanf("%lf",&x);
  
  /*Lecture de l'exposant*/
  do {
    printf("Entrez l'exposant : ");
    scanf("%d",&n);
  } while (n<0);

  /*Calcul de la puissance*/
  puissn = puissancei(x,n);

  /*Affichage du resultat*/
  printf("%f à la puissance %d = %f \n ",x,n,puissn);

  /************************************************/

  /*Test Version récursive 1*/
  printf("Test Version récursive 1\n");

  /*Lecture du nombre et de l'exposant*/

  /*Lecture du nombre*/
  printf("Entrez un nombre : ");
  scanf("%lf",&x);
  
  /*Lecture de l'exposant*/
  do {
    printf("Entrez l'exposant : ");
    scanf("%d",&n);
  } while (n<0);

  /*Calcul de la puissance*/
  puissn = puissancer(x,n);

  /*Affichage du resultat*/
  printf("%f à la puissance %d = %f \n ",x,n,puissn);

  /************************************************/

  /*Test Version récursive 2*/
  printf("Test Version récursive 2\n");

  /*Lecture du nombre et de l'exposant*/

  /*Lecture du nombre*/
  printf("Entrez un nombre : ");
  scanf("%lf",&x);
  
  /*Lecture de l'exposant*/
  do {
    printf("Entrez l'exposant : ");
    scanf("%d",&n);
  } while (n<0);

  /*Calcul de la puissance*/
  puissn = puissancer(x,n);

  /*Affichage du resultat*/
  printf("%f à la puissance %d = %f \n ",x,n,puissn);

  /************************************************/

  return 0;
}

/*************************************************************************/





