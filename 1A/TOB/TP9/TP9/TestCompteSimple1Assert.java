/** Programme de test sur les comptes simples (utilisant assert).
  * @author	Xavier Crégut
  * @version	1.3
  */
public class TestCompteSimple1Assert {
	public static void main (String args []){
		Personne p1 = new Personne("Xavier", "Crégut", true);
		CompteSimple cs1 = new CompteSimple(p1, 1000);
		assert cs1.getSolde() == 1000;
		cs1.crediter(100);
		assert cs1.getSolde() == 1100;
		cs1.debiter(2000);
		assert cs1.getSolde() == -900;

		CompteSimple cs2 = new CompteSimple(p1);
		assert cs2.getSolde() == 0;
		cs2.crediter(100);
		assert cs2.getSolde() == 100;
	}
}
