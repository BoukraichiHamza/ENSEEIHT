#ifndef _PROCESSUS

  #define _PROCESSUS

  typedef enum {ACTIF, SUSPENDU} Etat;
  typedef struct fiche_proc *List_proc;

#endif

/* fonction qui renvoie une nouvelle liste de processus
 * paramètre : aucun
 * résultat : une liste de processus vide (List_proc)
 * pré-condition : aucune
 * post-condition : aucune
 */
List_proc nouvelle_liste();

/* procédure qui affiche une liste de processus
 * paramètre : la liste de processus à afficher (List_proc) (D)
 * pré-condition : aucune
 * post-condition : aucune
 */
void afficher(List_proc l);

/* fonction qui rajoute un processus à une liste de processus
 * paramètres : - le numéro du nouveau processus (int) (D)
 *              - l'état du nouveau processus (Etat) (D)
 *              - l'adresse de la liste de processus (List_proc *) (D/R)
 * résultat : 0 si insertion réussie, autre chose sinon
 * pré-condition : le processus n'est pas déjà présent (pas de doublon)
 * post-condition : la liste n'est plus vide
 */
int inserer_en_tete(int pid, Etat e, List_proc *l);

/* fonction qui supprime un certain processus d'une liste de processus
 * paramètres : - le numéro du nouveau processus à supprimer (int) (D)
 *              - l'adresse de la liste de processus (List_proc *) (D/R)
 * résultat : 0 si suppression réussie, autre chose sinon (liste vide,
 *            processus non présent)
 * pré-condition : aucune
 * post-condition : la liste ne contient plus de processus avec ce numéro
 */
int supprimer(int pid, List_proc *l);

/* procédure qui permet d'appliquer un changement à l'état de tous les
 * processus de la liste
 * paramètres : - la liste de processus (List_proc) (D) [attention, la liste
 *                n'est pas modifiée en tant que structure,
 *                ce sont les valeurs listées qui changent]
 *              - la fonction de changement d'état : Etat -> Etat
 * pré-condition : aucune
 * post-condition : aucune
 */
void appliquer_partout_fe(List_proc l, Etat (*fe)(Etat));

/*Fonction qui recherche si un élément appartient à la liste 
 * Paramètres : -la liste de processus (List_proc (D))
 * 				-le pid du processus recherché ( int (D))
 * Resultat : 1 si il appartient à la liste, 0 sinon
 * Précondition : aucune
 * Postcondition : aucune
 */
 
 int appartient ( List_proc l, int id);
 
 /*Fonction qui permet de modifier l'état d'un processus dans la liste.
  * Paramètres : - la liste de processus (List_proc (D))
  * 			 - Pid du processus à modifier ( int (D))
  * 				- Nouveau etat ( Etat newe)
  * Resultat : 1 si modification réussi, 0 sinon, -1 si la liste est vide
  * Précondition : aucune
  * Postcondition : aucune
  */
  
  int modif_etat ( List_proc l, int pid,  Etat newe);
  
 /* fonction qui rajoute un processus à la fin d'une liste de processus
 * paramètres : - le numéro du nouveau processus (int) (D)
 *              - l'état du nouveau processus (Etat) (D)
 *              - l'adresse de la liste de processus (List_proc *) (D/R)
 * résultat : 0 si insertion réussie, autre chose sinon
 * pré-condition : le processus n'est pas déjà présent (pas de doublon)
 * post-condition : la liste n'est plus vide
 */
 
 int inserer_fin( int pid, Etat e, List_proc * l);
 
 /*Fonction qui vide la liste de processus.
  *Paramètres : - L'adresse de la liste de processus (List_proc *) (D/R)
  *Précondition : aucune
  *Postcondition : aucune
  */
  
  void vider( List_proc *l);
  
  
 
