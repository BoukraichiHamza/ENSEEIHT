public class LanceurTest {
	LanceurIndependant li;

	public void preparer () {
		li= new LanceurIndependant("MonnaieTest", "MonnaieTest3", "MonnaieTest4");
	}
	public void testernbTest () {
		Assert.assertTrue(li.getNbTests()==6);
	}
	
	public void testernbEchec() {
		Assert.assertTrue(li.getNbEchecs()==2);
	}
	
	public void testernbErreur() {
		Assert.assertTrue(li.getNbErreurs()==2);
	}
}
