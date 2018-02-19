<<<<<<< .mine
package allumettes;

import java.util.Scanner;

public class StrategieHumaine implements Strategie {

	/* Pour récupérer le nombre d'allumettes souhaité. */
	private Scanner scan;

	public StrategieHumaine() {
		this.scan = new Scanner(System.in);
	}

	@Override
	public int getPrise(Jeu jeucourant) {

		assert jeucourant != null;

		int nbr_allu = 0;

		while (nbr_allu == 0) {
			try {
				System.out.print("Combien prenez-vous d'allumettes ?");
				nbr_allu = Integer.parseInt(this.scan.nextLine());
			} catch (NumberFormatException e) {
				System.out.print("Ceci n'est pas un entier. \n");
			}
		}
		return nbr_allu;
	}
}
||||||| .r0
=======
package allumettes;

import java.util.Scanner;

public class StrategieHumaine implements Strategie {

	/* Pour récupérer le nombre d'allumettes souhaité. */
	private Scanner scan;

	public StrategieHumaine() {
		this.scan = new Scanner(System.in);
	}

	@Override
	public int getPrise(Jeu jeucourant) {

		assert jeucourant != null;

		int nbr_allu = 0;

		while (nbr_allu == 0) {
			try {
				System.out.print("Combien prenez-vous d'allumettes ?");
				nbr_allu = Integer.parseInt(this.scan.nextLine());
			} catch (NumberFormatException e) {
				System.out.print("Vous devez donner un entier compris entre 1 et " +Jeu.PRISE_MAX+ ".\n");
			}
		}
		return nbr_allu;
	}
}
>>>>>>> .r116083
