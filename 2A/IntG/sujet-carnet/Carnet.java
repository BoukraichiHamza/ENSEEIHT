import java.rmi.Remote;
import java.rmi.RemoteException;
import java.rmi.registry.LocateRegistry;
import java.rmi.registry.Registry;
import java.util.Map;

public interface Carnet extends Remote {

	public void Ajouter(SFiche sf) throws RemoteException;

	public RFiche Consulter(String n, Boolean forward) throws RemoteException;
	
 }
