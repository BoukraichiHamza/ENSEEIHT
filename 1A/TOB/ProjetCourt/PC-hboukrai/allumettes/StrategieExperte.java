<<<<<<< .mine
package allumettes;

import java.util.Random;

public class StrategieExperte implements Strategie {
	/* Generateur aléatoire d'entier. */
	private Random gen;

	public StrategieExperte() {
		this.gen = new Random();
	}

	@Override
	public int getPrise(Jeu jeucourant) {
		assert jeucourant != null;

		int nbr_allu = jeucourant.getNombreAllumettes();
		/* Filtrage Pour asssurer la victoire. */
		if (nbr_allu > jeucourant.PRISE_MAX
				+ 1) { /* Tirage aléatoire tant que pas de cas favorable */
			return (this.gen.nextInt(jeucourant.PRISE_MAX) + 1);
		} else {
			if (nbr_allu == 1) { /* Défaite */
				return 1;
			} else {
				return nbr_allu - 1;
			}
		}
	}
}
||||||| .r0
=======
package allumettes;

import java.util.Random;

public class StrategieExperte implements Strategie {
	/* Generateur aléatoire d'entier. */
	private Random gen;

	public StrategieExperte() {
		this.gen = new Random();
	}

	@Override
	public int getPrise(Jeu jeucourant) {
		assert jeucourant != null;

		int nbr_allu = jeucourant.getNombreAllumettes();
		/*
		 * Test si la le nombre d'allumettes est sous forme de (PriseMax+1)*k +
		 * 1
		 */
		int n = (nbr_allu - 1) % (Jeu.PRISE_MAX + 1);
		/* Filtrage Pour asssurer la victoire. */

		if (n == 0) {

			/* Tirage aléatoire tant que pas de cas favorable */
			return (this.gen.nextInt(Jeu.PRISE_MAX) + 1);
		} else { /* Cas favorable */
			return n;
		}
	}
}
>>>>>>> .r116083
