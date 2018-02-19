import java.awt.Color;
import afficheur.*;

/** Point modélise un point géométrique dans un plan équipé d'un
 * repère cartésien.  Un point peut être affiché et translaté.
 * Sa distance par rapport à un autre point peut être obtenue.
 *
 * @author  Xavier Crégut <Prénom.Nom@enseeiht.fr>
 */
public class Point {
	private double x;		// abscisse
	private double y;		// ordonnée
	private Color couleur;	// couleur du point

	/** Construire un point à partir de son abscisse et de son ordonnée.
	 * @param vx abscisse
	 * @param vy ordonnée
	 */
	public Point(double vx, double vy) {
		// System.out.println("CONSTRUCTEUR Point(" + vx + ", " + vy + ")");
		x = vx;
		y = vy;
		couleur = Color.green;
	}

	/** Obtenir l'abscisse du point.
	 * @return abscisse du point
	 */
	public double getX() {
		return x;
	}

	/** Obtenir l'ordonnée du point.
	 * @return ordonnée du point
	 */
	public double getY() {
		return y;
	}

	/** Changer l'abscisse du point.
	  * @param vx nouvelle abscisse
	  */
	public void setX(double vx) {
		x = vx;
	}

	/** Changer l'ordonnée du point.
	  * @param vy nouvelle ordonnée
	  */
	public void setY(double vy) {
		y = vy;
	}

	/** Afficher le point. */
	public void afficher() {
		System.out.print("(" + x + ", " + y + ")");
	}

	/** Distance par rapport à un autre point.
	 * @param autre l'autre point
	 * @return distance entre this et autre
	 */
	public double distance(Point autre) {
		return Math.sqrt(Math.pow(autre.x - x, 2)
					+ Math.pow(autre.y - y, 2));
	}

   /** Translater le point.
	* @param dx déplacement suivant l'axe des X
	* @param dy déplacement suivant l'axe des Y
	*/
	public void translater(double dx, double dy) {
		x += dx;
		y += dy;
	}

//  Gestion de la couleur

	/** Obtenir la couleur du point.
	 * @return la couleur du point
	 */
	public Color getCouleur() {
		return couleur;
	}

	/** Changer la couleur du point.
	  * @param nouvelleCouleur nouvelle couleur
	  */
	public void setCouleur(Color nouvelleCouleur) {
		couleur = nouvelleCouleur;
	}	
	
	/**Methode pour dessiner un point
	 * @param display l'ecran ou le point sera déssiné
	 */
	 
	
	public void dessiner ( Ecran display) {
		display.dessinerPoint(this.getX(),this.getY(),this.getCouleur());
	}
		

/*
	// La méthode finalize est appelée avant que le récupérateur de
	// mémoire ne détruise l'objet.  Attention toutefois, on ne sait
	// pas quand ces ressources seront libérées et il est donc
	// dangereux de s'appuyer sur ce mécanisme pour libérer des
	// ressources qui sont en nombre limité.
	//
	// D'autre part, pour être sûr que les méthodes << finalize >>
	// sont appelées avant la fermeture de Java, il faut appeler la
	// méthode statique :
	//		System.runFinalizersOnExit(true)
	//
	protected void finalize() {
		System.out.print("DESTRUCTION du point : ");
		afficher();
		System.out.println();
	}
*/

}
