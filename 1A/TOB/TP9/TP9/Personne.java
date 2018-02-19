/**
 *  Une personne est simplement définie par son nom, son prénom et son sexe qui
 *  sont les informations nécessaires pour pouvoir la construire.
 *
 * @author	Xavier Crégut
 * @version	1.5
 *
 */
public class Personne {


	/** le nom */
	private String nom;
	/** le prénom */
	private String prenom;
	/** est-ce un homme ? */
	private boolean masculin;

	/** Construire une personne à partir de nom, son prénom et son sexe.
	 * @param prenom_ le prénom de la personne
	 * @param nom_ le nom de la personne
	 * @param masculin_ est-ce un homme ?
	 */
	public Personne(String prenom, String nom, boolean masculin) {
		this.nom = nom;
		this.prenom = prenom;
		this.masculin = masculin;
	}

	/** Le nom de la personne.
	 * @return le nom de la personne
	 */
	public String getNom() {
		return this.nom;
	}

	/** Le prénom de la personne.
	 * @return le prénom de la personne
	 */
	public String getPrenom() {
		return this.prenom;
	}

	/** La personne est-elle un homme ?
	 * @return la personne est-elle un homme ?
	 */
	public boolean estHomme() {
		return this.masculin;
	}

	/** La personne est-elle une femme ?
	 * @return la personne est-elle une femme ?
	 */
	public boolean estFemme() {
		return ! this.estHomme();
	}

	/** Afficher le nom et le prénom.  */
	public void afficher() {
		System.out.print(this);
	}

	public String toString() {
		return (this.masculin ? "M." : "Mme")
			+ ' ' + this.prenom + ' ' + this.nom;
	}

}
