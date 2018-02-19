import java.rmi.RemoteException;
import java.rmi.server.UnicastRemoteObject;

public class RFicheImpl extends UnicastRemoteObject implements RFiche {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String Nom;
	private String Email;
	
	public RFicheImpl(String name, String mail) throws RemoteException {
		this.Nom = name;
		this.Email = mail;
	}
	
	@Override
	public String getNom() throws RemoteException {
		return this.Nom;
	}

	@Override
	public String getEmail() throws RemoteException {
		return this.Email;
	}

}
