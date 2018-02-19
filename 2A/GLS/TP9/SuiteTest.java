import java.util.*;

/** Une suite de test est un ensemble de test.
 *
 * @author	Xavier Crégut
 * @version	$Revision: 1.2 $
 * @has * - * Test
 */
public class SuiteTest implements Test {
	
	protected List<Test> listetest;

	/** Les tests de la suite. */
	/** Ajouter un nouveau test dans la suite.
	 * @param test le test à ajouter
	 */
	public SuiteTest() {
		this.listetest = new LinkedList<Test>();
	}
	public void ajouter(Test test) {
		this.listetest.add(test);
	}

	public void lancer(ResultatTest resultats) {
		Iterator<Test> i = this.listetest.iterator();
		Test test;
		while (i.hasNext()) {
			test = i.next();
			test.lancer(resultats);	
		}
	}

}
