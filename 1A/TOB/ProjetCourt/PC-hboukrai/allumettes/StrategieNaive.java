<<<<<<< .mine
package allumettes;

import java.util.Random;

public class StrategieNaive implements Strategie {
	/* Generateur aléatoire d'entier. */
	private Random gen;

	public StrategieNaive() {
		this.gen = new Random();
	}

	@Override
	public int getPrise(Jeu jeucourant) {
		assert jeucourant != null;

		/* Récupération de l'interval de tirage possible. */
		int max_tirage = Math.min(jeucourant.PRISE_MAX, jeucourant.getNombreAllumettes());

		/* Génération du tirage. */
		return (this.gen.nextInt(max_tirage) + 1);
	}

}
||||||| .r0
=======
package allumettes;

import java.util.Random;

public class StrategieNaive implements Strategie {
	/* Generateur aléatoire d'entier. */
	private Random gen;

	public StrategieNaive() {
		this.gen = new Random();
	}

	@Override
	public int getPrise(Jeu jeucourant) {
		assert jeucourant != null;

		/* Récupération de l'interval de tirage possible. */
		int max_tirage = Math.min(Jeu.PRISE_MAX, jeucourant.getNombreAllumettes());

		/* Génération du tirage. */
		return (this.gen.nextInt(max_tirage) + 1);
	}

}
>>>>>>> .r116083
