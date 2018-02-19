
public class TestLauncher {
	
	public static void main(String [] args) {
		Test test1 = new TEMonnaie1("Monnaie1");
		Test test2 = new TEMonnaie2("Monnaie2");
		Test test3 = new TEMonnaie3("Monnaie3");
		Test test4 = new TEMonnaie4("Monnaie4");
		ResultatTest result = new ResultatTest();
		test1.lancer(result);
		test2.lancer(result);
		test3.lancer(result);
		test4.lancer(result);
		System.out.println(result.toString());
	}
}
