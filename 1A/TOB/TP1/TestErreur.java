/** Une erreur à la compilation !
  * Pourquoi ?
  * @author	Xavier Crégut
  * @version	1.3
  */
public class TestErreur {

	/** Méthode principale */
	public static void main(String[] args) {
		Point p1 = new Point(2,3);
		p1.setX(1);
		p1.setY(2);
		p1.afficher();
		System.out.println();
	}

}
