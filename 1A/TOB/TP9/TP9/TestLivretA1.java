/**
  * Programme de test de la classe LivretA.
  * @author	Xavier Crégut
  * @version	1.2
  */
public class TestLivretA1 {

	public static void main (String args [])
	{
		Personne p1 = new Personne("Xavier", "Crégut", true);

		// Créer deux comptes
		CompteCourant compte = new CompteCourant(p1, 100);
		LivretA livret = new LivretA(p1, 100);

		// Effectuer 12 versements de 2000 euros.
		for (int nb = 0; nb < 12; nb++) {
			compte.crediter(2000);
			livret.crediter(2000);
		}

		// Afficher le soldes des comptes
		System.out.println("solde du compte = " + compte.getSolde());
		System.out.println("solde du livret = " + livret.getSolde());
	}
}

