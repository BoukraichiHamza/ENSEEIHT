import java.awt.color;

/**Afficher un schéma sous forme d'un texte explicite
 * @author Hamza Boukraichi 1INH
 */
 
public class AfficheurTexte {
   
   /**Dessiner un point
    * @param x abscisse du point
    * @param y ordonnée du point
    * @param couleur couleur du point
    */
   public void dessinerPoint(double x, double y, Color couleur) {
      System.out.print("Point {/n");
      System.out.print("/t x =" + x + "/n");
      System.out.print("/t y =" + y + "/n");
      System.out.print("/t Couleur =");
      System.out.println(Color.couleur);
   }
   
   /**Dessiner un segment
    * @param x1 abscisse du point 1
    * @param y1 ordonnée du point 1
    * @param x2 abscisse du point 2
    * @param y2 ordonnée du point 2
    * @param couleur couleur du se
    */
    
   public void dessinerSegment(double x1, double y1, double x2, double y2, Color couleur) {
      System.out.print("Ligne {/n");
      System.out.print("/t x1 =" + x1 + "/n");
      System.out.print("/t y1 =" + y1 + "/n");
      System.out.print("/t x2 =" + x2 + "/n");
      System.out.print("/t y2 =" + y2 + "/n");
      System.out.print("/t Couleur =");
      System.out.println(Color.couleur);
   }
   
      /**Dessiner un cercle
    * @param x abscisse du centre du cercle
    * @param y ordonnée du centre du cercle
    * @param r rayon du cercle
    * @param couleur couleur du cercle
    */
   public void dessinerCerlce(double x, double y, double r, Color couleur) {
      System.out.print("Cercle {/n");
      System.out.print("/t centre_x =" + x + "/n");
      System.out.print("/t centre_y =" + y + "/n");
      System.out.print("/t rayon =" + r + "/n");
      System.out.print("/t Couleur =");
      System.out.println(Color.couleur);
   }
   
   /**Dessiner un texte
    * @param x abscisse du mot
    * 
   public void dessinerTexte(double x, double y, java.lang.String texte, java.awt.Color c)
