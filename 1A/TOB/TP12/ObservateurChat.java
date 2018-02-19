import java.util.Iterator;
import java.util.Observable;
import java.util.Observer;

public class ObservateurChat implements Observer {
	private Chat chat;

	public ObservateurChat(Chat chat) {
		this.chat = chat;
		this.chat.addObserver(this);
	}

	@Override
	public void update(Observable o, Object arg) {
		Iterator<Message> iterator = chat.iterateur();
		Message msg = null;
		while (iterator.hasNext()) {
			msg = iterator.next();
		}
		System.out.println(msg.getPseudo()+" : "+msg.getTexte());
	}
}
