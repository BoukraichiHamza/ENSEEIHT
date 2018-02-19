import java.io.*;
import java.net.*;
import java.util.Random;

public class LoadBalancer extends Thread {
	
	static String hosts[] = {"localhost","localhost"};
	static int ports[] = {8081,8082};
	static int nbHosts = 2;
	static Random rand = new Random();
	private Socket in;
	
	public LoadBalancer(Socket s) {
		this.in= s;
	}
	
	
	public static void main (String args[]) throws IOException {
		ServerSocket ss = new ServerSocket(8080);
   while (true) {
	   Socket s = ss.accept();
	   Thread t = new LoadBalancer(s);
	   t.start();
	   }
	}
	
	public void run () {
		byte buff[] = new byte[1024];
		try {
		OutputStream inos = in.getOutputStream();
		InputStream inis = in.getInputStream();
		int n = rand.nextInt(nbHosts);
		Socket out = new Socket(hosts[n],ports[n]);
		OutputStream outos = out.getOutputStream();
		InputStream outis = out.getInputStream();
		int nbr = inis.read(buff);
		outos.write(buff,0,nbr);
	
		nbr = outis.read(buff);
		inos.write(buff,0,nbr);

		while (nbr == 1024 ) {
			nbr = outis.read(buff);
			inos.write(buff,0,nbr);
		}
		
		inos.close();
		inis.close();
		outos.close();
		outis.close();
		this.in.close();
		out.close();
		
		} catch (IOException e) {
			e.printStackTrace();
		}
	}	
}
