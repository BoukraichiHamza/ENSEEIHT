function setPos(h,currentfig,totalfig)
%
% Fonction auxiliaire du TP sur la datation au carbone 14, inclus dans les
% seances de TP d'Optimisation Numerique de 2e annee ENSEEIHT-IMA. 
%
% setPos(H,CURRENTFIG,TOTALFIG) permet d'affecter des proprietes souhaitables
% a l'objet identifie par H (dans le contexte du TP, la figure numero H) et
% de la positionner a la position CURRENTFIG parmi TOTALFIG.
%
% ENSEEIHT - Annee universitaire 2015-2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
set(h, 'Units', 'normalized');
rr = ceil(sqrt(totalfig));
%
if(totalfig<=rr*(rr-1))
rc = rr;
rl = rr -1;
else
rc = rr;
rl = rr;
end
%
dc = 1/rc;
dl = 1/rl;
xx = mod(currentfig-1,rc);
yy = (currentfig-1-xx)/rc;
set(h, 'OuterPosition', [ xx*dc   yy*dl   dc   dl ]);
%
return
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
