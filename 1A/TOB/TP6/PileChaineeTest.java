/** Programme de test de PileChainee.
  * @author	Xavier Crégut
  * @version	$Revision: 1.1 $
  */
public class PileChaineeTest extends PileTest {

	@Override
	public void setUp() {
		this.unePile = new PileChainee <String> ();
	}

	public static void main(String[] args) {
		org.junit.runner.JUnitCore.main("PileChaineeTest");
	}

}
