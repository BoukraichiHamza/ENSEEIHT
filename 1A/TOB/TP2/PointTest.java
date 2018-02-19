import org.junit.*;
import static org.junit.Assert.*;
import java.awt.Color;

/** Programme de test de la classe Point.
  * @author	Xavier Crégut
  * @version	1.11
  */
public class PointTest {

	public static final double EPSILON = 1e-6;
		// précision pour la comparaison entre réels.

	private Point p1;
	private Point p2;

	@Before
	public void setUp() {
		p1 = new Point(1, 2);
		p2 = new Point(4, -2);
	}

	@Test
	public void testInitialisation() {
		assertTrue(p1 != null);
		assertTrue(p2 != null);
		assertTrue(p1.getX() == 1);
		assertTrue(p1.getY() == 2);
		assertTrue(p2.getX() == 4);
		assertTrue(p2.getY() == -2);
	}

	@Test
	public void testInitialisationMieux() {
		// Remarque : faire un test d'égalité sur des réels est à éviter
		// à cause des erreurs d'arrondi.  En conséquence, il faut
		// vérifier que les deux nombres sont égaux à EPSILON près.
		// C'est ce que fait assertEquals(attendu, réel, précision)
		assertNotNull(p1);
		assertNotNull(p2);
		assertEquals(1.0, p1.getX(), EPSILON);
		assertEquals(2.0, p1.getY(), EPSILON);
		assertEquals(4.0, p2.getX(), EPSILON);
		assertEquals(-2.0, p2.getY(), EPSILON);
	}

	@Test
	public void testSetX() {
		p1.setX(10);
		assertEquals(10.0, p1.getX(), EPSILON);
		p1.setX(-5);
		assertEquals(-5.0, p1.getX(), EPSILON);
	}

	@Test
	public void testSetY() {
		p1.setY(10);
		assertEquals(10.0, p1.getY(), EPSILON);
		p1.setY(-5);
		assertEquals(-5.0, p1.getY(), EPSILON);
	}

	@Test
	public void testDistance() {
		assertEquals(0.0, p1.distance(p1), EPSILON);
		assertEquals(0.0, p2.distance(p2), EPSILON);
		assertEquals(5.0, p1.distance(p2), EPSILON);
		assertEquals(5.0, p2.distance(p1), EPSILON);
	}

	@Test
	public void testTranslater1() {
		p1.translater(2, 4);
		assertEquals(3.0, p1.getX(), EPSILON);
		assertEquals(6.0, p1.getY(), EPSILON);
	}

	@Test
	public void testTranslater2() {
		p2.translater(-2, -4);
		assertEquals(2.0, p2.getX(), EPSILON);
		assertEquals(-6.0, p2.getY(), EPSILON);
	}

	@Test
	public void testgetCouleur() {
		assertEquals(p1.getCouleur(),Color.green);
		assertEquals(p2.getCouleur(),Color.green);
	}
	
	@Test
	public void testsetCouleur() {
		p1.setCouleur(Color.yellow);
		assertEquals(p1.getCouleur(),Color.yellow);
		p2.setCouleur(Color.red);
		assertEquals(p2.getCouleur(),Color.red);
	}	
}
