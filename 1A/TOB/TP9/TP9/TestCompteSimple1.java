/** Programme de test sur les comptes simples
  * @author	Xavier Crégut
  * @version	1.2
  */
public class TestCompteSimple1 {
	public static void main (String args []){
		Personne p1 = new Personne("Xavier", "Crégut", true);
		try {
		CompteSimple cs1 = new CompteSimple(p1, 1000);
		System.out.println("Solde de cs1 = " + cs1.getSolde());
		cs1.crediter(100);
		System.out.println("Solde de cs1 = " + cs1.getSolde());
		cs1.debiter(2000);
		System.out.println("Solde de cs1 = " + cs1.getSolde());
	}catch (Exception e) {
					System.out.println(e.getMessage());
				}
		try {	
		CompteSimple cs2 = new CompteSimple(p1);	
		System.out.println("Solde de cs2 = " + cs2.getSolde());
		cs2.crediter(100);
		System.out.println("Solde de cs2 = " + cs2.getSolde());
		}catch (Exception e) {
					System.out.println(e.getMessage());
				}
	}
}
