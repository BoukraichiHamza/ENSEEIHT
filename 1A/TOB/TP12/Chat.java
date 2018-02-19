import java.util.List;
import java.util.ArrayList;
import java.util.Observable;
import java.util.Iterator;

public class Chat extends Observable {

	private List<Message> messages;

	public Chat() {
		this.messages = new ArrayList<Message>();
	}

	public void ajouter(Message m) {
		this.messages.add(m);
		this.setChanged();
		this.notifyObservers(m);
	}

	public Iterator<Message> iterateur() {
		return messages.iterator();
	}
}
