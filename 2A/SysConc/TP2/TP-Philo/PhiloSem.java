// Time-stamp: <08 déc 2009 08:30 queinnec@enseeiht.fr>

import java.util.concurrent.Semaphore;

public class PhiloSem implements StrategiePhilo {
	private Semaphore[] SemFourchettes;
	

    /****************************************************************/

    public PhiloSem (int nbPhilosophes) {
    	this.SemFourchettes = new Semaphore[nbPhilosophes];
    	for (int i =0; i< nbPhilosophes; i++) {
    		this.SemFourchettes[i] = new Semaphore(1);
    	}
    }

    /** Le philosophe no demande les fourchettes.
     *  Précondition : il n'en possède aucune.
     *  Postcondition : quand cette méthode retourne, il possède les deux fourchettes adjacentes à son assiette. */
    public void demanderFourchettes (int no) throws InterruptedException { 
    	
    	this.SemFourchettes[Main.FourchetteGauche(no)].acquire();
    	this.SemFourchettes[Main.FourchetteDroite(no)].acquire();
    }

    /** Le philosophe no rend les fourchettes.
     *  Précondition : il possède les deux fourchettes adjacentes à son assiette.
     *  Postcondition : il n'en possède aucune. Les fourchettes peuvent être libres ou réattribuées à un autre philosophe. */
    public void libererFourchettes (int no)
    {
    	this.SemFourchettes[Main.FourchetteGauche(no)].release();
    	this.SemFourchettes[Main.FourchetteDroite(no)].release();
    }

    /** Nom de cette stratégie (pour la fenêtre d'affichage). */
    public String nom() {
        return "Implantation Sémaphores, stratégie 1";
    }

}

