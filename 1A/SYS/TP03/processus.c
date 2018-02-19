#include <stdio.h>
#include <malloc.h>

#include "processus.h"

/* définition du type qui servira de chaînon à la liste chaïnée */
struct fiche_proc {
  int pid;
  Etat e;
  List_proc suivant;
};

/* fonction qui renvoie une nouvelle liste de  
 * paramètre : aucun
 * résultat : une liste de processus vide (List_proc)
 * pré-condition : aucune
 * post-condition : aucune
 */
List_proc nouvelle_liste() {
	return NULL;
}

/* procédure qui affiche une liste de processus
 * paramètre : la liste de processus à afficher (List_proc) (D)
 * pré-condition : aucune
 * post-condition : aucune
 */
void afficher(List_proc l) {
	if ( l == NULL) {
		printf("Liste Vide \n");
	}else{
		printf("Les processus sont : \n");
		while (l != NULL) {
		printf("pid : %d \t statut : %s \n",l -> pid, (l -> e == ACTIF )? "ACTIF" : "SUSPENDU");
		l = l -> suivant;
		}
	}
}

/* fonction qui rajoute un processus à une liste de processus
 * paramètres : - le numéro du nouveau processus (int) (D)
 *              - l'état du nouveau processus (Etat) (D)
 *              - l'adresse de la liste de processus (List_proc *) (D/R)
 * résultat : 0 si insertion réussie, autre chose sinon
 * pré-condition : le processus n'est pas déjà présent (pas de doublon)
 * post-condition : la liste n'est plus vide
 */
int inserer_en_tete(int pid, Etat e, List_proc *l) {
	List_proc nouveau;
	
	if ((nouveau = malloc(sizeof(struct fiche_proc))) == NULL) {
		/*Cas d'erreur : mémoire insuffisante*/
		return -1;
	}
	
	nouveau -> suivant = *l;
	nouveau -> e = e;
	nouveau -> pid = pid;
	*l = nouveau;
	return 0;
}

/* fonction qui supprime un certain processus d'une liste de processus
 * paramètres : - le numéro du nouveau processus à supprimer (int) (D)
 *              - l'adresse de la liste de processus (List_proc *) (D/R)
 * résultat : 0 si suppression réussie, autre chose sinon (-1 liste vide,
 *            -2 processus non présent)
 * pré-condition : aucune
 * post-condition : la liste ne contient plus de processus avec ce numéro
 */
int supprimer(int pid, List_proc *l){
	/*Pour parcourir la liste*/
	List_proc pcour;
	List_proc pprec;
	/*Entier representatif du resultat*/
	int resultat;
	if (*l == NULL) {
		resultat = -1;
	} else {		
		/*Parcours de la liste à la recherche du processus*/
		pcour = (*l) -> suivant;
		pprec = (*l);
		
		/*Test si l'élément à la tête est le le processus recherché*/
		if ( (*l) -> pid == pid ) {
			(*l) = pcour;
			free(pprec);
			resultat = 0;
		} else {
			/*Parcours de la liste à la recherche du processus*/
			pcour = (*l) -> suivant;
			pprec = *l;
		
			while ((pcour != NULL) && (pcour->pid != pid)) {
				pprec = pcour;
				pcour = pcour -> suivant;
			}
			/*Suppression du processus si trouvé*/
			if (pcour == NULL) {
				resultat = -2;
			} else {
				pprec -> suivant = pcour -> suivant;
				free(pcour);
				resultat = 0;				
			}
		}
	}
	return resultat;
}
				
/* procédure qui permet d'appliquer un changement à l'état de tous les
 * processus de la liste
 * paramètres : - la liste de processus (List_proc) (D) [attention, la liste
 *                n'est pas modifiée en tant que structure,
 *                ce sont les valeurs listées qui changent]
 *              - la fonction de changement d'état : Etat -> Etat
 * pré-condition : aucune
 * post-condition : aucune
 */
 
