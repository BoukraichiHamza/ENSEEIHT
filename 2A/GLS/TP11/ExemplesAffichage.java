/**
  * Exemples d'affichage d'expressions arithmétiques
  *
  * @author	Xavier Crégut
  * @version	$Revision$
  */

public class ExemplesAffichage {

	static final private OperateurBinaire plus = new Addition();
	static final private OperateurBinaire fois = new Multiplication();
	static final private OperateurBinaire moins = new Soustraction();
	static final private OperateurUnaire negation = new Negation();
	

	static public Expression expression1() {
		return new ExpressionUnaire(negation,
					new ExpressionBinaire(fois,
						new Constante(2),
						new ExpressionBinaire(moins,
							new Constante(1),
							new AccesVariable("x"))));
	}

	static public Expression expression2() {
		return new ExpressionBinaire(plus,
					new Constante(5),
					new ExpressionBinaire(fois,
							new AccesVariable("x"),
							new Constante(4)));
	}
	
	static public Expression expression3() {
		Expression exp2 = new ExpressionBinaire(plus,new AccesVariable("x"),new Constante(17));
		Expression exp = new ExpressionBinaire(fois,new DefinitionLocale("x",new Constante(4),exp2),new Constante(15));
		
		return new ExpressionBinaire(plus, new Constante(5), exp);
	}

	public static void main(String[] args) {
		// Afficher expression 1
		AfficheurInfixe infixe = new AfficheurInfixe();
		AfficheurPostfixe postfixe = new AfficheurPostfixe();
		String e1infixe = expression1().accepter(infixe);
		String e1postfixe = expression1().accepter(postfixe);
		System.out.println("e1 = " + e1infixe);
		System.out.println("e1 = " + e1postfixe);
		
		// Afficher expression2
		String e2infixe = expression2().accepter(infixe);
		String e2postfixe = expression2().accepter(postfixe);
		System.out.println("e2 = " + e2infixe);
		System.out.println("e2 = " + e2postfixe);
		
		// Afficher expression3
				String e3infixe = expression3().accepter(infixe);
				String e3postfixe = expression3().accepter(postfixe);
				System.out.println("e2 = " + e3infixe);
				System.out.println("e2 = " + e3postfixe);
	}
}

