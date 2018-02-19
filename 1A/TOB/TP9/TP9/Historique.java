import java.util.ArrayList;

/**
 * Historique gère un historique chronologique des réels enregistrés.
 * L'historique est non borné (utilisation d'une ArrayList), sauf par
 * rapport à la quantité de mémoire disponible (OutOfMemoryException) !
 *
 * @author	Xavier Crégut
 * @version	1.5
 */
public class Historique {

	private ArrayList<Double> valeurs;	// les valeurs enregistrées

	/** Construire un historique vide.  */
	public Historique() {
		this.valeurs = new ArrayList<Double>();
	}

	/** Enregistrer une nouvelle information dans l'historique
	 * @param info l'information à enregistrer dans l'historique
	 */
	public void enregistrer(double info) {
		this.valeurs.add(info);
		// Dans ArrayList, on ne peut ajouter que des classes qui dérivent de
		// Object.  En conséquence, on doit mettre un Double et non un double.
	}

	public double GetValeur(int i) {
		double r = getValeur(i);
		System.out.println("GetValeur(" + i + ") = " + r);
		return r;
	}

	/** La i<SUP>è</SUP> valeur de l'historique, 1 correspond à la plus
	 * ancienne, getNbValeurs() à la plus récente (la dernière).
	 *
	 * <b>Attention :</b> Cette convention est différente de celle
	 * traditionnellement adoptée en Java pour les tableaux et vecteurs !
	 * @param i indice de l'opération compris en 1 et getNbValeurs().
	 */
	public double getValeur(int i) {
		return this.valeurs.get(i-1);
	}

	/** Le nombre d'entiers enregistrés dans l'historique
	 * @return le nombre d'entiers dans l'historique
	 */
	public int getNbValeurs() {
		return this.valeurs.size();
	}

	public String toString() {
		return this.valeurs.toString();
	}
}
