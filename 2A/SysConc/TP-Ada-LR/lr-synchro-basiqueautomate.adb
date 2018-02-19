with Ada.Text_IO; use Ada.Text_IO;
with Ada.Exceptions;

-- Version simple : exclusion mutuelle pour toutes les opérations
--  fournit une ossature pour l'approche "service"

package body LR.Synchro.basiqueautomate is
   
   function Nom_Strategie return String is
   begin
      return "Exclusion mutuelle simple";
   end Nom_Strategie;
   
   type EtatFichier is (R,W,C);
   etat : EtatFichier := C;
   nblecteurs : integer := 0;
   task LectRedTask is
      entry Demander_Lecture;
      entry Demander_Ecriture;
      entry Terminer_Lecture;
      entry Terminer_Ecriture;
   end LectRedTask;

task body LectRedTask is
   begin
      loop
      	select
            when (etat = R) =>
                  accept Demander_Lecture;
                  nblecteurs := nblecteurs + 1;
               or
                  accept Terminer_Lecture;
                  nblecteurs := nblecteurs - 1;
                  if (nblecteurs = 0) then
                     etat := C;
                  else
                     etat := R;
                  end if;
            
            or
            when (etat = W) =>
                  accept Terminer_Ecriture;
                  etat := C;
            or   
            when (etat =C) =>
                  accept Demander_Lecture;
                  nblecteurs := nblecteurs + 1;
                  etat := R;
            or 
            when (etat = C) and (Demander_Lecture'count = 0) =>
                  accept Demander_Ecriture;
                  etat := W;
            end select;
      end loop;
   end LectRedTask;
   

   procedure Demander_Lecture is
   begin
      LectRedTask.Demander_Lecture;
   end Demander_Lecture;

   procedure Demander_Ecriture is
   begin
      LectRedTask.Demander_Ecriture;
   end Demander_Ecriture;

   procedure Terminer_Lecture is
   begin
      LectRedTask.Terminer_Lecture;
   end Terminer_Lecture;

   procedure Terminer_Ecriture is
   begin
      LectRedTask.Terminer_Ecriture;
   end Terminer_Ecriture;

end LR.Synchro.basiqueautomate;
