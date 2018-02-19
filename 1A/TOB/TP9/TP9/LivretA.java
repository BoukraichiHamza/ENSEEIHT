/**
 * Modélisation d'un Livret A (mauvaise façon : héritage de CompteCourant)
 * @author  Xavier Crégut
 * @version 1.6
 */
public class LivretA extends CompteCourant {


	static private double tauxInterets = 1.00;	// en pourcentage
	static private double plafond = 22950;	// en euros

	/** Construction d'un Livret A
	 * @param titulaire le titulaire du compte
	 * @param depotInitial le montant initial du compte
	 */
	public LivretA(Personne titulaire, double depotInitial)
	{
		super(titulaire, depotInitial);
	}

	/** Le taux  d'intérêt d'un Livret A. */
	static public double getTauxInterets() {
		return tauxInterets;
	}

	/** Plafond de dépot d'un Livret A. */
	static public double getPlafond() {
		return plafond;
	}

	/**
	 * Créditer le compte du montant (exprimé en euros) et enregistrer
	 * l'opération de crédit.
	 * @param montant montant déposé sur le compte en euros
	 */
	@Override
	public void crediter(double montant)
	{
		super.crediter(montant);
	}

	/**
	 * Débiter le compte du montant (exprimé en euros) et enregistrer
	 * l'opération de crédit.
	 * @param montant montant retiré du compte en euros
	 */
	@Override
	public void debiter(double montant)
	{
		super.debiter(montant);
	}

}
