package allumettes;

public class Joueur {
	/* Nom du joueur. */
	private String nom;

	/* Stratégie du joueur. */
	private Strategie strat;

	/** Construire un joueur à partir de son nom et de sa stratégie.
	 * @param name : nom du joueur
	 * @param strategy du joueur
	 */
	
	public Joueur(String name, Strategie strategy) {
		assert strategy != null;
		this.nom = name;
		this.strat = strategy;
		}

	/** Récupérer le nom du joueur.
	 * @return nom du joueur.
	 */

	public String getNom() {
		return this.nom;
		}

	/** Récupérer la stratégie du joueur.
	 * @return strategie du joueur
	 */

	public Strategie getStrat() {
		return this.strat;
		}

	/** Retourne la prise selon la stratégie.
	 * @param jeuCourant : le jeu en cours
	 * @return prise : entier représentant le nombre d'allumettes à prendre
	 * conseillé par la stratégie.
	 */

	public int getPrise(Jeu jeuCourant) {
		return this.strat.getPrise(jeuCourant);
		}

	/** Changer la stratégie du joueur.
	 * @param newstrat : nouvelle stratégie
	 */
	public void setStrategie(Strategie newstrat) {
		assert newstrat != null;
		this.strat = newstrat;
		}
	}