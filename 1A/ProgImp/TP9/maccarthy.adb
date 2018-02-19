--HAMZA BOUKRAICHI GROUPE H
--Programme affichant les valeurs de la fonction de MacCarthy de 0 à 110

--=======================================================================
with text_io;
use text_io;
with ada.integer_text_io;
use ada.integer_text_io;
--=======================================================================
Procedure Maccarthy is

--=============Déclarations de sous programmes===========================
  --Fonction MacCarthy
  --Fonction qui retourne la valeur de La fonction MacCarthy d'un entier
  --Paramètres :
    --Fn : entier;Donnée, entier où la fonction MacCarthy sera appliqué
  --Préconditions : n>=0
  function MacCarthyFonc ( Fn : IN INTEGER) return Integer is
  Val:Integer;
  Begin
    If Fn>100 Then
      Val:=Fn-10;
    Else
      Val:=MacCarthyFonc(MacCarthyFonc(Fn+11));
    End if;  
    Return Val;
  End MacCarthyFonc;

--===============Programme Principale=====================================
 Begin
   For i in 1..110 Loop
     Put(MacCarthyFonc(i));
     NEW_LINE;
   End loop;
 End Maccarthy;
 --========================================================================
