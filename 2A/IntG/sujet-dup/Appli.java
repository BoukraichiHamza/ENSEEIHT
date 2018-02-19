import java.util.Random;


public class Appli extends Thread {

	private Random rand = new Random();

	public void run() {
		for (int i = 0;i<200;i++) {
			int index = rand.nextInt(ClientImpl.nbData);
			int op = rand.nextInt(2);
			int val = rand.nextInt(3)+1;
			
			try {
			int ticket =ClientImpl.l.getTicket();
			ClientImpl.group.sendUpdate(new Update(index, op, val, ticket));
			} catch (Exception e) {
				e.printStackTrace();
			}
			
		}
		System.out.println("Application completed");
	}

}
