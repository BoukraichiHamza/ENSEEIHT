// Time-stamp: <08 Apr 2008 11:35 queinnec@enseeiht.fr>
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;
import java.util.concurrent.locks.Condition;
/** Lecteurs/rédacteurs
 * stratégie d'ordonnancement: priorité aux rédacteurs,
 * implantation: avec un moniteur. */

public class LectRed_PrioRedacteur implements LectRed
{
	/*Protections des ressources partagées*/
	
	private Lock moniteur;
	private Condition accesLecture;
	private Condition accesEcriture;
	private int lectureAttente;
	private int ecritureAttente;
	private int lectureEnCours;
	private boolean ecritureEnCours;
	
    public LectRed_PrioRedacteur()
    {
    	this.moniteur = new ReentrantLock();
    	this.accesLecture = moniteur.newCondition();
    	this.accesEcriture = moniteur.newCondition();
    	this.lectureAttente = 0;
    	this.ecritureAttente = 0;
    	this.lectureEnCours = 0;
    	this.ecritureEnCours = false;
    }

    public void demanderLecture() throws InterruptedException
    {
    	this.moniteur.lock();
    	while(this.ecritureEnCours || this.ecritureAttente > 0) {
    		this.lectureAttente++;
    		this.accesLecture.await();
    		this.lectureAttente--;
    	}
    	this.lectureEnCours++;
    	this.moniteur.unlock();
    }

    public void terminerLecture() throws InterruptedException
    {
    	this.moniteur.lock();
    	this.lectureEnCours--;
    	if (this.lectureEnCours == 0 & this.ecritureAttente > 0) {
    		this.accesEcriture.signal();
    	}
    	this.moniteur.unlock();
    }

    public void demanderEcriture() throws InterruptedException
    {
    	this.moniteur.lock();
    	while (this.ecritureEnCours || this.lectureEnCours > 0)  {
    		this.ecritureAttente++;
    		this.accesEcriture.await();
    		this.ecritureAttente--;
    	}
    	this.ecritureEnCours = true;
    	this.moniteur.unlock();
    }

    public void terminerEcriture() throws InterruptedException
    {
      this.moniteur.lock();
      this.ecritureEnCours = false;
      if (this.ecritureAttente == 0 & this.lectureAttente > 0 ) {
    	  this.accesLecture.signalAll();
      } else if (this.ecritureAttente > 0 ) {
    	  this.accesEcriture.signal();
		
	}
      this.moniteur.unlock();
    }

    public String nomStrategie()
    {
        return "Stratégie: Priorité Rédacteurs.";
    }
}
