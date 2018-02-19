#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define DIM 100

/* Prototype des sous-programmes */

/* fonction imax : 
   renvoie l'indice de la valeur maximum d'un tableau d'entiers
   paramètres : 
     v : le tableau (D)
     n : le nombre d'élément du tableau (D)
   retour :
     l'indice de la valeur maximum
   pré : le tableau n'est pas vide (n>0)
   post : quelquesoit i dans {0..n-1}, v(imax(v,n)) >= v(i)
  -------------------------------------------------- */

/*fonction search_val :
  retourne l'indice de la première occurence d'une valeur
  -1 si elle existe pas
 * paramètres :
     v : le tableau (D)
     x : valeur à rechercher (D)
     n : le nombre d'élément du tableau (D)
 * retour : l'indice de la première occcurence de la valeur
 * Préconditions : le tableau n'est pas vide (n>0)
 * Postconditions : /
 -------------------------------------------------- */

/*fonction occuk :
  retourne l'indice de la k ieme occurence d'une valeur
  -1 si elle existe pas
 * paramètres :
     v : le tableau (D)
     x : valeur à rechercher (D)
     n : le nombre d'élément du tableau (D)
    k : le nombre d'occurence souhaité (D)
 * retour : l'indice de la kieme occcurence de la valeur
 * Préconditions : le tableau n'est pas vide (n>0)
 * Postconditions : /
 -------------------------------------------------- */

/*
 * Fonction quicksort :
 * trie le tableau en ordre croissant
 * Paramètres : v : le tableau (D)
 * 		n : nombre d'éléments du tableau
 *retour : le tableau trié
 *Préconditions : le tableau n'est pas vide (n>0)
 *Postconditions : le tableau est trié
 ------------------------------------------------ */





int imax(int v[], int n);
int search_val ( int v[], int x, int n);
int occuk (int v[], int x, int n, int k);
void quicksort ( int v[], int n);

/*                                                                */
/* programme qui affiche le maximum d'un tableau                  */
/*                                                                */
int main(){

  /* tableau */
  int t[DIM];
  /* nombre d'éléments réels du tableau */
  int n = 20;
  /* indice de boucle */
  int i;
  /*Indice du maximum*/
  int imaximum;
  /*Indices de recherche de valeur*/
  int k1;
  int k2;

  /* initialisation du générateur de nombre aléatoire 
   * en fonction de la date courante */
  srand(time(NULL));
  /* initialisation du tableau avec des nombres de 0 à 9 */
  for(i = 0; i < n; i++){
    t[i] = rand()%10;
    printf("t[%d] = %d\n", i, t[i]);
  }

  /*utilisation de la fonction imax */
  imaximum = imax(t,n);

  /*Affichage du maximum*/
  printf("Le maximum du tableau est : %d \n",t[imaximum]);

  /*Test de search_val*/
  k1=search_val(t,5,n);
  k2=search_val(t,8,n);


  /*Affichage de l'indice*/
  printf("L'indice de la première occurence de 5 est : %d \n",k1);
  printf("L'indice de la première occurence de 8 est : %d \n",k2);

  
  /*Test de occuk*/
  k1=occuk(t,7,n,2);
  k2=occuk(t,9,n,3);

  
  /*Affichage de l'indice*/
   printf("L'indice de la deuxième occurence de 7 est : %d \n",k1);
   printf("L'indice de la troisième occurence de 9 est : %d \n",k2);

   /*Test de quicksort*/
   quicksort(t,n);

   /*Affichage du tableau trié*/
   for (i=0; i < n; i++) {
     printf(" t[%d] = %d\n",i,t[i]);
   }


  return 0;
}

/* la fonction imax */
  int imax (int v[], int n) {
  
    int i; /*Indice de parcours du tableau*/
    int imaximum; /*indice du maximum du tableau*/
  
    /*Initialisation*/
    imaximum = 0;

    /*Recherche du Maximum du tableau*/
    for (i=1;i<n;i++) {
      if (v[i]>v[imaximum]) {
        imaximum = i;
      }
    }
    return imaximum;
  }
  /*La fonction search_val */

  int search_val ( int v[],int x, int n) {
    int i; /*Indice de parcours du tableau*/

    /*Initialisation*/
    i=0;
    
    /*Recherche de la valeur*/

    while (i<n && v[i] != x) {
      i++;
    }
    if (i>=n) {
      i=-1;
    }
    return i;
  }

  /*La fonction de occuk */

  int occuk ( int v[], int x, int n, int k) {
    int i; /*indice de parcours du tableau*/
    int compteur; /*Compteur des occurrences actuelles*/

    /*Initialisation*/
    i=0;
    compteur=0;

    /*Recherche de la kieme occurence*/
    while ((i<n) && (compteur != k) ) {
      if (v[i]==x) {
	compteur++;
      }
      i++;
    }
   
    if (i>=n) {
      if (compteur ==k) {
	i--;
      } else {
	i=-1;
      }
    }
    return i;
}

 /*La fonction quicksort*/

 void quicksort ( int v[], int n) {

   /*Déclarations*/

   /*Indice de parcours de tableaux*/
   int i;

   /*Valeur du pivot*/
   int p;
   
   /*Tableau des éléments plus petits que le pivot*/
   int ppetit [DIM];
   int np; /*Nombre d'éléments du tableau*/
   
   /*Tableau des éléments plus grands que le pivot*/
   int pgrand [DIM];
   int ng; /*Nombre d'éléments du tableau*/

   /*Initialisations*/

   p=v[0];
   np=0;
   ng=0;

   /*Cas terminal*/
   if (n==0) {
     return;
   }

   /*Remplissage des 2 tableaux*/

      /*Pivot avec les plus grand*/

   for (i=1;i<n;i++) {
     if (v[i]<p) {
       ppetit[np]=v[i];
       np++;
     } else {
       pgrand [ng] = v[i];
       ng++;
     }
   }

   /*Tri des 2 tableaux*/
   quicksort(ppetit,np);
   quicksort(pgrand,ng);

   /*Modification du tableau*/

   /*Remplissage des éléments plus petits*/
   for (i=0;i<np;i++) {
     v[i]=ppetit[i];
   }
   
   /*Ajout du pivot*/
   v[np]=p;

   for (i=0;i<ng;i++) {
     v[np+i+1]=pgrand[i];
   }
 }


   

 

