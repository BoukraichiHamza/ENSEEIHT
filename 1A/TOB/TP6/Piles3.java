import java.awt.Color;

/**Programme manipulant une pile d'entiers; une pile de chaines de caractères et une pile de couleurs
 * @author Hamza BOUKRAICHI 1INH */

public class Piles3 {
   
   public static void main (String[] args) {
    PileChainee <Integer> pileint = new PileChainee <Integer> ();
    PileChainee <String> pilechaine = new PileChainee <String> ();
    PileChainee <Color> pilecou = new PileChainee <Color> ();
   
   //Test Empiler et sommet
   System.out.print("Empilement de 2 éléments \n");
   pileint.empiler(1);
   pileint.empiler(2);
   System.out.print("Le sommet de pileint est " + pileint.sommet() + "\n");
   pilechaine.empiler("a");
   pilechaine.empiler("b");
   System.out.print("Le sommet de pilechaine est " + pilechaine.sommet() + "\n");
   pilecou.empiler(Color.green);
   pilecou.empiler(Color.red);
   System.out.print("Le sommet de pilecou est " + pilecou.sommet() + "\n");
   
   //Test dépiler
    System.out.print("Dépilement d'un élément \n");
   pileint.depiler();
   System.out.print("Le sommet de pileint est " + pileint.sommet() + "\n");
   pilechaine.depiler();
   System.out.print("Le sommet de pilechaine est " + pilechaine.sommet() + "\n");
   pilecou.depiler();
   System.out.print("Le sommet de pilecou est " + pilecou.sommet() + "\n");
}  
}
