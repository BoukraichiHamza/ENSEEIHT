import java.awt.Color;
import afficheur.*;

/**Programme TestAfficheur
 *@author Hamza Boukraichi 1INH
 */

public class TestAfficheur {
   
   /**Définition de l'afficheur et des objets à afficher
    *@param les paramètres de la ligne de commande.
    */
    
   public static void main (String[] args) {
      //Définition de l'afficheur
      Ecran display = new Ecran("TestAfficheur",400,250,15);
      
      //Dessin des axes
      display.dessinerAxes();
      
      //Dessin du point vert en (1,2)
      display.dessinerPoint(1,2,Color.green);
      
      //Dessin du segment
      display.dessinerLigne(6,2,11,9,Color.red);
      
      //Dessin du cercle
      display.dessinerCercle(4,4,2.5,Color.yellow);
      
      //Dessin de "Premier Dessin"
      display.dessinerTexte(1,-2,"Premier Dessin",Color.blue);
   }
}

