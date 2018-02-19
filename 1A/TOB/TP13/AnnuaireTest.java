import java.util.Collection;
import org.junit.*;
import static org.junit.Assert.*;

/** Programme de test de la classe Annuaire.
  *
  * @author	Xavier CrÃ©gut <Prenom.Nom@enseeiht.fr>
  */
public class AnnuaireTest {

	protected Annuaire annuaire;

	@Before public void setUp() {
		this.annuaire = new Annuaire();
		this.annuaire.enregistrerArrivee("Xavier", "F305");
		this.annuaire.enregistrerArrivee("Marc", "F305");
		this.annuaire.enregistrerArrivee("AurÃ©lie", "F307");
		this.annuaire.enregistrerArrivee("Christiane", "F309");
		this.annuaire.enregistrerArrivee("Marcel", "F309");
	}

	@Test public void testerBureau() {
		assertEquals("F305", this.annuaire.bureau("Xavier"));
		assertEquals("F305", this.annuaire.bureau("Marc"));
		assertEquals("F307", this.annuaire.bureau("AurÃ©lie"));
		assertEquals("F309", this.annuaire.bureau("Christiane"));
		assertEquals("F309", this.annuaire.bureau("Marcel"));
	}

	@Test public void testerModifierBureau() {
		this.annuaire.modifierBureau("Xavier", "F301");
		assertEquals("F301", this.annuaire.bureau("Xavier"));
	}


	@Test public void testerPersonnels() {
		assertEquals(5, this.annuaire.personnels().size());
		assertTrue(this.annuaire.personnels().contains("Xavier"));
		assertTrue(this.annuaire.personnels().contains("Marc"));
		assertTrue(this.annuaire.personnels().contains("AurÃ©lie"));
		assertTrue(this.annuaire.personnels().contains("Christiane"));
		assertTrue(this.annuaire.personnels().contains("Marcel"));
	}


	@Test public void testerPersonnelsParBureau() {
		Collection<String> personnels = this.annuaire.personnels("F307");
		assertEquals(1, personnels.size());
		assertTrue(personnels.contains("AurÃ©lie"));

		personnels = this.annuaire.personnels("F305");
		assertEquals(2, personnels.size());
		assertTrue(personnels.contains("Xavier"));
		assertTrue(personnels.contains("Marc"));

		personnels = this.annuaire.personnels("Salle virtuelle");
		assertEquals(0, personnels.size());
	}


	@Test public void testerBureaux() {
		assertEquals(3, this.annuaire.bureaux().size());
		assertTrue(this.annuaire.bureaux().contains("F305"));
		assertTrue(this.annuaire.bureaux().contains("F307"));
		assertTrue(this.annuaire.bureaux().contains("F309"));
	}

	@Test public void testerEnregistrerDepart() {
		this.annuaire.enregistrerDepart("Marcel");
		assertFalse(this.annuaire.personnels().contains("Marcel"));
		assertEquals(1, this.annuaire.personnels("F309").size());;
		assertFalse(this.annuaire.personnels().contains("Marcel"));
	}

	@Test public void testerOccupationBureaux() {
		assertEquals(1, this.annuaire.occupationBureaux().get("F307").size());
		assertTrue(this.annuaire.occupationBureaux().get("F307").contains("AurÃ©lie"));

		assertEquals(2, this.annuaire.occupationBureaux().get("F305").size());
		assertTrue(this.annuaire.occupationBureaux().get("F305").contains("Marc"));
		assertTrue(this.annuaire.occupationBureaux().get("F305").contains("Xavier"));

		assertEquals(2, this.annuaire.occupationBureaux().get("F309").size());
		assertTrue(this.annuaire.occupationBureaux().get("F309").contains("Christiane"));
		assertTrue(this.annuaire.occupationBureaux().get("F309").contains("Marcel"));

		assertEquals(3, this.annuaire.occupationBureaux().keySet().size());
	}

	@Test(expected=DejaPresentException.class)
	public void testerEnregistrerArrivee() {
		this.annuaire.enregistrerArrivee("Xavier", "FFFF");
	}

	@Test(expected=NullPointerException.class)
	public void testerEnregistrerArriveeNomNul() {
		this.annuaire.enregistrerArrivee(null, "FFFF");
	}

	@Test(expected=NullPointerException.class)
	public void testerEnregistrerArriveeBureauNul() {
		this.annuaire.enregistrerArrivee("Xavier", null);
	}

	@Test(expected=PersonnelInconnuException.class)
	public void testerModifierBureauInconnu() {
		this.annuaire.modifierBureau("Superman", "FFFF");
	}

	@Test(expected=NullPointerException.class)
	public void testerModifierBureauNomNul() {
		this.annuaire.modifierBureau(null, "FFFF");
	}

	@Test(expected=NullPointerException.class)
	public void testerModifierBureauBureauNul() {
		this.annuaire.modifierBureau("Xavier", null);
	}

	@Test(expected=PersonnelInconnuException.class)
	public void testerBureauDInconnu() {
		this.annuaire.bureau("Superman");
	}

	@Test(expected=NullPointerException.class)
	public void testerBureauNomNul() {
		this.annuaire.bureau(null);
	}

	@Test(expected=NullPointerException.class)
	public void testerPersonnelsBureauNul() {
		this.annuaire.personnels(null);
	}

	@Test(expected=PersonnelInconnuException.class)
	public void testerEnregistrerDepartInconnu() {
		this.annuaire.enregistrerDepart("Superman");
	}

	@Test(expected=NullPointerException.class)
	public void testerEnregistrerDepartNomNul() {
		this.annuaire.enregistrerDepart(null);
	}

}
