#include <stdio.h>
#include "processus.h"

/* fonctions de modification de l'état d'un processus
 * (pour tester l'itérateur appliquer_partout_fe) */

Etat suspend(Etat e) {
  return SUSPENDU;
}

Etat bascule(Etat e){
  if(e == SUSPENDU){
    return ACTIF;
  } else {
    return SUSPENDU;
  }
}
 /*Fonctions pour gérer code*/
 
 void code_ins ( int n ) {
	 if ( n == -1) {
		 printf("Erreur : mémoire non suffisante \n");
	 } else {
		 printf("Insertion réussie \n");
	 }
 }
 
void code_appartient( int n) {
	if (n == 0) {
		printf( " Le processus n'appartient pas à la liste \n");
	} else {
		printf(" Le processus appartient à la liste \n");
	}
}

void code_modif ( int n) {
	switch (n) {
		case -1 : printf("Liste Vide \n");
				  break;
		case  0 : printf("Modification échouée \n"); 
				  break;
		case  1 : printf("Modification réussie \n");
		          break;
		default : break;
	}
}

void code_supp ( int n) {
  switch (n) {
    case -2 : printf("Élément non trouvé \n");
	      break;
    case -1 : printf("Liste Vide \n");
	      break;
    case 0  : printf("Suppression réussie \n");
	      break;
    default : break;
  }
}

    
int main() {

  /* pour tester la valeur de retour de certaines fonctions */
  int code;

 /* Variable de test*/
 List_proc listetest;
 
 
 /*Initialisation de la liste de processus*/
 
 printf("**********************************************************\n");
 printf("Initialisation de la liste de processus \n");
 listetest = nouvelle_liste();
 printf("Affichage de la liste \n");
 afficher(listetest);
 printf("**********************************************************\n");
 
 /*Test de Inserer en tête*/
 
 printf("**********************************************************\n");
 printf("Test de insérer en tête \n");
 printf("\t ************* \n");
 printf("Insertion du processus actif 1015 \n");
 code = inserer_en_tete(1015, ACTIF,&listetest);
 code_ins(code);
 printf("Affichage de la liste \n"); 
 afficher(listetest);
 printf("\t ************* \n");
 printf("Insertion du processus suspendu 2018 \n");
 code = inserer_en_tete(2018, SUSPENDU,&listetest);
 code_ins(code);
 printf("Affichage de la liste \n"); 
 afficher(listetest);
 printf("\t ************* \n");
 printf("Insertion du processus actif 1024 \n");
 code = inserer_en_tete(1024, ACTIF,&listetest);
 code_ins(code);
 printf("Affichage de la liste \n"); 
 afficher(listetest);
 printf("**********************************************************\n");
 
 /*Test de appartient*/
 printf("**********************************************************\n");
 printf("Test de appartient\n");
 printf("\t ************* \n");
 printf("Test d'appartenant du processus 1024 \n");
 code = appartient(listetest, 1024);
 code_appartient(code);
 printf("\t ************* \n");
 printf("Test d'appartenant du processus 1025 \n");
 code = appartient(listetest, 1025);
 code_appartient(code);
 printf("\t ************* \n");
 printf("Test d'appartenant du processus 1015 \n");
 code = appartient(listetest, 1015);
 code_appartient(code);
  printf("**********************************************************\n");
 /*Test de appliquer partout fe*/
 
 printf("**********************************************************\n");
 printf("Test de appliquer partout fe \n");
 printf("\t ************* \n");
 printf("Basculement de tous les états \n");
 appliquer_partout_fe(listetest, bascule);
 printf("Affichage de la liste \n");
 afficher(listetest);
 printf("\t ************* \n");
 printf("Suspension de tous les processus \n");
 appliquer_partout_fe(listetest, suspend);
 printf("Affichage de la liste \n");
 afficher(listetest);
 printf("\t ************* \n");
 printf("Activation de tous les processus \n");
 appliquer_partout_fe(listetest, bascule);
 printf("Affichage de la liste \n");
 afficher(listetest);
 printf("**********************************************************\n");
  
 /*Test de modif_etat*/
 printf("**********************************************************\n");
 printf("Test de modif_etat\n");
 printf("\t ************* \n");
 printf("Modification de l'état de 1015 en suspendu \n");
 code = modif_etat(listetest,1015,SUSPENDU);
 code_modif(code);
 printf("Affichage de la liste \n");
 afficher(listetest);
 printf("\t ************* \n");
 printf("Modification de l'état de 1017 en suspendu \n");
 code = modif_etat(listetest,1017,SUSPENDU);
 code_modif(code);
 printf("Affichage de la liste \n");
 afficher(listetest);
 printf("\t ************* \n");
 printf("Modification de l'état de 1015 en actif \n");
 code = modif_etat(listetest,1015,ACTIF);
 code_modif(code);
 printf("Affichage de la liste \n");
 afficher(listetest);
 printf("**********************************************************\n"); 
 
  /*Test de Inserer fin*/
 
 printf("**********************************************************\n");
 printf("Test de insérer fin \n");
 printf("\t ************* \n");
 printf("Insertion du processus actif 2045 \n");
 code = inserer_fin(2045, ACTIF,&listetest);
 code_ins(code);
 printf("Affichage de la liste \n"); 
 afficher(listetest);
 printf("\t ************* \n");
 printf("Insertion du processus suspendu 3028 \n");
 code = inserer_fin(3028, SUSPENDU,&listetest);
 code_ins(code);
 printf("Affichage de la liste \n"); 
 afficher(listetest);
 printf("\t ************* \n");
 printf("Insertion du processus actif 10454 \n");
 code = inserer_fin(10454, ACTIF,&listetest);
 code_ins(code);
 printf("Affichage de la liste \n"); 
 afficher(listetest);
 printf("**********************************************************\n");  
 
 
/*Test de supprimer*/
 printf("**********************************************************\n");
 printf("Test de supprimer \n");
 printf("\t ************* \n");
 printf("Suppression du processus 1024 \n");
 code = supprimer(1024,&listetest);
 code_supp(code);
 printf("Affichage de la liste \n"); 
 afficher(listetest);
 printf("\t ************* \n");
 printf("suppression du processus 3028 \n");
 code = supprimer(3028,&listetest);
 code_supp(code);
 printf("Affichage de la liste \n"); 
 afficher(listetest);
 printf("\t ************* \n");
 printf("suppression du processus 10454 \n");
 code = supprimer(10454,&listetest);
 code_supp(code);
 printf("Affichage de la liste \n"); 
 afficher(listetest);
 printf("**********************************************************\n");

/*Test de Vider*/
printf("**********************************************************\n");
printf("Test de vider \n");
printf("Vider la liste de test \n");
vider(&listetest);
printf("Affichage de la liste \n");
afficher(listetest);
printf("**********************************************************\n");

  return 0;
}
