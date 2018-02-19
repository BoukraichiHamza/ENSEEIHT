import java.util.concurrent.Semaphore;
public class PhiloSem2 {

	private Semaphore[] SemPhilo;
	private EtatPhilosophe[] etatPhilo;

	/****************************************************************/

	    public PhiloSem2 (int nbPhilosophes) {
	    	this.SemPhilo = new Semaphore[nbPhilosophes];
	    	this.etatPhilo = new EtatPhilosophe[nbPhilosophes];
	    	for (int i =0; i< nbPhilosophes; i++) {
	    		this.SemPhilo[i] = new Semaphore(0);
	    		this.etatPhilo[i] = EtatPhilosophe.Pense;
	    	}
	    }

	/**
	 * Le philosophe no demande les fourchettes. Précondition : il n'en possède
	 * aucune. Postcondition : quand cette méthode retourne, il possède les deux
	 * fourchettes adjacentes à son assiette.
	 */
	public void demanderFourchettes(int no) throws InterruptedException {
		this.etatPhilo[no] = EtatPhilosophe.Demande;
		this.SemPhilo[no].acquire();
		this.etatPhilo[no] = EtatPhilosophe.Mange;
	}

	/**
	 * Le philosophe no rend les fourchettes. Précondition : il possède les deux
	 * fourchettes adjacentes à son assiette. Postcondition : il n'en possède
	 * aucune. Les fourchettes peuvent être libres ou réattribuées à un autre
	 * philosophe.
	 */
	public void libererFourchettes(int no) {
		if (this.etatPhilo[PhiloDroite(no)]);
		this.SemPhilo[no].release();
		
	}

	/** Nom de cette stratégie (pour la fenêtre d'affichage). */
	public String nom() {
		return "Implantation Sémaphores, stratégie 1";
	}

}

}
