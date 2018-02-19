package allumettes;

/**
 * Lance une partie des 13 allumettes en fonction des arguments fournis sur la
 * ligne de commande.
 * 
 * @author Xavier Crégut
 * @version $Revision: 1.5 $
 */
public class Partie {

	/** Lancer une partie. En argument sont donnés les deux joueurs sous la forme
	 * nom@stratégie.
	 * @param args la description des deux joueurs
	 */
	public static void main(String[] args) {
		int option_existe = 0;
		try {
			verifierNombreArguments(args);
			
			if (args.length == 3) {
				option_existe = 1;
			}
			/*
			 * Recupérations des Noms des joueurs et des stratégies en forme de
			 * chaine de caractères.
			 */
			String[] js1 = args[0+option_existe].split("@");
			String[] js2 = args[1+option_existe].split("@");

			/* Récupération des stratégies */
			Strategie strat1 = recupstrat(js1[1]);
			Strategie strat2 = recupstrat(js2[1]);

			/* Création des deux joueurs de la partie */
			Joueur player1 = new Joueur(js1[0], strat1);
			Joueur player2 = new Joueur(js2[0], strat2);

			/* Creation du jeu */
			Jeu jeucourant = new JeuAllu(13);
			/*Creation du proxy sur le jeu*/
			Jeu proxy = new JeuProxy(jeucourant);

			/* Creation de l'arbitre et arbitrage du jeu */
			Arbitre referee = new Arbitre(player1, player2,jeucourant);
			if (option_existe == 1) {
				proxy = jeucourant;
			}
			referee.arbitrer(proxy);
		} catch (ConfigurationException e) {
			System.out.println();
			System.out.println("Strategie inconnue : " + e.getMessage());
			afficherUsage();
			System.exit(1);
		}
	}

	private static void verifierNombreArguments(String[] args) {
		if (args.length < 2) {
			throw new ConfigurationException("Trop peu d'arguments : " + args.length);
		}
		if(args.length == 3){
			if(!(args[0].equals("-confiant"))) {
				throw new ConfigurationException("Option Inconnue : " + args[0]);
			}
		}
		if (args.length > 4) {
			throw new ConfigurationException("Trop d'arguments : " + args.length);
		}
	}

	/** Afficher des indications sur la manière d'exécuter cette classe. */
	public static void afficherUsage() {
		System.out.println("\n" + "Usage :" + "\n\t" + "java allumettes.Partie Option joueur1 joueur2" + "\n\t\t"
				+ "joueur est de la forme nom@stratégie" + "\n\t\t"
				+ "strategie = naif | rapide | expert | humain | tricheur" + "\n" + "\n\t" + "Exemple :" + "\n\t"
				+ "	java allumettes.Partie Xavier@humain " + "Ordinateur@naif" + "\n");
	}

	/**
	 * Retourne la stratégie équivalente à la chaine de caractère.
	 * 
	 * @param :
	 *            nomstrategie : nom de la stratégie
	 * @return : strategie du joueur
	 */

	public static Strategie recupstrat(String nomstrategie) throws ConfigurationException {
		Strategie strat;
		if (nomstrategie.equals("naif")) {
			strat = new StrategieNaive();
		} else if (nomstrategie.equals("expert")) {
			strat = new StrategieExperte();
		} else if (nomstrategie.equals("humain")) {
			strat = new StrategieHumaine();
		} else if (nomstrategie.equals("rapide")) {
			strat = new StrategieRapide();
		} else if (nomstrategie.equals("tricheur")) {
			strat = new StrategieTricheur();
		} else {
			throw new ConfigurationException(nomstrategie);
		}
		return strat;
	}
}
