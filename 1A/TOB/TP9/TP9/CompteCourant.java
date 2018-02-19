/** Un compte courant est un compte simple avec un historique des
 * opérations effectuées.
 * @author  Xavier Crégut
 * @version 1.10
 */
public class CompteCourant extends CompteSimple {

	/** L'historique des opérations de crédit et débit réalisées. */
	private Historique operations;
	
	/** Construction d'un compte courant dont le solde est nul.
	 * @param titulaire le titulaire du compte
	 * @throws TitulaireInvalideException 
	 * Si le titulaire n'existe pas
	 * @throws DepotInitialException
	 * si le dépot initial n'est pas positif
	 */
	public CompteCourant(Personne titulaire) throws TitulaireInvalideException, DepotInitialException {
		this(titulaire, 0);
	}

	/** Construction d'un compte courant avec un montant initial.
	 * @param titulaire le titulaire du compte
	 * @param depotInitial le montant initial du compte
	 * @throws TitulaireInvalideException 
	 * Si le titulaire n'existe pas
	 * @throws DepotInitialException
	 * si le dépot initial n'est pas positif
	 */
	public CompteCourant(Personne titulaire, double depotInitial) throws TitulaireInvalideException, DepotInitialException {
		super(titulaire, depotInitial);
		this.operations = new Historique();
		if (depotInitial > 0) {
			this.operations.enregistrer(depotInitial);
		}
	}

	/** Créditer le compte du montant (exprimé en euros). L'opération
	 * est enregistrée.
	 * @param montant montant déposé sur le compte en euros
	 * @throws MontantException
	 * si le montant est négatif
	 */
	@Override
	public void crediter(double montant) throws MontantException  {
		super.crediter(montant);
		this.operations.enregistrer(montant);
	}

	/** Débiter le compte du montant (exprimé en euros). L'opération
	 * est  enregistrée.
	 * @param montant montant retiré du compte en euros
	 * @throws MontantException
	 * si le montant est négatif
	 */
	@Override
	public void debiter(double montant) throws MontantException {
		super.debiter(montant);
		this.operations.enregistrer(-montant);
	}

	/** Éditer le relevé du compte. */
	public void editerReleve() {
		System.out.println("----------------------------------------");

		// afficher les caractéristiques du compte
		System.out.print("Titulaire : ");
		this.getTitulaire().afficher();
		System.out.println();

		// Afficher l'historique des opérations
		System.out.println("Historique des opérations : ");
		for (int i = 1, nb = this.operations.getNbValeurs(); i <= nb; i++) {
			if (this.operations.getValeur(i) > 0) {
				System.out.println("  o  Dépôt de " + this.operations.getValeur(i));
			} else {
				System.out.println("  o  Retrait de " + -this.operations.getValeur(i));
			}
		}

		// Afficher le solde du compte
		System.out.println("----------------------------------------");
		System.out.println("Solde du compte : " + getSolde());
		System.out.println("----------------------------------------");
		System.out.println();
	}

		@Override
	public String toString() {
		return super.toString() + ", opérations=" + this.operations;
	}

}