void appliquer_partout_fe(List_proc l, Etat (*fe)(Etat)) {
	while ( l != NULL) {
		l -> e = fe( l ->e);
		l= l -> suivant;
	}
}

/*Fonction qui recherche si un élément appartient à la liste 
 * Paramètres : -la liste de processus (List_proc (D)
 * 				-le pid du processus recherché ( int (D))
 * Resultat : 1 si il appartient à la liste, 0 sinon
 * Précondition : aucune
 * Postcondition : aucune
 */
 
 int appartient ( List_proc l, int pid) {
	 while (( l != NULL) && (l->pid != pid)) {
		 l = l -> suivant;
	 }
	 return l == NULL ? 0 : 1;
 }
 
  /*Fonction qui permet de modifier l'état d'un processus dans la liste.
  * Paramètres : - la liste de processus (List_proc (D))
  * 			 - Pid du processus à modifier ( int (D))
  * 			 - Nouveau etat ( Etat newe)
  * Resultat : 1 si modification réussi, 0 sinon, -1 si la liste est vide
  * Précondition : aucune
  * Postcondition : aucune
  */
  
  int modif_etat ( List_proc l, int id, Etat newe) {
	  /*Indicateur de succés de modification*/
	  int modif_reussie = 0;
	  
	  /*Cas liste vide*/
	  if ( l == NULL) {
		  return -1;
	  } else {
		  /*Recherche du processus dans la liste et modification 
		   * de son état s'il est trouvé */
		   
		   while ((l != NULL) && ( modif_reussie ==0)) {
			   
			   /*Test du pid et modification d'état*/
			   if ( l -> pid == id) {
				   l -> e = newe;
				   modif_reussie = 1;
			   }
			   l = l-> suivant;
		   }
		   return modif_reussie;
	   }
   }
   
 /* fonction qui rajoute un processus à la fin d'une liste de processus
 * paramètres : - le numéro du nouveau processus (int) (D)
 *              - l'état du nouveau processus (Etat) (D)
 *              - l'adresse de la liste de processus (List_proc *) (D/R)
 * résultat : 0 si insertion réussie, -1 sinon
 * pré-condition : le processus n'est pas déjà présent (pas de doublon)
 * post-condition : la liste n'est plus vide
 */
 
 int inserer_fin( int pid, Etat e, List_proc * l) {
	 
	List_proc nouveau, pcour;
	/*Pour parcourir et créer le nouveau maillon*/
	
	 if (*l == NULL) {
		 return inserer_en_tete(pid,e,l);
	 } else {
		 
		 /*Parcours de la liste jusqu'au dernier processus*/
		 pcour = *l;
		 while ( pcour->suivant != NULL) {
			 pcour = pcour -> suivant;
		 }
		 		 
		 /*Creation du nouveau maillon*/
		 if ((nouveau = malloc(sizeof(struct fiche_proc))) == NULL) {
			 /*Memoire insufisante*/
			 return -1;
		 }
		 
		nouveau -> suivant = NULL;
		nouveau -> e = e;
		nouveau -> pid = pid;
		
		/*Ajout du processus comme dernier élément de la liste*/
		pcour -> suivant = nouveau;
		return 0;
	}
} 

 /*Fonction qui vide la liste de processus.
  *Paramètres : - L'adresse de la liste de processus (List_proc *) (D/R)
  *Précondition : aucune
  *Postcondition : aucune
  */
  
  void vider( List_proc * l) {
	  
	/*Pour parcourir la liste*/
	List_proc pcour;
	
	if ( *l != NULL) {
		/*Parcours de la liste et libération de la mémoire*/
		pcour = (*l) -> suivant;
		while ( pcour != NULL) {
			free(*l);
			(*l)=pcour;
			pcour = pcour -> suivant;
		}		
		/*Libération de la mémoire de l'élément en tête*/
		if(l!=NULL)
			free(*l);
			*l=NULL;		
	}
}
   
			   
