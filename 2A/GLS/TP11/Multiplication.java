/**
  * Opérateur binaire de multiplication.
  *
  * @author	Xavier Crégut
  * @version	$Revision$
  */
public class Multiplication implements OperateurBinaire {
	
	public static final int priorite = 1;

	public <R> R accepter(VisiteurExpression<R> visiteur) {
		return visiteur.visiterMultiplication(this);
	}

	@Override
	public int getPriorite() {
		return 2;
	}

}
