
public class TEMonnaie3 extends TestElementaire {
	protected Monnaie m1;
	protected Monnaie m2;
	
	public TEMonnaie3(String sonNom) {
		super(sonNom);
	}

	@Override
	protected void tester() throws Throwable {
		m1.retrancher(m2);
		Assert.assertTrue(m1.getValeur() == -2);
	}
	
	@Override
	protected void preparer() throws Throwable {
		m1 = new Monnaie(5, "euro");
		m2 = new Monnaie(7, "dirhams");
	}
}
