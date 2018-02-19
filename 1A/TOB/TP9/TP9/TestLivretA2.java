/**
  * Programme de test de la classe LivretA.
  * @author	Xavier Crégut
  * @version	1.3
  */
public class TestLivretA2 {

	/** Opération d'un automate qui permet à un client de déposer une somme
	 * d'argent sur un de ses comptes.
	 * @param c le compte sur lequel le client souhaite déposer de l'argent
	 * @param somme l'argent que le client veut mettre sur le compte c
	 */
	static public void deposer(CompteSimple c, double somme)
	{
		c.crediter(somme);
	}

	public static void main (String args [])
	{
		Personne p1 = new Personne("Xavier", "Crégut", true);

		// Créer deux comptes
		CompteCourant compte = new CompteCourant(p1, 4000);
		LivretA livret = new LivretA(p1, 4000);

		// Effectuer un virement exceptionnel de 20000 euros
		deposer(compte, 20000);
		deposer(livret, 20000);

		// Afficher le soldes des comptes
		System.out.println("solde du compte = " + compte.getSolde());
		System.out.println("solde du livret = " + livret.getSolde());
	}

}

