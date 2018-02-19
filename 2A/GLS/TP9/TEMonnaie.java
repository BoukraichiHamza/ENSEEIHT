
public abstract class TEMonnaie extends TestElementaire {
	protected Monnaie m1;
	protected Monnaie m2;

	public TEMonnaie(String sonNom) {
		super(sonNom);
		}
	
	@Override
	protected void preparer() throws Throwable {
		 m1 = new Monnaie(5, "euro");
		 m2 = new Monnaie(7, "euro");
	}
	
}
