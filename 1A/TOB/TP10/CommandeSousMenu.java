
public class CommandeSousMenu implements Commande {
	
	/**Le sous menu.*/
	private Menu sous_menu;
	
	/**Ligne Modifiée.*/
	private Ligne ligne;

	
	@Override
	public void executer() {
		do {
			// Afficher la ligne
		    System.out.println();
		    this.ligne.afficher();
		    System.out.println();

		    // Afficher le menu
		    this.sous_menu.afficher();

		    // Sélectionner une entrée dans le menu
		    this.sous_menu.selectionner();

		    // Valider l'entrée sélectionnée
		    this.sous_menu.valider();

		} while (! this.sous_menu.estQuitte());
		
	}

	@Override
	public boolean estExecutable() {
		return true;
	}
	
	public CommandeSousMenu (Menu sm, Ligne l) {
		this.sous_menu = sm;
		this.ligne = l;
	}
}
