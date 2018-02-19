--Hamza Boukraichi groupe H
-- programme qui affiche le menu et traite les choix du controle du drone
with text_io; use text_io;
with ada.integer_text_io; use ada.integer_text_io;
procedure drone_ada is
ch: CHARACTER; -- La commande entrée par l'utilisateur
alt: integer :=0; -- L'altitude du drone
ademarrer:boolean; -- L'état du drone : démarré/au repos
begin
Loop
  put("Que faire : (d)émarrer (m)monter de(s)cendre (q)uitter ?)");
  new_line;
  get(ch);
  CASE ch is
    when 'd' =>
      ademarrer:=true;
    when 'm' =>
      if ademarrer=true then
           if alt<5 then alt:=alt+1; else
	     alt:=alt+1;
	     put("hors de portée");
	   new_line;
      end if;
      else	put("il faut déjà démarrer");
      new_line;
  end if;
    when 's' =>
      if ademarrer=true then
           if alt>0 then alt:=alt-1; else
	   put("Impossible de descendre");
	   new_line;
           end if;
      else put("il faut déjà démarrer");
      new_line;
      end if;
    when 'q' =>
      put("mise hors tension");
      new_line;
    when others => 
      put("choix incorrect");
      new_line;
  End Case;
Exit when ch='q' or alt>5;
End loop; -- l'utilisateur a choisi de quitter ou le drone est hors de portée  :ch=q ou alt>5
end drone_ada;
