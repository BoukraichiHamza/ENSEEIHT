/** Programme utilisant les comptes bancaires.  */
public class ExempleComptes {
	public static void main (String argv []) {
		Personne p1 = new Personne("Xavier", "Crégut", true);
		try {
		CompteSimple cs1 = new CompteSimple(p1);
		CompteCourant cc1 = new CompteCourant(p1, 200);

		cs1.crediter(1000);
		System.out.println("Solde de cs1 = " + cs1.getSolde());

		cc1.crediter(1000);
		System.out.println("Solde de cc1 = " + cc1.getSolde());
		cc1.editerReleve();

		CompteSimple cs = cc1;
		cs.debiter(500);
		System.out.println("Solde de cs = " + cs.getSolde());
		System.out.println("Solde de cc1 = " + cc1.getSolde());
		cc1.editerReleve();
		} catch (Exception e) {
					System.out.println(e.getMessage());
				}
	}
}
