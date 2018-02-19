import java.awt.Color;

/**Un cercle est une courbe plane fermée constituée des points
 * situés à égale distance d’un point nommé centre.
 * La valeur de cette distance est appelée rayondu cercle.
 * On appelle diamètre la distance entre deux points
 * diamétralement opposés.
 *
 * @author Hamza BOUKRAICHI 1INH
 */

public class Cercle {
	/**Constante de calcul.*/
	public static final double PI = Math.PI;
	/**Centre du cercle.*/
	private Point centre;
	/**Rayon du cercle.*/
  	private double rayon;
	/**Couleur du cercle.*/
	private Color couleur;

	/**Construire un cercle à partir de son centre et de son rayon.
	 * @param fc centre du cercle
	 * @param fr rayon du cercle >=0
	 */
	 public Cercle(Point fc, double fr) {
		assert fc != null;
	  	this.centre = new Point(fc.getX(), fc.getY());
		this.setRayon(fr);
		this.couleur = Color.blue;
	}

	/**Construire un cercle à partir de deux points diamétralement opposés.
	 * @param point1 1er point du cercle
	 * @param point2 2ieme point du cercle
	 */
	public Cercle(Point point1, Point point2) {
		this(point1, point2, Color.blue);
	}

	/**Construire un cercle à partir de deux points diamétralement opposés
	 * et de sa couleur.
	 * @param point1 1er point du cercle
	 * @param point2 2ieme point du cercle
	 * @param fcouleur la couleur du cercle
	 */
	public Cercle(Point point1, Point point2, Color fcouleur) {
		assert point1 != null;
		assert point2 != null;
		assert fcouleur != null;
	  	this.centre = new Point(((point1.getX() + point2.getX()) / 2),
	  	 ((point1.getY() + point2.getY()) / 2));
		this.setRayon(point1.distance(point2) / 2);
		this.couleur = fcouleur;
	}


	/**Translater un cercle sur l'axe des X et l'axe des Y.
	 * @param dx déplacement suivant l'axe des X
	 * @param dy déplacement suivant l'axe des Y
	 */
	public void translater(double dx, double dy) {
	  	this.centre.translater(dx, dy);
	}


	/**Obtenir le centre d'un cercle.
	 * @return centre du cercle
	 */
	public Point getCentre() {
	  	return new Point(this.centre.getX(), this.centre.getY());
	}

	/**Obtenir le rayon d'un cercle.
	 * @return le rayon du cercle
	 */
	public double getRayon() {
	  	return this.rayon;
	}

	/**Obtenir le diamètre d'un cercle.
	 * @return le diamètre du cercle
	 */
	public double getDiametre() {
	 	 return 2 * this.getRayon();
	}

	/**Savoir si un point est contenu dans un cercle.
	 * @param fp point à tester
	 * @return Vrai si le cercle contient le point faux sinon.
	 */
	public boolean contient(Point fp) {
		assert fp != null;
	 	 return fp.distance(this.centre) <= this.rayon;
	}

	/**Obtenir le périmètre d'un cercle.
	 * @return le périmètre du cercle
	 */
	public double perimetre() {
	 	 return 2 * PI * this.rayon;
	}

	/**Obtenir l'aire d'un cercle.
	 * @return l'aire du cercle
	 */
	public double aire() {
		 return PI * this.rayon * this.rayon;
	}

	/**Obtenir la couleur du cercle.
	 * @return couleur du cercle
	 */
	public Color getCouleur() {
	  	return this.couleur;
	}

	/**Changer la couleur du cercle.
	 *@param newcolor nouvelle couleur du cercle
	 */
	public void setCouleur(Color newcolor) {
		assert newcolor != null;
	  	this.couleur = newcolor;
	}

	/**Créer un cercle à partit de deux points.
	 * Le premier correspond au centre.
	 * Le second appartient à la circonférence.
	 * @param point1 le premier point
	 * @param point2 le second point
	 * @return le cercle créé
	 */
	public static Cercle creerCercle(Point point1, Point point2) {
		assert point1 != null;
		assert point2 != null;
	  	return new Cercle(point1, point1.distance(point2));
	}

	/**Renvoi le cercle sous forme de chaine de caractères.
	 * @return le cercle en chaine de caractères
	 */
	public String toString() {
	  	return "C" + this.getRayon() + "@" + this.getCentre();
	}

	/**Changer le rayon du cercle.
	 * @param newr le nouveau rayon du cercle >=0
	 */
	public void setRayon(double newr) {
		assert newr > 0;
	  	this.rayon = newr;
	}

	/**Changer le diamètre du cercle.
	 * @param newdiam le nouveau diamètre du cercle. >= 0
	 */
	public void setDiametre(double newdiam) {
		assert newdiam > 0;
	  	this.setRayon(newdiam / 2);
	}

}





