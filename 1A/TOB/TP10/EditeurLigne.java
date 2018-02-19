/** Un éditeur pour une ligne de texte.  Les commandes de
 * l'éditeur sont accessibles par un menu.
 *
 * @author	Xavier Crégut
 * @version	1.6
 */
public class EditeurLigne {

    /** La ligne de notre éditeur */
    private Ligne ligne;

    /** Le menu principal de l'éditeur */
    private Menu menuPrincipal;
    
    /**LE sous menu des curseur.*/
    private Menu sous_menu;
    
	// Remarque : Tous les éditeurs ont le même menu mais on
	// ne peut pas en faire un attribut de classe car chaque
	// commande doit manipuler la ligne propre à un éditeur !

    /** Initialiser l'éditeur à partir de la lign à éditer. */
    public EditeurLigne(Ligne l) {
	ligne = l;
	
	//Creer le sous menu
		sous_menu = new Menu("Commande curseur");
		sous_menu.ajouter("Avancer le curseur d'un caractère",
			    new CommandeCurseurAvancer(ligne));
		sous_menu.ajouter("Reculer le curseur d'un caractère",
			    new CommandeCurseurReculer(ligne));
		sous_menu.ajouter("Ramener le curseur sur le premier caractère",
				new CommandeRaz(ligne));

	// Créer le menu principal
	menuPrincipal = new Menu("Menu principal");
	menuPrincipal.ajouter("Commande Curseur",
			new CommandeSousMenu(sous_menu,ligne));
	menuPrincipal.ajouter("Ajouter un texte en fin de ligne",
		    new CommandeAjouterFin(ligne));
	menuPrincipal.ajouter("Supprimer un caractère",
			new CommandeSupprimer(ligne));
	
	
    }

    public void editer() {
	do {
	    // Afficher la ligne
	    System.out.println();
	    ligne.afficher();
	    System.out.println();

	    // Afficher le menu
	    menuPrincipal.afficher();

	    // Sélectionner une entrée dans le menu
	    menuPrincipal.selectionner();

	    // Valider l'entrée sélectionnée
	    menuPrincipal.valider();

	} while (! menuPrincipal.estQuitte());
    }

}
