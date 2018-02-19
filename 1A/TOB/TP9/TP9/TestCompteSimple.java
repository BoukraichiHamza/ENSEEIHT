/** Programme de test sur les comptes simples
  * @author	Xavier Crégut
  * @version	1.4
  */
public class TestCompteSimple {

	public static void verifierSolde(CompteSimple c, double soldeAttendu) {
		if (c.getSolde() != soldeAttendu) {
			System.out.println("Erreur : solde = " + c.getSolde()
				+ " (solde attendu = " + soldeAttendu + ")");
		}
	}

	/** Tester un compte simple. */
	public static void testerCompteSimple(CompteSimple cs) {
		try {
			double soldeInital = cs.getSolde();
			System.out.println("Solde = " + cs.getSolde());
			verifierSolde(cs, soldeInital);
			cs.crediter(100);
			System.out.println("Solde = " + cs.getSolde());
			verifierSolde(cs, soldeInital + 100);
			cs.debiter(2000);
			System.out.println("Solde = " + cs.getSolde());
			verifierSolde(cs, soldeInital - 1900);
				} catch (Exception e) {
					System.out.println(e.getMessage());
				}
	}
					

	public static void main (String args []){
		try {
		Personne p1 = new Personne("Xavier", "Crégut", true);
		CompteSimple cs1 = new CompteSimple(p1, 1000);
		System.out.println("Solde de cs1 = " + cs1.getSolde());
		verifierSolde(cs1, 1000);

		System.out.println("Test de cs1");
		testerCompteSimple(cs1);
		System.out.println();

		CompteSimple cs2 = new CompteSimple(p1);
		System.out.println("Solde de cs2 = " + cs2.getSolde());
		verifierSolde(cs2, 0);

		System.out.println("Test de cs2");
		testerCompteSimple(cs2);
		System.out.println();
	} catch (Exception e) {
		System.out.print(e.getMessage());
	}
}

}
