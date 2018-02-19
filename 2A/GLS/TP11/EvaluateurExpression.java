import java.util.*;

public class EvaluateurExpression implements VisiteurExpression<Integer> {

	private Map<String, Integer> env;

	public EvaluateurExpression(Map<String, Integer> env) {
		this.env = env;
	}

	@Override
	public Integer visiterAccesVariable(AccesVariable v) {
		return env.get(v.getNom());
	}

	@Override
	public Integer visiterConstante(Constante c) {
		return c.getValeur();
	}

	@Override
	public Integer visiterExpressionBinaire(ExpressionBinaire e) {
		int opg = e.getOperandeGauche().accepter(this);
		int opd = e.getOperandeDroite().accepter(this);
		int op = e.getOperateur().accepter(this);
		int result = 0;
		switch (op) {
		case 0:
			result = opg + opd;
			break;
		case 1:
			result = opg * opd;
			break;
		case 2:
			result = opg - opd;
			break;
		default:
			break;
		}
		return result;
	}

	@Override
	public Integer visiterAddition(Addition a) {
		return 0;
	}

	@Override
	public Integer visiterMultiplication(Multiplication m) {
		return 1;
	}

	@Override
	public Integer visiterExpressionUnaire(ExpressionUnaire e) {
		return e.getOperateur().accepter(this) * e.getOperande().accepter(this);
	}

	@Override
	public Integer visiterNegation(Negation n) {
		return (-1);
	}

	@Override
	public Integer visiterSoustraction(Soustraction s) {
		return 2;
	}

	@Override
	public Integer visiterDefLocale(DefinitionLocale d) {
		int x = d.getValeur().accepter(this);
		String nom = d.getNom();
		this.env.put(nom, x);
		int result = d.getLocalite().accepter(this);
		this.env.remove(nom);
		return result;
	}

}
