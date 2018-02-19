/**
  * Cette exception indique que le titulaire utilisé pour initialiser
  * un compte est invalide.
  * @author	Xavier Crégut
  * @version	1.3
  */

public class TitulaireInvalideException extends Exception {

	public TitulaireInvalideException() {
		super("Titulaire null");
	}

	public TitulaireInvalideException(String message) {
		super(message);
	}

}
