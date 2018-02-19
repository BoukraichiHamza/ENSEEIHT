<<<<<<< .mine
package allumettes;

public class JeuAllu implements Jeu {
	/* Nb_allumettes restants */
	private int nb_allu;

	/**
	 * Initialise un jeu. /*@param nombres_allumettes
	 */
	public JeuAllu(int nombres_allumettes) {
		this.nb_allu = nombres_allumettes;
	}

	@Override
	public int getNombreAllumettes() {
		return this.nb_allu;
	}

	@Override
	public void retirer(int nbPrises) throws CoupInvalideException {
		if ((nbPrises > Jeu.PRISE_MAX) || (nbPrises == 0)) {
			throw new CoupInvalideException(nbPrises);
		} else {
			this.nb_allu = this.nb_allu - nbPrises;
		}
	}
}
||||||| .r0
=======
package allumettes;

public class JeuAllu implements Jeu {
	/* Nb_allumettes restants */
	private int nb_allu;

	/**
	 * Initialise un jeu. /*@param nombres_allumettes
	 */
	public JeuAllu(int nombres_allumettes) {
		this.nb_allu = nombres_allumettes;
	}

	@Override
	public int getNombreAllumettes() {
		return this.nb_allu;
	}

	@Override
	public void retirer(int nbPrises) throws CoupInvalideException {
		if ((nbPrises > Jeu.PRISE_MAX) || (nbPrises == 0) ||(nbPrises > this.nb_allu) ) {
			throw new CoupInvalideException(nbPrises);
		} else {
			this.nb_allu = this.nb_allu - nbPrises;
		}
	}
}
>>>>>>> .r116083
