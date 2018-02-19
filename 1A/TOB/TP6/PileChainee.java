/** Réalisation de la pile en utilisant un chaînage entre les éléments.
  * @author	Xavier Crégut
  */
public class PileChainee <G> implements Pile <G> {
	
	private Cellule <G> sommet; /*La cellule en haut de la pile*/
	

	/** Construire une pile vide. */
	//@ ensures this.estVide();
	public PileChainee() {
		this.sommet = null;
		}

	public boolean estVide() {
		return (this.sommet == null);
	}

	public G sommet() {
		return this.sommet.getElement(); 
	}

	public void empiler(G x) {
		this.sommet = new Cellule <G> (x,this.sommet);
	}

	public void depiler() {
		this.sommet = this.sommet.getSuivante();
	}

}
