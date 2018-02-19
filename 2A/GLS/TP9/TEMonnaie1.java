
public class TEMonnaie1 extends TEMonnaie {

	public TEMonnaie1(String sonNom) {
		super(sonNom);
	}

	@Override
	protected void tester() throws Throwable {
		m1.ajouter(m2);
		Assert.assertTrue(m1.getValeur()==12);
	}

}
