import java.io.Serializable;


public class Update implements Serializable {

	private static final long serialVersionUID = 1L;
	public static final int ADD = 0;
	public static final int MUL = 1;
	private int ticket;

	public int index, op, val;

	public Update(int index, int op, int val, int ticket) {
		this.index = index;
		this.op = op;
		this.val = val;
		this.ticket = ticket;
	}
	public int getTicket () {
		return this.ticket;
	}
}
