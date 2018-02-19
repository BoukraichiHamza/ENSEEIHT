
public class CalculHauteur implements VisiteurExpression<Integer> {

	@Override
	public Integer visiterAccesVariable(AccesVariable v) {
		return 1;
	}

	@Override
	public Integer visiterConstante(Constante c) {
		return 1;
	}

	@Override
	public Integer visiterExpressionBinaire(ExpressionBinaire e) {
		return 1 + Math.max(e.getOperandeDroite().accepter(this),e.getOperandeGauche().accepter(this));
	}

	@Override
	public Integer visiterAddition(Addition a) {
		return 0;
	}

	@Override
	public Integer visiterMultiplication(Multiplication m) {
		return 0;
	}

	@Override
	public Integer visiterExpressionUnaire(ExpressionUnaire e) {

		return 1 + e.getOperande().accepter(this);
	}

	@Override
	public Integer visiterNegation(Negation n) {
		return 0;
	}

	@Override
	public Integer visiterSoustraction(Soustraction s) {
		return 0;
	}

	@Override
	public Integer visiterDefLocale(DefinitionLocale d) {
		return 1 + Math.max(d.getValeur().accepter(this),d.getLocalite().accepter(this));
	}
}
