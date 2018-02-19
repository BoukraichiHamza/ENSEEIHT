package allumettes;

/**
 * Modélise la stratégie adaptée par le joueur.
 * 
 * @author boukraichi
 *
 */
public interface Strategie {

	/**
	 * Retourne le nombre d'allumettes à tirer.
	 * 
	 * @param JeuCourant
	 *            : Jeu
	 * @return nombre d'allumettes.
	 * @throws CoupInvalideException
	 */
	public int getPrise(Jeu JeuCourant);
}