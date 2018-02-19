
public class CommandeSupprimer extends CommandeLigne {

	@Override
	public void executer() {
		this.ligne.supprimer();

	}

	@Override
	public boolean estExecutable() {
		return (this.ligne.getLongueur() > 0);
	}

	/** Initialiser la ligne sur laquelle travaille
     * cette commande.
     * @param l la ligne
     */
    //@ requires l != null;	// la ligne doit être définie
    public CommandeSupprimer(Ligne l) {
	super(l);
    }
    
}
