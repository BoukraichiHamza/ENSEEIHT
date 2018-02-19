/** TestElementaire décrit un seul test.
 * @depend_notdefined - <send> - DeviseInvalideException
 * @author	Xavier Crégut
 * @version	$Revision: 1.2 $
 */
abstract public class TestElementaire implements Test {

	/** Le nom du test. */
	private String nom;

	/** Initialiser ce test.
	 * @param sonNom le nom du test
	 */
	public TestElementaire(String sonNom) {
		this.nom = sonNom;
	}
	/*La méthode lancer est déclarée final afin que 
	 * toute classe héritant de test élémentaires aie la même méthode lancer.*/
	final public void lancer() {
		ResultatTest resultats = new ResultatTest();
		this.lancer(resultats);
		System.out.println(resultats);
	}

	final public void lancer(ResultatTest resultats) {
		try {
			this.preparer();
			try {
				resultats.incrementerTest();
				this.tester();
			} catch (Echec e) {
				resultats.ajouterEchec(this, e);
			} catch (Throwable e) {
				resultats.ajouterErreur(this, e);
			} finally {
				this.nettoyer();
			}
		} catch(Throwable e) {
			resultats.ajouterErreur(this, e);
			}
	}
	
	/*Les méthodes sont protected car on va faire de l'héritage.*/
	/* Afin de permettre aux classes qui héritent puissent déclarer et propager ces erreurs.*/
	/* Préparer les données pour le test. */
	protected void preparer() throws Throwable {
	}

	/** Réaliser le test effectif. */
	abstract protected void tester() throws Throwable;

	/** Nettoyer après l'exécution de tester. */
	protected void nettoyer() throws Throwable {
	}

}
