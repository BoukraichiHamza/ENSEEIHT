
public class MonnaieTest4 {

	protected Monnaie m1;
	protected Monnaie m2;

	public void preparer() {
		this.m1 = new Monnaie(5, "euro");
		this.m2 = new Monnaie(7, "dirhams");
	}

	public void testerAjouter() throws DeviseInvalideException {
		m1.ajouter(m2);
		Assert.assertTrue(m1.getValeur() == 12);
	}

	public void testerRetrancher() throws DeviseInvalideException {
		m1.retrancher(m2);
		Assert.assertTrue(m1.getValeur() == -2);
	}
	
}
