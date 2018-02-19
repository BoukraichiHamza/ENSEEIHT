function [E,contour,indices_contour] = recursion(E,contour,indices_contour,...
						i_germe,j_germe,voisins,G_x,G_y,G_norme,card_max,cos_alpha)
% Fonction recursive permettant de construire un ensemble candidat E

G_x_germe = G_x(i_germe,j_germe);
G_y_germe = G_y(i_germe,j_germe);
G_norme_germe = G_norme(i_germe,j_germe);
k = 1;
while k<=size(voisins,1) & size(E,1)<=card_max
	i_voisin = i_germe+voisins(k,1);
	j_voisin = j_germe+voisins(k,2);
	if contour(i_voisin,j_voisin)

		% Dans cette boucle, il faut :
		% - Calculer le produit scalaire entre le gradient du germe et le gradient du voisin
        G_x_vois = G_x(i_voisin,j_voisin);
        G_y_vois = G_y(i_voisin,j_voisin);
        G_norme_voisin = G_norme(i_voisin,j_voisin);
        scal = G_x_germe*G_x_vois+G_y_germe*G_y_vois;
        
		% - Verifier a l'aide du produit scalaire si le voisin est eligible (utiliser cos_alpha)
        if abs(scal) > abs(G_norme_germe*G_norme_voisin*cos_alpha)
		% - Si tel est le cas :
            
		%	+ Mise a jour de "contour"
            contour(i_voisin,j_voisin) = 0;
            
		%	+ Mise a jour de "indices_contour"
        indices_contour = indices_contour(indices_contour~=sub2ind(size(contour),i_voisin,j_voisin));
            
		%	+ Mise a jour de "E"
        E = [E ; i_voisin j_voisin ];
            
		%	+ Appel recursif sur le voisin eligible
        [E,contour,indices_contour] = recursion(E,contour,indices_contour,i_voisin,j_voisin,voisins,G_x,G_y,G_norme,card_max,cos_alpha);
       end
            

	end
	k = k+1;
end
