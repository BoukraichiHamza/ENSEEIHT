
public class AfficheurInfixeMinimal extends AfficheurInfixe {

	@Override
	public String visiterExpressionBinaire(ExpressionBinaire e) {
		String result;
		Expression eg = e.getOperandeGauche();
		Expression ed = e.getOperandeDroite();
		int priopere = e.getOperateur().getPriorite();

		String result1 = eg.accepter(this);
		String result2 = ed.accepter(this);

		if (eg instanceof ExpressionBinaire) {
			int priofils1 = ((ExpressionBinaire) eg).getOperateur().getPriorite();
			if (priofils1 < priopere) {
				result1 = "(" + result1 + ")";
			}
		}

		if (ed instanceof ExpressionBinaire) {
			int priofils2 = ((ExpressionBinaire) ed).getOperateur().getPriorite();
			if (priofils2 <= priopere) {
				result2 = "(" + result2 + ")";
			}
		}
		result = result1 + " " + e.getOperateur().accepter(this) + " " + result2;
		return result;
	}

	@Override
	public String visiterAccesVariable(AccesVariable v) {
		return v.getNom();
	}

	@Override
	public String visiterConstante(Constante c) {
		return String.valueOf(c.getValeur());
	}

	@Override
	public String visiterExpressionUnaire(ExpressionUnaire e) {
		int priopere = e.getOperateur().getPriorite();
		Expression fils = e.getOperande();
		String result = fils.accepter(this);
		if (fils instanceof ExpressionBinaire) {
			int priofils = ((ExpressionBinaire) fils).getOperateur().getPriorite();
			if (priofils < priopere) {
				result = "(" + result + ")";
			}

		}
		result = e.getOperateur().accepter(this) + " " + result;
		return result;
	}
}
