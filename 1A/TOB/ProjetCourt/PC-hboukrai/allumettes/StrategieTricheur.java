<<<<<<< .mine
package allumettes;

public class StrategieTricheur implements Strategie {

	public StrategieTricheur() {
	};

	@Override
	public int getPrise(Jeu jeucourant) {
		try {
			jeucourant.retirer(jeucourant.getNombreAllumettes() - 2);
		} catch (CoupInvalideException e) {
		}
		return 1;
	}

}
||||||| .r0
=======
package allumettes;

public class StrategieTricheur implements Strategie {

	public StrategieTricheur() {
	};

	@Override
	public int getPrise(Jeu jeucourant) {
		try {
			int nb_allu = jeucourant.getNombreAllumettes()-2;
			for(int i = 0; i<nb_allu;i++) {
			jeucourant.retirer(1);
			}
		} catch (CoupInvalideException e) {
		}
		return 1;
	}

}
>>>>>>> .r116083
