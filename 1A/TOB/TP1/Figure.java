/**
*Créer la figure 1
*Hamza BOUKRAICHI 1INH
*/

public class Figure {
      //Creation de la figure
      //Aucun argument
      
      public static void main (String[] args) {
	 Segment s12, s23, s31; //Les segments de la figure
	 Point p1, p2, p3; //Les points de la figure
	 Point g; //Barycentre des 3 points
	 
	 //Creation des points
	 p1 = new Point(6,9);
	 p2 = new Point(11,4);
	 p3 = new Point(3,2);
	 
	 //Creation des segments
	 s12 = new Segment(p1,p2);
	 s23 = new Segment(p2,p3);
	 s31 = new Segment(p3,p1);
	 
	 //creation du barycentre
	 g = new Point((p1.getX()+p2.getX()+p3.getX())/3,(p1.getY()+p2.getY()+p3.getY())/3);
	 
	 //Affichage de la figure
	 System.out.println("\n Les points sont : ");
	 p1.afficher();
	 p2.afficher();
	 p3.afficher();
	 System.out.println("\n Les segments sont : ");
	 s12.afficher();
	 s23.afficher();
	 s31.afficher();
	 System.out.println("\n Le barycentre est : ");
	 g.afficher();
      }
   
   }
