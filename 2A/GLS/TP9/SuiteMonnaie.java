
public class SuiteMonnaie {
	
	public static void main (String [] args) {
	Test test1 = new TEMonnaie1("Monnaie1");
	Test test2 = new TEMonnaie2("Monnaie2");
	Test test3 = new TEMonnaie3("Monnaie3");
	Test test4 = new TEMonnaie4("Monnaie4");
	ResultatTest result = new ResultatTest();
	SuiteTest suite = new SuiteTest();
	suite.ajouter(test1);
	suite.ajouter(test2);
	suite.ajouter(test3);
	suite.ajouter(test4);
	suite.lancer(result);
	System.out.println(result.toString());
	}
}
