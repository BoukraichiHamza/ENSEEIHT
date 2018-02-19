package allumettes;

public class JeuProxy implements Jeu {
	/* Le jeu réel */
	private Jeu jeureel;

	/**
	 * Construire un proxy sur un jeu*.
	 * 
	 * @param realgame
	 *            : le jeu reel
	 */

	public JeuProxy(Jeu realgame) {
		this.jeureel = realgame;
	}

	@Override
	public int getNombreAllumettes() {
		return this.jeureel.getNombreAllumettes();
	}

	@Override
	public void retirer(int nbPrises) {
		throw new OperationInterditeException();
	}
}
