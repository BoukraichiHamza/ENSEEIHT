%D�termination points de contr�le � re param�trer
function [ind] = NoeudPlusProche(p,coefs,nb,dist1)

        dx2 = double(coefs(1,2) - p(1,1))^2;
        dy2 = double(coefs(2,2) - p(2,1))^2;
        dist1(1,1) = sqrt(dx2 + dy2);
        min = dist1(1,1);
        ind = 2;
        for f = 3:nb-1
          dx2 = double(coefs(1,f) - p(1,1))^2;
          dy2 = double(coefs(2,f) - p(2,1))^2;
          dist1(f,1) = sqrt(dx2 + dy2);
          if dist1(f,1)< min
            min = dist1(f,1);
            ind=f;
%             disp(['Le plus proche sommet du ' num2str(i)...
%                 '�me point de la trajectoire de courbure �gale � '...
%                 num2str(courbure(1,i)) ' est ' num2str(f)]);
          end  
        end
    



end