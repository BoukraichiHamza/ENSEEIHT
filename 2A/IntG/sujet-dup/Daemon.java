import java.util.HashMap;

public class Daemon extends Thread {
	private int Ticketactu;
	private HashMap<Integer, Update> updates;

	public Daemon() {
		this.Ticketactu = 0;
		this.updates = new HashMap<Integer, Update>();
	}

	public void run() {
		while (true) {

			Update u = ClientImpl.group.receiveUpdate();
			if (u.getTicket() == this.Ticketactu + 1) {
				synchronized (ClientImpl.data) {
					if (u.op == Update.ADD)
						ClientImpl.data[u.index] += u.val;
					if (u.op == Update.MUL)
						ClientImpl.data[u.index] *= u.val;
					Ticketactu++;
					Update v = updates.get(this.Ticketactu + 1);
					while (v != null) {
						synchronized (ClientImpl.data) {
							if (v.op == Update.ADD)
								ClientImpl.data[v.index] += v.val;
							if (v.op == Update.MUL)
								ClientImpl.data[v.index] *= v.val;
							Ticketactu++;
							updates.remove(v.getTicket());
						}
						v = updates.get(this.Ticketactu + 1);
					}
				}

			} else {
				updates.put(u.getTicket(), u);

			}
		}
	}
}
