/**
  * Cette exception indique que le montant rentré en paramètre de créditer et débiter est incorrect.
  * @author	BOUKRAICHI
  * @version	Hamza
  */
public class MontantException extends Exception {
	
	/**Montant Incorrect.*/
	private double montant;
	/**Titulaire du compte où l'erreur à été signalé.*/
	private Personne titulaire;

	public MontantException(String message) {
		super(message);
	}
	public MontantException(double pmontant, Personne ptitulaire) {
		super();
		this.montant = pmontant;
		this.titulaire = ptitulaire;
	}
	
	public MontantException (String message, double pmontant, Personne ptitulaire) {
		super(message);
		this.montant = pmontant;
		this.titulaire = ptitulaire;
	}
}
