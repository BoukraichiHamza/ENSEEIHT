
public class SFicheImpl implements SFiche {

	private String Nom;
	private String Email;
	
	public SFicheImpl(String name, String mail) {
		this.Nom = name;
		this.Email = mail;
	}
	@Override
	public String getNom() {
		return this.Nom;
	}

	@Override
	public String getEmail() {
		return this.Email;
	}

}
