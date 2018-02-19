<<<<<<< .mine
package allumettes;

public class StrategieRapide implements Strategie {

	public StrategieRapide() {
	}

	@Override
	public int getPrise(Jeu jeucourant) {

		assert jeucourant != null;

		return Math.min(jeucourant.getNombreAllumettes(), jeucourant.PRISE_MAX);
	}

}
||||||| .r0
=======
package allumettes;

public class StrategieRapide implements Strategie {

	public StrategieRapide() {
	}

	@Override
	public int getPrise(Jeu jeucourant) {

		assert jeucourant != null;

		return Math.min(jeucourant.getNombreAllumettes(), Jeu.PRISE_MAX);
	}

}
>>>>>>> .r116083
