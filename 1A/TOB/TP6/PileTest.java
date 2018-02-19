import org.junit.*;
import static org.junit.Assert.*;

/** Programme de test d'une pile.
  * @author	Xavier Crégut
  * @version	$Revision: 1.2 $
  */
abstract public class PileTest {

	protected static final String VAL1 = "a";
	protected static final String VAL2 = "b";
	protected static final String VAL3 = "c";

	protected Pile <String> unePile;

	@Before
	abstract public void setUp();

	@Test
	public void testerInitialisationVide() {
		assertTrue(unePile.estVide());
	}

	@Test
	public void testerEmpilerPremierElement() {
		unePile.empiler(VAL1);
		assertFalse(unePile.estVide());
		assertEquals(VAL1, unePile.sommet());
	}

	@Test
	public void testerEmpilerAutresElements() {
		unePile.empiler("a");

		// Empiler VAL3
		unePile.empiler(VAL3);
		assertFalse(unePile.estVide());
		assertEquals(VAL3, unePile.sommet());

		// Empiler VAL2
		unePile.empiler(VAL2);
		assertFalse(unePile.estVide());
		assertEquals(VAL2, unePile.sommet());
	}

	@Test
	public void testerDepiler() {
		unePile.empiler("a");
		unePile.empiler(VAL3);
		unePile.empiler(VAL2);

		unePile.depiler();
		assertFalse(unePile.estVide());
		assertEquals(VAL3, unePile.sommet());

		unePile.depiler();
		assertFalse(unePile.estVide());
		assertEquals(VAL1, unePile.sommet());

		unePile.depiler();
		assertTrue(unePile.estVide());
	}

}
