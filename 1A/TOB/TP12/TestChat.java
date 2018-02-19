
public class TestChat {

	public static void main() {
		String[] pseudos = new String[] { "Moi", "Toi", "Lui" };
		Chat chat = new Chat();

		int x = 10;
		int y = 10;
		for (String nom : pseudos) {
			new ChatSwing(chat, nom).setLocation(x, y);
			x += 100;
			y += 20;
		}
	}
}
