
public class CommandeRaz extends CommandeLigne {

	@Override
	public void executer() {
		this.ligne.raz();
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
    public CommandeRaz(Ligne l) {
	super(l);
    }
}
