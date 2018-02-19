
//v0.1 8/10/16 (PM)

import java.nio.file.Paths;
import java.nio.file.Files;
import java.nio.file.LinkOption;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.util.concurrent.ExecutionException;

import java.util.List;
import java.util.Iterator;
import java.util.LinkedList;

import java.util.concurrent.Future;
import java.util.concurrent.Callable;
import java.util.concurrent.Executors;
import java.util.concurrent.ExecutorService;

import java.util.concurrent.RecursiveTask;
import java.util.concurrent.ForkJoinPool;

class MaxLocal implements Callable<Integer> {
	private int début;
	private int fin;
	private int[] tableau;

	MaxLocal(int[] t, int d, int f) {
		début = d;
		fin = f;
		tableau = t;
	}

	@Override
	public Integer call() { // le résultat doit être un objet
		int ml = 0;
		for (int i = 0; i < this.tableau.length; i++) {
			ml = Math.max(this.tableau[i], ml);
		}
		return ml;
	}
}

class TraiterFragment extends RecursiveTask<Integer> {
	private int début;
	private int fin;
	private int[] tableau;
	static int seuil;

	private int max = 0;

	TraiterFragment(int[] t, int d, int f) {
		début = d;
		fin = f;
		tableau = t;
	}

	protected Integer compute() {
		int taille;
		// si la tâche est trop grosse, on la décompose en 2
		// ********* A compléter
		taille = this.fin - this.début;
		if (taille > TraiterFragment.seuil) {
			System.out.println("Décomposition du traitement du tableau de taille :" + taille);
			TraiterFragment frag1 = new TraiterFragment(this.tableau, this.début, this.fin / 2);
			TraiterFragment frag2 = new TraiterFragment(this.tableau, this.fin / 2, this.fin);

			frag1.fork();
			frag2.fork();

			max = Math.max(frag1.join(),frag2.join());
		} else {
			try {
			System.out.println("Traitement direct du tableau");
			ExecutorService poule = Executors.newFixedThreadPool(1);
			Future<Integer> f1 = poule.submit(new MaxLocal(this.tableau, this.début, this.fin));
			max = f1.get();
			poule.shutdownNow();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return max;
	}
}

public class MaxTab {

	static int maxMono(int[] t) {
		int max = 0;
		for (int i = 0; i < t.length; i++) {
			max = Math.max(t[i], max);
		}
		return max;

	}

	static int maxPoolFixe(ExecutorService xs, int[] t, int nbT)
    throws InterruptedException, ExecutionException {
        int max = 0;
        int d;									//indice de départ d'une recherche locale
        int f = 0;  							//indice de fin d'une recherche locale
        int grain = Math.max(1,t.length/nbT); 	/*taille d'une recherche locale 
        										 * = taille du tableau/nombre de tâches lancées
        										 * (ou 1 dans le cas (aberrant) où il y a plus
        										 * de tâches que d'éléments du tableau) */
        List<Future<Integer>> résultats=new LinkedList<Future<Integer>>();
       
        
        for (int i=0;i<nbT-1;i++) {
        	résultats.add(i,xs.submit(new MaxLocal(t,i*grain,+grain+i*(grain-1))));
        	
        }
        

        //récupérer les résultats
        Iterator<Future<Integer>> it = résultats.iterator();
        
        while (it.hasNext()) {
        	Future<Integer> actu = it.next();
        	max = Math.max(actu.get(), max);
        }
        return max;
    }

	static int maxForkJoin(ForkJoinPool f, int[] t) {
		TraiterFragment tout = new TraiterFragment(t, 0, t.length - 1);
		int max = 0; // ********* A corriger
		return max;
	}

	public static void main(String[] args)
			throws InterruptedException, ExecutionException, IOException, FileNotFoundException {

		int nbOuvriersPool = 0; // nb ouvriers du pool fixe. Bonne valeur : nb
								// de processeurs disponibles
		int nbEssais = -1;
		int nbTâches = -1;
		int tailleTronçon = -1; // nombre d'éléments du tableau traités par
								// chaque ouvrier
		String chemin = "";
		int[] tableau;
		long départ, fin;
		int max;

		long[] tempsMono, tempsPool, tempsForkJoin;

		if (args.length == 5) { // analyse des paramètres
			chemin = args[0];
			try {
				nbEssais = Integer.parseInt(args[1]);
				nbTâches = Integer.parseInt(args[2]);
				tailleTronçon = Integer.parseInt(args[3]);
				nbOuvriersPool = Integer.parseInt(args[4]);
			} catch (NumberFormatException nfx) {
				throw new IllegalArgumentException("Usage : MaxTab <fichier> <nb essais> "
						+ "<nb tâches (pool)> <taille tronçon (FJ)>" + " <nb ouvriers du pool (pool)>");
			}
		}
		if ((nbEssais < 1) || (nbTâches < 1) || (tailleTronçon < 1) || (nbOuvriersPool < 1)
				|| !Files.isRegularFile(Paths.get(chemin), LinkOption.NOFOLLOW_LINKS))
			throw new IllegalArgumentException("Usage : MaxTab <fichier> <nb essais> "
					+ "<nb tâches (pool)> <taille tronçon (FJ)>" + " <nb ouvriers du pool (pool)>");
		// appel correct
		tempsMono = new long[nbEssais];
		tempsPool = new long[nbEssais];
		tempsForkJoin = new long[nbEssais];
		tableau = TableauxDisque.charger(chemin);
		System.out.println(Runtime.getRuntime().availableProcessors() + " processeurs disponibles pour la JVM");

		// créer un pool avec un nombre fixe d'ouvriers
		ExecutorService poule = Executors.newFixedThreadPool(nbOuvriersPool);

		// créer un pool ForkJoin
		ForkJoinPool fjp = new ForkJoinPool();
		TraiterFragment.seuil = tailleTronçon;

		for (int i = 0; i < nbEssais; i++) {
			départ = System.nanoTime();
			max = maxMono(tableau);
			fin = System.nanoTime();
			tempsMono[i] = (fin - départ);
			System.out
					.println("Essai [" + i + "] : maximum = " + max + ", durée (mono) " + tempsMono[i] / 1_000 + "µs");
		}
		System.out.println("--------------------");

		for (int i = 0; i < nbEssais; i++) {
			départ = System.nanoTime();
			max = maxPoolFixe(poule, tableau, nbTâches);
			fin = System.nanoTime();
			tempsPool[i] = (fin - départ);
			System.out
					.println("Essai [" + i + "] : maximum = " + max + ", durée (pool) " + tempsPool[i] / 1_000 + "µs");
		}
		poule.shutdown();
		System.out.println("--------------------");

		for (int i = 0; i < nbEssais; i++) {
			départ = System.nanoTime();
			max = maxForkJoin(fjp, tableau);
			fin = System.nanoTime();
			tempsForkJoin[i] = (fin - départ);
			System.out.println(
					"Essai [" + i + "] : maximum = " + max + ", durée (FJ) " + tempsForkJoin[i] / 1_000 + "µs");
		}
		System.out.println("--------------------");
	}
}