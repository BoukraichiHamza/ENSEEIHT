public class TEMonnaie4 extends TestElementaire {
	protected Monnaie m1;
	protected Monnaie m2;
	
	public TEMonnaie4(String sonNom) {
		super(sonNom);
	}

	@Override
	protected void tester() throws Throwable {
		m1.ajouter(m2);
		Assert.assertTrue(m1.getValeur() == 17);
	}
	
	@Override
	protected void preparer() throws Throwable {
		m1 = new Monnaie(5, "euro");
		m2 = new Monnaie(0, "euro");
	}
}
