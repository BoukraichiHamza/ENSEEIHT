<<<<<<< .mine
package allumettes;

public class Arbitre {

	/* Les joueurs du jeu */
	private Joueur joueur1;
	private Joueur joueur2;

	public Arbitre(Joueur j1, Joueur j2) {
		assert j1 != null;
		assert j2 != null;
		this.joueur1 = j1;
		this.joueur2 = j2;
	}

	/**
	 * Arbitrer un jeu.
	 * 
	 * @param jeucourant
	 *            : Le jeu courant
	 */

	public void arbitrer(Jeu jeucourant) {

		/* Creation du proxy sur le jeu */
		JeuProxy proxy = new JeuProxy(jeucourant);

		/* Booleen indiquant le tour du joueur1 */
		boolean turn1 = true;
		Joueur joueuractu = joueur1;
		Joueur vainqueur;
		Joueur perdant;
		int prisejoueur;

		while (jeucourant.getNombreAllumettes() > 0) {
			try {
				System.out.println("Nombre d'allumettes restantes :" + jeucourant.getNombreAllumettes());
				if (turn1) {
					joueuractu = this.joueur1;
				} else {
					joueuractu = this.joueur2;
				}
				System.out.println("Au tour de " + joueuractu.getNom() + ".");
				prisejoueur = joueuractu.getPrise(proxy);
				jeucourant.retirer(prisejoueur);
				System.out.println(joueuractu.getNom() + " prend " + prisejoueur + ".");
				turn1 = !turn1;
			} catch (CoupInvalideException e) {
				System.out.println(e.getMessage());
			} catch (OperationInterditeException e) {
				System.out.println("Partie abandonnée car " + joueuractu.getNom() + " a triché !");
				System.exit(1);
			}
		}
		if (!turn1) {
			vainqueur = joueur2;
			perdant = joueur1;
		} else {
			vainqueur = joueur1;
			perdant = joueur2;
		}
		System.out.println(perdant.getNom() + " a perdu !");
		System.out.println(vainqueur.getNom() + " a gagné !");
	}
}
||||||| .r0
=======
package allumettes;

public class Arbitre {

	/* Les joueurs du jeu */
	private Joueur joueur1;
	private Joueur joueur2;

	public Arbitre(Joueur j1, Joueur j2) {
		assert j1 != null;
		assert j2 != null;
		this.joueur1 = j1;
		this.joueur2 = j2;
	}
	/**Retourne l'orthographe exacte de "allumette/s".
	 * Parametres : nba : nombres allumettes
	 */
	
	public String allu(int nb_a ) { 
		if (nb_a == 1) {
			return " allumette";
		} else {
			return " allumettes";
		}
	}
	
	/**
	 * Arbitrer un jeu.
	 * 
	 * @param jeucourant
	 *            : Le jeu courant
	 * @param proxyjeu
	 * 				:un proxy sur le jeu
	 */

	public void arbitrer(Jeu jeucourant, Jeu proxyjeu) {


		/* Booleen indiquant le tour du joueur1 */
		boolean turn1 = true;
		Joueur joueuractu = joueur1;
		Joueur vainqueur;
		Joueur perdant;
		int prisejoueur;

		while (jeucourant.getNombreAllumettes() > 0) {
			try {
				System.out.println("Nombre d'allumettes restantes :" + jeucourant.getNombreAllumettes());
				if (turn1) {
					joueuractu = this.joueur1;
				} else {
					joueuractu = this.joueur2;
				}
				System.out.println("Au tour de " + joueuractu.getNom() + ".");
				prisejoueur = joueuractu.getPrise(proxyjeu);
				System.out.println(joueuractu.getNom() + " prend " + prisejoueur + allu(prisejoueur) + " .\n");
				jeucourant.retirer(prisejoueur);
				turn1 = !turn1;
			} catch (CoupInvalideException e) {
				System.out.println(e.getMessage());
				System.out.println("Recommencez !");
			} catch (OperationInterditeException e) {
				System.out.println("Partie abandonnée car " + joueuractu.getNom() + " a triché !");
				System.exit(1);
			}
		}
		if (!turn1) {
			vainqueur = joueur2;
			perdant = joueur1;
		} else {
			vainqueur = joueur1;
			perdant = joueur2;
		}
		System.out.println(perdant.getNom() + " a perdu !");
		System.out.println(vainqueur.getNom() + " a gagné !");
	}
}
>>>>>>> .r116083
