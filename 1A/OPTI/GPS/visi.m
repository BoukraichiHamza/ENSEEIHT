global nbvisi Pexacte;

SatVisi = zeros(1,NBSAT);
nbvisi = 0;
for sat=1:NBSAT,
   CSAT = COORDSAT(:,sat);
   % Calcul de visibilité
   Vutsat = CSAT-Pexacte(1:3,1); %Vecteur Ut-Sat
   Nutsat = norm(Vutsat,2); % Norme du vecteur Ut-Sat
   Nut = norm(Pexacte(1:3,1),2); % Norme vecteur position Ut
   ProdScal = sum(Vutsat.*Pexacte(1:3,1)); % Produit scalaire
   elevation = asin(ProdScal/(Nutsat*Nut)); % Calcul de l'elevation
   % Test de visibilite 
   if (elevation > ELEVMIN)
      nbvisi=nbvisi+1;
      indvisi(nbvisi) = sat;
      SatVisi(sat) = 1;
      %colorsat(sat) = 'r';
   else
      %colorsat(sat) = 'b';
   end;
   %indvisi = find(SatVisi == 1);
end;

