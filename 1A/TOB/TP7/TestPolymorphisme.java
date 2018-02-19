/** Tester le polymorphisme (principe de substitution) et la liaison
 * dynamique.
 * @author	Xavier Crégut
 * @version	1.5
 */
public class TestPolymorphisme {

	/** Méthode principale */
	public static void main(String[] args) {
		// Créer et afficher un point p1
		Point p1 = new Point(3, 4);	// Autorisé, car il existe un contructeur de même signature dans la classe point
		
		p1.translater(10,10);		// C'est le translater de la classe Point
		System.out.print("p1 = "); p1.afficher (); System.out.println ();
										// (13,14)

		// Créer et afficher un point nommé pn1
		PointNomme pn1 = new PointNomme (30, 40, "PN1");
										// Autorisé car il existe un constructeur de même signature dans la classe PointNomme
										
		pn1.translater (10,10);		// Le translater de la classe Point
		System.out.print ("pn1 = "); pn1.afficher(); System.out.println ();
										// PN1 : (40,50)

		// Définir une poignée sur un point
		Point q;

		// Attacher un point à q et l'afficher
		q = p1;				// Autorisé, de même type
		System.out.println ("> q = p1;");
		System.out.print ("q = "); q.afficher(); System.out.println ();
										// (13,14)

		// Attacher un point nommé à q et l'afficher
		q = pn1;			// Autorisé, PointNomme sous classe de Point
		System.out.println ("> q = pn1;");
		System.out.print ("q = "); q.afficher(); System.out.println ();
										// PN1 : (40,50)

		// Définir une poignée sur un point nommé
		PointNomme qn;

		// Attacher un point à q et l'afficher
		//qn = p1;			// Non autorisé, Car PointNomme sous classe de Point, pas l'inverse
		System.out.println ("> qn = p1;");
		//System.out.print ("qn = "); qn.afficher(); System.out.println ();
										// Rien, non autorisé

		// Attacher un point nommé à qn et l'afficher
		qn = pn1;			// Oui, même Type
		System.out.println ("> qn = pn1;");
		System.out.print ("qn = "); qn.afficher(); System.out.println ();
										// PN1 : (40,50)

		double d1 = p1.distance (pn1);	// Oui, car PointNomme sous classe de Point
			System.out.println ("distance = " + d1);

		double d2 = pn1.distance (p1);	// Oui, car distance methode de la classe Point, donc PointNomme en hérite
		System.out.println ("distance = " + d2);

		double d3 = pn1.distance (pn1);	// Oui, pour les 2 raisons précédentes
		System.out.println ("distance = " + d3);

		System.out.println ("> qn = q;");
		//qn = q;				// q est un Point qui ne peut pas être convertie en point nomme
		System.out.print ("qn = "); qn.afficher(); System.out.println ();
										// La valeur précédente de qn donc Pn1 : (40,50)

		System.out.println ("> qn = (PointNomme) q;");
		qn = (PointNomme) q;		// Le type de q est forcé en Point nommé donc autorisé.
		System.out.print ("qn = "); qn.afficher(); System.out.println ();

		System.out.println ("> qn = (PointNomme) p1;");
		//qn = (PointNomme) p1;		// Non autorisé : un point ne peut pas être forcé en point nommé.
		System.out.print ("qn = "); qn.afficher(); System.out.println ();
	}
//Question 2.3 : On ne peut pas redéfinir une methode "final".
//Question 2.4 : On ne peut pas hériter d'une classe "final".
//Question 2.5 : - distance prend en paramètres un point et ses sous 	 classes.
//-Distance est une méthode de la classe point, donc héritée par ses sous classes.
//Question 2.6 : q est une poignée sur un objet de type point, donc on peut y attacher des objets de type Point et aussi PointNomme. Lorsque q est affiché : la methode afficher exécuté est celle disponible dans la classe du type de l'objet pointé.



}
