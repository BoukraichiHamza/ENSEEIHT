/** L'éditeur de ligne réalisée avec une approche « traditionnelle ».
  * @author  Xavier Crégut
  * @version 1.6
  */
public class EditeurTraditionnel {

    private Ligne ligne;

    /** Créer un éditeur pour la ligne l. */
    public EditeurTraditionnel(Ligne l) {
	ligne = l;
    }

    /** Afficher le menu des opérations possibles */
    private void afficher_menu() {
	System.out.println("1- Ajouter un texte au début de la ligne");
	System.out.println("2- Ajouter un texte à la fin de la ligne");
	System.out.print((ligne.getLongueur() > 0) ? "3" : " ");
	System.out.println("- Placer le curseur sur le premier caractère");
	System.out.print(ligne.getCurseur() < ligne.getLongueur()
		? "4" : " ");
	System.out.println("- Avancer le curseur d'une position à droite");
	System.out.print((ligne.getCurseur() > 1) ? "5" : " ");
	System.out.println("- Reculer le curseur d'une position à gauche");
	/* ... */
	System.out.println("0- Quitter");
    }

    /** Sélectionner un numéro d'accès valide. */
    private int selection() {
	int resultat;		// sélection de l'utilisateur
	boolean selection_valide;	// est-elle valide ?
	do {
	    System.out.println("-----------------");
	    resultat = Console.readInt("Votre choix : ");
	    System.out.println("-----------------");
	    selection_valide = resultat >= 0 && resultat <= 5;
	    if (!selection_valide) {
		System.out.println("Entier invalide");
	    }
	} while (!selection_valide);

	return resultat;
    }

    /** Réaliser l'opération associée au choix de l'utilisateur (si
      * elle est réalisable).
      */
    private void traiter(int choix) {
	switch (choix) {
	    case 0 :	// Quitter
		break;

	    case 1 : 	// Ajouter un texte au début
		System.out.println("Non encore réalisée.  Désolé !");
		break;

	    case 2 : 	// Ajouter un texte à la fin
		String texte = Console.readLine("Texte : ");
		for (int i = 0; i < texte.length(); i++) {
		    ligne.ajouterFin(texte.charAt(i));
		}
		break;

	    case 3 :	// RAZ curseur
		if (ligne.getLongueur() > 0) {
		    ligne.raz();
		} else {
		    System.out.println("Opération non réalisable !");
		}
		break;

	    case 4 :	// Avancer curseur
		if (ligne.getCurseur() < ligne.getLongueur()) {
		    ligne.avancer();
		} else {
		    System.out.println("Opération non réalisable !");
		}
		break;

	    case 5 :	// Reculer curseur
		if (ligne.getCurseur() > 1) {
		    ligne.reculer();
		} else {
		    System.out.println("Opération non réalisable !");
		}
		break;

		/* ... */

	    default:
		System.out.println("Erreur de programmation");
	}
    }

    /** Réaliser des opérations d'édition sur la ligne */
    public void editer() {
	boolean quitter;
	do {
	    System.out.println();
	    ligne.afficher(); System.out.println();
	    afficher_menu();
	    int choix = selection();
	    quitter = choix == 0;
	    traiter(choix);
	} while (!quitter);
    }

}

class TestEditeurTraditionnel {

    /** Programme de test interactif ! */
    public static void main(String[] args) {
	Ligne uneLigne = new LigneStringBuffer();
	EditeurTraditionnel editeur = new EditeurTraditionnel(uneLigne);
	editeur.editer();
    }

}
