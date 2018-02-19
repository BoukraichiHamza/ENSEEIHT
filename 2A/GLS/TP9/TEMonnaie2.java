
public class TEMonnaie2 extends TEMonnaie {

	public TEMonnaie2(String sonNom) {
		super(sonNom);
	}

	@Override
	protected void tester() throws Throwable {
		m1.retrancher(m2);
		Assert.assertTrue(m1.getValeur()==-2);
	}

}