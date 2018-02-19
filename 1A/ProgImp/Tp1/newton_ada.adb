--Hamza BOUKRAICHI Groupe H
-- Calculer la racine carré d'un nombre grâce à la méthode de Newton
with text_io; use text_io;
with ada.float_text_io; use ada.float_text_io;
procedure newton_ada is
  epsilon :constant float := 0.0001; -- La précision de la procédure
--Fonction newton
--fonction qui calcule la racine carré d'un nombre grace à la méthode de Newton
--x : flotant positif
-- type retourné flottant positif représentant la racine carré
-- précondition x>=0
-- postcondition racine carré>=0
  -- Test 
  -- newton(4)=2
  -- newton(9)=3
  -- newton(0)=0

 function newton ( Fx : in float ) return float is
   a: float := 1.0; -- Le premier terme de la suite d'approximation
   avanta: float; -- pour sauvegarder la valeur de a
 begin
   loop
    avanta := a;
    a := 0.5*(a+Fx/a);
   Exit when abs(a-avanta)<epsilon;
   End loop; -- abs(a-avanta)<epsilon
   return a; -- l'approximation de la racine carré
 end newton;

 x : float;
begin
  --Test avec une valeur constante
  put("la racine carré de 4 est"); 
  put(newton(4.0));
  NEW_LINE;
  --Test avec une valeur lue au clavier
  loop
  put("donner un nombre >=0 ");
  get(x);
  exit when x>=0.0;
  End loop; -- x>=0
  put("la racine carré de ");
  put(x,0);
  put(" est ");
  put(newton(x)); -- préconditions vérifiées
end newton_ada;
  
