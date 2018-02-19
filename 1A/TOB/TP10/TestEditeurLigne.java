/** Programme de test de EditeurLigne.
  *
  * @author	Xavier Crégut
  * @version	1.1
  */

public class TestEditeurLigne {

    public static void main(String[] args) {
	Ligne uneLigne = new LigneStringBuffer();
	EditeurLigne editeur = new EditeurLigne(uneLigne);
	editeur.editer();
    }

}
