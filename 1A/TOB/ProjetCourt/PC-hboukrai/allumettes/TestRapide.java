<<<<<<< .mine
package allumettes;

import org.junit.*;
import static org.junit.Assert.*;

public class TestRapide {
	/* Stratégie a tester */
	Strategie strat;

	@Before
	public void SetUp() {
		this.strat = new StrategieRapide();
	}

	@Test
	public void Test1() {
		assertEquals("Nombre allumettes restants = 4 -> Tirage = 3", this.strat.getPrise(new JeuAllu(4)), 3);
	}

	@Test
	public void Test2() {
		assertEquals("Nombre allumettes restants = 3 -> Tirage = 3", this.strat.getPrise(new JeuAllu(3)), 3);
	}

	@Test
	public void Test3() {
		assertEquals("Nombre allumettes restants = 2 -> Tirage = 2", this.strat.getPrise(new JeuAllu(2)), 2);
	}

	@Test
	public void Test4() {
		assertEquals("Nombre allumettes restants = 1 -> Tirage = 1", this.strat.getPrise(new JeuAllu(1)), 1);
	}

	public static void main(String[] args) {
		org.junit.runner.JUnitCore.main(TestRapide.class.getName());
	}

}
||||||| .r0
=======
package allumettes;

import org.junit.*;
import static org.junit.Assert.*;

public class TestRapide {
	/* Stratégie a tester */
	Strategie strat;

	@Before
	public void SetUp() {
		this.strat = new StrategieRapide();
	}

	@Test
	public void Test1() {
		assertEquals("Nombre allumettes restants = 1 -> Tirage = 1", this.strat.getPrise(new JeuAllu(1)), 1);
	}

	@Test
	public void Test2() {
		assertEquals("Nombre allumettes restants = 2 -> Tirage = 2", this.strat.getPrise(new JeuAllu(2)), 2);
	}

	@Test
	public void Test3() {
		assertEquals("Nombre allumettes restants = 3 -> Tirage = 3", this.strat.getPrise(new JeuAllu(3)), 3);
	}

	@Test
	public void Test4() {
		assertEquals("Nombre allumettes restants = 4 -> Tirage = 3", this.strat.getPrise(new JeuAllu(4)), 3);
	}

	@Test
	public void Test5() {
		assertEquals("Nombre allumettes restants = 5 -> Tirage = 3", this.strat.getPrise(new JeuAllu(5)), 3);
	}

	@Test
	public void Test6() {
		assertEquals("Nombre allumettes restants = 6 -> Tirage = 3", this.strat.getPrise(new JeuAllu(6)), 3);
	}

	@Test
	public void Test7() {
		assertEquals("Nombre allumettes restants = 7 -> Tirage = 3", this.strat.getPrise(new JeuAllu(7)), 3);
	}

	@Test
	public void Test8() {
		assertEquals("Nombre allumettes restants = 8 -> Tirage = 3", this.strat.getPrise(new JeuAllu(8)), 3);
	}

	@Test
	public void Test9() {
		assertEquals("Nombre allumettes restants = 9 -> Tirage = 3", this.strat.getPrise(new JeuAllu(9)), 3);
	}

	@Test
	public void Test10() {
		assertEquals("Nombre allumettes restants = 10 -> Tirage = 3", this.strat.getPrise(new JeuAllu(10)), 3);
	}

	@Test
	public void Test11() {
		assertEquals("Nombre allumettes restants = 11 -> Tirage = 3", this.strat.getPrise(new JeuAllu(11)), 3);
	}

	@Test
	public void Test12() {
		assertEquals("Nombre allumettes restants = 12 -> Tirage = 3", this.strat.getPrise(new JeuAllu(12)), 3);
	}

	@Test
	public void Test13() {
		assertEquals("Nombre allumettes restants = 13 -> Tirage = 3", this.strat.getPrise(new JeuAllu(13)), 3);
	}

	public static void main(String[] args) {
		org.junit.runner.JUnitCore.main(TestRapide.class.getName());
	}

}
>>>>>>> .r116083
