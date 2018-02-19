/**
  * Tester le CompteCourant.
  *
  * @author	Xavier Crégut
  * @version	1.2
  */

public class TestCompteCourant {
	public static void main(String[] args){
		Personne p1 = new Personne("Xavier", "Crégut", true);
		try {
		CompteCourant cc1 = new CompteCourant(p1, 1000);

		System.out.println("Test de cc1");
		TestCompteSimple.testerCompteSimple(cc1);
		System.out.println();
		cc1.editerReleve();
		} catch (Exception e) {
			System.out.println(e.getMessage());
			}
	}
}

