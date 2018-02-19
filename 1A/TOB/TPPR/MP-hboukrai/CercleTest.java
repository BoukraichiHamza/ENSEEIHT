import java.awt.Color;
import org.junit.*;
import static org.junit.Assert.*;

/**
 * Classe de test des exigences E12 E13 et E14.
 * @author Hamza BOUKRAICHI 1INH
 */

public class CercleTest {

  //Précision pour les comparaisons réelle
  public final static double EPSILON = 0.001;

  //Points de Tests
  private Point A,B,C,D,E;

  //Cercle de Tests
  private Cercle C1, C2, C3, C4;
  
  	

  @Before public void setUp() {
	//Construction des points
	A = new Point(1, 2);
	B = new Point(2, 1);
	C = new Point(4, 1);
	D = new Point(8, 1);
	E = new Point(8, 4);

	//Construction des cercles
	C1 = new Cercle(A, 2.5);
	C2 = new Cercle(C, D);
	C4 = new Cercle (B,E,Color.black);
	C3 = Cercle.creerCercle(D,E);

  }
  
    /** Vérifier si deux points ont mêmes coordonnées.
 	  * @param p1 le premier point
	  * @param p2 le deuxième point
	  */
	static void memesCoordonnees(String message, Point p1, Point p2) {
		assertEquals(message + " (x)", p1.getX(), p2.getX(), EPSILON);
		assertEquals(message + " (y)", p1.getY(), p2.getY(), EPSILON);
	}
	

  //Test E12
  
  @Test public void testerE12() {
	  //Test de l'appartenance des 2 points C et D au cercle C2
	  assertEquals("C appartient à C2", C.distance(C2.getCentre()), C2.getRayon(), EPSILON);
	  assertEquals("D appartient à C2", D.distance(C2.getCentre()), C2.getRayon(), EPSILON);
	  //Test de l'égalité entre le diamètre et la distance entre C et D
	  assertEquals("Distance CD == Diametre C2",C2.getDiametre(),C.distance(D),EPSILON);
	  //Test De la couleur De C2
	  assertEquals("Couleur de C2 bleu",C2.getCouleur(),Color.blue);
	    }

  //Test E13
  
  @Test public void testerE13() {
	  //Test de l'appartenance des 2 points B et E au cercle C4
	  assertEquals("B appartient à C4", B.distance(C4.getCentre()), C4.getRayon(), EPSILON);
	  assertEquals("E appartient à C4", E.distance(C4.getCentre()), C4.getRayon(), EPSILON);
	  //Test de l'égalité entre le diamètre et la distance entre B et E
	  assertEquals("Distance BE == Diametre C4",C4.getDiametre(),B.distance(E),EPSILON);
	  //Test De la couleur De C4
	  assertEquals("Couleur de C4 noir",C4.getCouleur(),Color.black);
  }

  //Test E14
  
 @Test public void testerE14() {
	    //Test de l'appartenance de E au cercle C3
	  assertEquals("E appartient à C3", E.distance(C3.getCentre()), C3.getRayon(), EPSILON);
	  //Test du centre de C3
	  memesCoordonnees("D est le centre de C3",C3.getCentre(),D);
	  //Test de l'égalité entre le rayon et la distance entre C et D
	  assertEquals("Distance DE = rayon C3",C3.getRayon(),D.distance(E),EPSILON);
	  //Test De la couleur De C3
	  assertEquals("Couleur de C3 bleu",C3.getCouleur(),Color.blue);
  }
  	public static void main(String[] args) {
		org.junit.runner.JUnitCore.main(CercleTest.class.getName());
	}
}




