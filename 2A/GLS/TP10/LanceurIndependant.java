import java.lang.reflect.*;
import java.util.*;

/**
 * L'objectif est de faire un lanceur simple sans utiliser toutes les clases de
 * notre architecture JUnit. Il permet juste de valider la compréhension de
 * l'introspection en Java.
 */
public class LanceurIndependant {
	private int nbTestsLances;
	private int nbErreurs;
	private int nbEchecs;
	private List<Throwable> erreurs = new ArrayList<>();

	public LanceurIndependant(String... nomsClasses) {
		System.out.println();

		// Lancer les tests pour chaque classe
		for (String nom : nomsClasses) {
			try {
				System.out.print(nom + " : ");
				this.testerUneClasse(nom);
				System.out.println();
			} catch (ClassNotFoundException e) {
				System.out.println(" Classe inconnue !");
			} catch (Exception e) {
				System.out.println(" Problème : " + e);

			}
		}

		// Afficher les erreurs
		for (Throwable e : erreurs) {
			System.out.println();
			e.printStackTrace();
		}

		// Afficher un bilan
		System.out.println();
		System.out.printf("%d tests lancés dont %d échecs et %d erreurs.\n", nbTestsLances, nbEchecs, nbErreurs);
	}

	public int getNbTests() {
		return this.nbTestsLances;
	}

	public int getNbErreurs() {
		return this.nbErreurs;
	}

	public int getNbEchecs() {
		return this.nbEchecs;
	}

	private void testerUneClasse(String nomClasse)
			throws ClassNotFoundException, InstantiationException, IllegalAccessException {
		// Récupérer la classe
		Class classtest = Class.forName(nomClasse);
		// Récupérer les méthodes "preparer" et "nettoyer"
		Method preparer;
		Method nettoyer;
		try {
			preparer = classtest.getMethod("preparer");
		} catch (NoSuchMethodException e) {
			preparer = null;
		}
		try {
			nettoyer = classtest.getMethod("nettoyer");
		} catch (NoSuchMethodException e) {
			nettoyer = null;
		}

		// Instancier l'objet qui sera le récepteur des tests
		Object objet = classtest.newInstance();

		// Exécuter les méthods de test

		/* Récupération des méthodes de tests */
		Method[] tests = classtest.getMethods();
		for (Method m : tests) {
			if (m.getName().startsWith("test")) {
				/* On execute */
				this.nbTestsLances++;
				try {
					/* Préparation */
					if (preparer != null) {
						try {
							preparer.invoke(objet);
						} catch (InvocationTargetException e) {
							throw e.getCause();
						}
					}

					try {
						m.invoke(objet);
					} catch (InvocationTargetException e) {
						throw e.getCause();
					}

					/* Nettoyage */
					if (nettoyer != null) {
						try {
							nettoyer.invoke(objet);
						} catch (InvocationTargetException e) {
							throw e.getCause();
						}

					}
				} catch (Echec f) {
					this.nbEchecs++;
				} catch (Throwable f) {
					this.nbErreurs++;
					this.erreurs.add(f);
				}
			}
		}

	}

	public static void main(String... args) {
		LanceurIndependant lanceur = new LanceurIndependant(args);
	}

}
