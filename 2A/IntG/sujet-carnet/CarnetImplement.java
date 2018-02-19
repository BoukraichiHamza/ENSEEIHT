import java.rmi.Naming;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.rmi.server.UnicastRemoteObject;
import java.util.HashMap;
import java.util.Map;

public class CarnetImplement extends UnicastRemoteObject implements Carnet {

	private Map<String, RFiche> fiches;
	private int num;

	protected CarnetImplement(int numero) throws RemoteException {
		super();
		this.fiches = new HashMap<>();
		this.num = numero;
	}
	
	public Map<String, RFiche> getFiches ()  throws RemoteException {
		return this.fiches;
	}
	
	@Override
	public void Ajouter(SFiche sfiche) throws RemoteException {
		this.fiches.put(sfiche.getNom(), new RFicheImpl(sfiche.getNom(), sfiche.getEmail()));

	}

	@Override
	public RFiche Consulter(String n, Boolean forward) throws RemoteException {
		Carnet other;
		RFiche rfiche = this.fiches.get(n);
		if (rfiche == null) {
			try {
				if (forward) {
					if (this.num == 1) {
						other = (Carnet) Naming.lookup("//localhost/Carnet" + "2");
					} else {
						other = (Carnet) Naming.lookup("//localhost/Carnet" + "1");
					}
					rfiche = other.Consulter(n,false);
				}

			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return rfiche;
	}

	public static void main(String args[]) {
		try {
			/* Création des registres */
			try {
			Registry registre = LocateRegistry.createRegistry(1099);
			} catch (Exception e) {
			}
				System.out.println("Registry already created");

			/* Création d'une instance du serveur */
			int numero = Integer.parseInt(args[0]);
			Carnet carnet = new CarnetImplement(numero);
			Naming.rebind("//localhost/Carnet" + args[0], carnet);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}
