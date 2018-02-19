import java.io.*;

/** Quelques méthodes pour lire à partir du clavier.
 *  @author Xavier Crégut (très largement inspiré par Cay Horstmann) */
public class Console {
	/** Afficher un prompt à l'écran (sans passage à la ligne) */
	public static void printPrompt(String prompt) {
		System.out.print(prompt + " ");
		System.out.flush();	// forcer l'écriture en l'absence de '\n'
	}

   /** Lire une chaîne de caractères à partir du clavier.  La chaîne se 
	 * termine par un retour à la ligne (qui n'en fait pas partie) (cf corejava)
	 * @return la ligne lue à partir du clavier (sans le retour à la ligne) */
	public static String readLine() {
		int ch;
		String r = "";
		boolean done = false;
		while (!done) {
			try {
				ch = System.in.read();
				if (ch < 0 || (char) ch == '\n') {
					done = true;
				} else if ((char) ch != '\r') {
							// weird--it used to do \r\n translation
					r = r + (char) ch;
				}
			} catch (java.io.IOException e) {
				done = true;
			}
		}
		return r;
	}
	/**Lire, à partir du clavier, un entier.
	 * @param message affiché pour inviter l'utilisateur à entrer un entier
	 * @return l'entier entré au clavier
	 */
	public static int readInt (String message) {
		boolean reussi = false;
		int valuein = 0 ;
		do {
			try {
				printPrompt(message);
				valuein = Integer.parseInt(readLine());
				reussi = true;
			} catch (NumberFormatException	e) {
			System.out.println("Il faut entrer un entier.");
			}
		} while (! reussi);
		return valuein;
	}
}

