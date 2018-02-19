
public class DefinitionLocale implements Expression {
	
	private String nom;
	private Expression valeur;
	private Expression localite;
	
	@Override
	public <R> R accepter(VisiteurExpression<R> visiteur) {
		return visiteur.visiterDefLocale(this);
	}
	
	public DefinitionLocale (String name, Expression val, Expression loc) {
		this.nom = name;
		this.valeur = val;
		this.localite = loc;
	}

	public String getNom() {
		return nom;
	}

	public void setNom(String nom) {
		this.nom = nom;
	}

	public Expression getValeur() {
		return valeur;
	}

	public void setValeur(Expression valeur) {
		this.valeur = valeur;
	}

	public Expression getLocalite() {
		return localite;
	}

	public void setLocalite(Expression localite) {
		this.localite = localite;
	}

}
