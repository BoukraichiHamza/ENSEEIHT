--HAMZA BOUKRAICHI GROUPE H
--Programme affichant des lignes de nombres

--=======================================================================
with text_io;
use text_io;
with ada.integer_text_io;
use ada.integer_text_io;
--=======================================================================
procedure affiche_nombre is 

--============Declaration de sous programmes=============================
--Procedure aux_affiche
--Procedure qui affiche des lignes de nombres selon la fonction linéaire 10*a+b
--Paramètres :-- Fm : INTEGER, Donnée, délimitant l'intervalle de variation du premier nombre
              -- Fn : INTEGER, Donnée, délimitant l'intervalle de variation du second nombre
              -- Fsavn : INTEGER, Donnée, sauvegarde de la valeur de n
--Précondition n,m>=0
--Postcondition : des lignes de nombres sont affichées


Procedure aux_affiche (Fm : in integer ; Fn: in integer ; Fsavn : in integer) is

Begin
  If Fm<0 Then
    Null;
  Elsif  Fn<0 Then
     aux_affiche(Fm-1,Fsavn,Fsavn);
      New_line;
  Else
      aux_affiche(Fm,Fn-1,Fsavn);
      Put(10*Fm + Fn);
  End If;
 End aux_affiche;
--=======================================================================

--=======================================================================
--procedure affiche
--Procedure qui affiche des lignes de nombres selon la fonction linéaire 10*a+b
--Paramètres :-- m : INTEGER, Donnée, délimitant l'intervalle de variation du premier nombre
              -- n : INTEGER, Donnée, délimitant l'intervalle de variation du second nombre
--Précondition n,m>=0
--Postcondition : des lignes de nombres sont affichées
  Procedure affiche (Fm : in integer; Fn : in integer) is  
  Begin
      aux_affiche(Fm,Fn,Fn);
   End affiche;


--=======================================================================
--=======================================================================

--======================Programme Principale=============================
Begin
affiche(5,4);
End affiche_nombre;


--=======================================================================


