
public class ObservateurTest {

	public static void main(String args[]) {
		Chat chat = new Chat();
		ObservateurChat observateurTest = new ObservateurChat(chat);
		chat.ajouter(new MessageTexte("Vincent", "Bonjour"));
		chat.ajouter(new MessageTexte("Zaid", "Couscous"));
		chat.ajouter(new MessageTexte("Banipel", "J'ai pas compris"));
	}
}
