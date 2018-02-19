/** Une cellule encapsule un élément et un accès
 * à une autre cellule dite suivante.
 */
class Cellule <G>
 {
	private G element;
	private Cellule <G> suivante;

	//@ ensures this.element == element;
	//@ ensures this.suivante == suivante;
	public Cellule(G element, Cellule <G> suivante) {
		this.element = element;
		this.suivante = suivante;
	}

	public G getElement() {
		return this.element;
	}

	//@ ensures this.element == element;
	public void setElement(G element) {
		this.element = element;
	}

	public Cellule <G> getSuivante() {
		return this.suivante;
	}

	//@ ensures this.suivante == suivante;
	public void setSuivante(Cellule <G> suivante) {
		this.suivante = suivante;
	}

	public String toString() {
		// Attention, il ne faut pas que les cellules forment un cycle !
		return "[" + this.element + "]--"
				+ (this.suivante == null ? 'E' : ">" + this.suivante); 
	}

}
