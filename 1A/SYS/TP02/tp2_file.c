#include <stdio.h>
#define DIM 5

/*Declarations de types*/

/*Etat de la file*/
enum etatfile {VIDE, PLEINE, AUTRE};

/*Type file*/
typedef struct file {
	
	/*Tableau d'éléments*/
	int corps[DIM];
	
	/*Indice de la tête*/
	int t;
	
	/*Indice de queue*/
	int q;
	
	/*Nombre d'éléments de la file*/
	int nbr_el;
	
	/*Etat de la file*/
	enum etatfile etat;
} File;


/*LES EN-TÊTES DES SOUS-PROGRAMMES*/

/**********************************************************************/
/*Fonction construire
*Construit une nouvelle file
*Parametres : aucun
*Retour : une file vide
*Préconditions : aucune
*Postconditions : aucune

***********************************************************************/

File construire ();

/*Fonction defiler
*Defile un élément
*Parametres : file : la file a defiler
*Retour : la file dont l'élément a été défilé
* 0 en cas de succés, -1 sinon
*Préconditions : file initialisée
*Postconditions : aucune

***********************************************************************/

int defiler ( File *f);

/*Fonction enfiler
*Enfile un élément
*Parametres : file : la file à enfiler
*Retour : la file enfilé avec l'élément à la queue
* 0 en cas de succès, -1 sinon
*Préconditions : file initialisée
*Postconditions : l'élément est enfilé en queue de file

***********************************************************************/

int enfiler (File *f);

/*Fonction get_head
*Fonction qui retourne la valeur à la tête de la file
*Parametres : file : la file à consulter
* 		x : l'élément à la tête
*Retour : 0 en cas de réussite -1 sinon
*Préconditions : file initialisée
*Postconditions : /

***********************************************************************/

int get_head (File f, int* x);

/*Fonction test_etat
*Fonction qui test l'état de la file
*Paramètres : file : dont l'état sera testé
		x : pointeur sur l'élément à la tête
*Retour : l'état de la file
*Préconditions : file initialisée
*Postconditions : aucune

***********************************************************************/

enum etatfile get_etat (File f);

/*Fonction affiche
 * Affiche la file
 * Parametres : file à afficher
 * Préconditions : file initialisée
 * Postconditions : aucune
 
***********************************************************************/
void afficher (File f);

/**********************************************************************/

int main() {

  int op = 0;
  int nb_item;
  File f; /*La file de test*/
  int tete; /*Pointeur sur l'élément à la tete*/

  /* À COMPLÉTER PAR LA DÉCLARATIONS DE NOUVELLES VARIABLES */
  /* POUR REPRÉSENTER LA FIFO */

  /* boucle du menu */
  do {
    printf("terminer    (0) \n");
    printf("initialiser (1) \n");
    printf("enfiler     (2) \n");
    printf("défiler     (3) \n");
    printf("afficher    (4) \n");
    printf("tête        (5) \n");
    printf("état        (6) \n");


    /* boucle de saisie de l'opération à effectuer */
    do {
      printf("\nopération ? \n");
      nb_item = scanf("%d", &op);
      while( getchar() != '\n' ){
        /* empty */;
      }
    } while ( nb_item != 1 );
   
    printf("opération choisie : %d\n",op);

    /* traitement de l'opération choisie */
    switch (op) { 
      case 0 :   printf("Au revoir \n\n");
                 break;
      case 1 :   printf("initialiser \n\n");
                 f = construire();
                 break;
      case 2 :   printf("enfiler \n\n");
                 if (enfiler(&f)!=0) {
		   printf("Pile Pleine \n");
		 }
                 break;
      case 3 :   printf("défiler \n\n");
                switch (defiler(&f)) {
		  case -1 : printf("Pile Vide \n");
			    break;
		  case -2 : printf("Il faut d'abord initialiser \n");
			    break;
		  default : break;
		}
                 break;
      case 4 :   printf("afficher \n\n");
                 afficher(f);
                 break;

      case 5 :  printf("tête \n\n");
		if (get_head(f,&tete) != 0) {
		  printf("Pile Vide \n");
		}else{
		  printf("La tête est : %d \n",tete);
		}
		  break;

      case 6 :  printf(" état \n\n");
		switch (get_etat(f)) {
		  case VIDE : printf("VIDE \n");
			      break;
		  case PLEINE : printf("PLEINE \n");
			        break;
		  case AUTRE : printf("AUTRE \n");
			       break;	
		  default : break;
		}
		 break;

      default  : printf(" \n\n\007opération non conforme\n\n");
                 break; 
    }
  } while (op != 0);

  return 0;
}

/*IMPLANTATION DES SOUS-PROGRAMMES*/

/*Fonction construire*/

File construire () {
	File f;
	f.t =0;
	f.q =0;
	f.etat = VIDE;
	f.nbr_el =0;
	return f;
}

/*Fonction defiler*/

int defiler (File *f) {
  	if (f==NULL) {
	  return -2;
	}else if (f->nbr_el == 0) { 
	  return -1;
	}
	  f->t = (f->t+1)%DIM;
	  f->nbr_el--; 
	  f->etat = (f->nbr_el == 0) ? VIDE : AUTRE; 
	  return 0;
}

/*Fonction enfiler*/

int enfiler (File * f) {
	int x;
	if (f->nbr_el == DIM) {
		return -1;
	}
	printf("Entrez l'élément à enfiler \n");
	scanf("%d",&x);
	f->corps[f->q]=x;
	f->nbr_el++;
	f->etat = (f->nbr_el == DIM) ? PLEINE : AUTRE;
	f->q = (f->q + 1)%DIM;
	return 0;
}

/*Fonction get_head*/

int get_head (File f, int* x) {
  if (f.nbr_el ==0) {
    return -1;
  } else {
    *x=f.corps[f.t-1];
    return 0;
  }
}

/*Fonction get_etat*/

enum etatfile get_etat(File f) {
  return f.etat;
}

/*Fonction afficher*/

void afficher (File f) {
  int i;
  int j; /*Pour bien indexer l'affichage*/
  j=0;
  if (f.nbr_el ==0) {
    printf("PILE VIDE \n");
  }else{
    printf("Les éléments de la pile sont : \n");
    if (f.t < f.q) {
      for (i=f.t;i<f.q;i++) {
	printf("f[%d] ::= %d \n",j,f.corps[i]);
	j++;
      }
    }else{
      for (i=f.t;i<DIM;i++) {
	printf("f[%d] ::= %d \n",j,f.corps[i]);
	j++;
      }
      for (i=0;i<f.q;i++) {
	printf("f[%d] ::= %d \n",j,f.corps[i]);
	j++;
      }
    }
  }
}


      



	

		
		
