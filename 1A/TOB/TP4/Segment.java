import java.awt.Color;
import afficheur.*;

/** Un segment est défini pas ses deux points qui constituent ses
 * extrémités.  Un segment peut être affiché et translaté.
 *
 * @author	Xavier Crégut
 * @version	1.9
 */
public class Segment {

	private Point extremite1;
	private Point extremite2;
	private Color couleur;

	/**  Construire un Segment à partir de ses deux points extrémités.
	 *  @param ext1	le premier point extrémité
	 *  @param ext2	le deuxième point extrémité
	 */
	public Segment(Point ext1, Point ext2) {
		extremite1 = ext1;
		extremite2 = ext2;
		couleur = Color.green;
	}

   /** Translater le segment.
	* @param dx déplacement suivant l'axe des X
	* @param dy déplacement suivant l'axe des Y
	*/
	public void translater(double dx, double dy) {
		extremite1.translater(dx, dy);
		extremite2.translater(dx, dy);
	}

	/** Obtenir la longueur du segment.
	 * @return la longueur du segment
	 */
	public double getLongueur() {
		return extremite1.distance(extremite2);
	}

	/** @deprecated Cette méthode a changé de nom pour respecter
	 * la convention de nommage préconisée par Sun pour Java.
	 * @see #getLongueur()
	 */
	public double longueur() {
		return extremite1.distance(extremite2);
	}

	/** Afficher le segment.  Le segment est affiché sous la forme :
	 * <PRE>
	 *		[extremite1-extremite2]
	 * </PRE>
	 */
	public void afficher() {
		System.out.print("[");
		extremite1.afficher();
		System.out.print("-");
		extremite2.afficher();
		System.out.print("]");
	}

	/** Obtenir la couleur du segment.
	 * @return la couleur du segment
	 */
	public Color getCouleur() {
		return couleur;
	}

	/** Changer la couleur du segment.
	 * @param nouvelleCouleur nouvelle couleur
	 */
	public void setCouleur(Color nouvelleCouleur) {
		couleur = nouvelleCouleur;
	}

	/**Methode pour dessiner un segment
	 * @param display l'ecran ou le segment sera déssiné
	 */
	 
	 public void dessiner ( Ecran display) {
		 display.dessinerLigne(this.extremite1.getX(),this.extremite1.getY(),this.extremite2.getX(),this.extremite2.getY(),this.couleur);
	 }
}
