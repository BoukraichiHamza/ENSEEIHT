--Hamza BOUKRAICHI GROUPE H
--Programme puissance4


With text_io; 
use text_io;
with ada.integer_text_io;
use ada.integer_text_io;

Procedure puissance4 is
  --===========================================================================
  ----------------Declarations des constantes----------------------------------

  M_MIN : CONSTANT INTEGER := 4;    (* taille minimum d'un alignement de pions *)
  N_MAX : CONSTANT INTEGER := 7;    (* taille max de la grille *)
  
  --===========================================================================
  -------------------Declarations de types-------------------------------------
  
  Type SYMBOLE is (LIBRE, BLEU, ROUGE); (* contenu d'une case de la grille *)
  Type GRILLE is ARRAY (1..N_MAX, 1..N_MAX) of SYMBOLE  (* un GRILLE *)
  Type JOUEUR is (JBLEU, JROUGE)      (* deux joueurs seulement *)
  Type ETAT_JEU is (EN_COURS, GAGNE, NUL)

  --===========================================================================
  -----------Declarations des sous programmes----------------------------------
  
  --===========================================================================
  --Procedure initialiser_jeu
  --Procedure qui initialise le tableau du jeu
  --Paramètres
    --Fgrille : GRILLE : R; : la grille du jeu à initialiser
    --Fn : INTEGER : R; Taille réelle de la grille
    --Fm : INTEGER :R; Raille minimum d'un alignement
    --Fle_joueur : JOUEUR: R; Le joueur qui commence le jeu
  --Postconditions : Toutes les cases de la grille sont intialisées à LIBRE
    -- M_MIN<=Fm<=Fn<=N_MAX


  --===========================================================================
    
  --===========================================================================
  --Procedure afficher_jeu
  --Procedure qui affiche la grille en cours
  --Paramètres
    --Fgrille : GRILLE : D; : la grille du jeu à afficher
    --Fn : INTEGER : D; Taille réelle de la grille
    --Fle_joueur : JOUEUR: D; Le prochain joueur à jouer
   --Préconditions : M_MIN<=Fn<=N_MAX 

  --===========================================================================
  --Procedure jouer
  --Procedure qui effectue une manche du jeu
    --Parmètres
      --Fgrille : GRILLE : D/R; : la grille du jeu actuelle
      --Fn : INTEGER : D; Taille réelle de la grille
      --Fm : INTEGER :D; Taille minimum d'un alignement
      --Fle_joueur : JOUEUR: D/R; Le joueur à qui est le tour
      --Fl_etat : ETAT_JEU : D/R; l'état du jeu actuel
    --Préconditions : M_MIN<=Fm<=Fn<=N_MAX et Fl_etat=ENCOURS
    --Postconditions : 

  --===========================================================================
  
  --===========================================================================
  --Procedure afficher_fin_de_jeu
  
  
  --===========================================================================


  --===========================================================================
  -----------------Declarations des variables----------------------------------
  la_grille : GRILLE;   (* espace de jeu *)
  le_n : INTEGER;       (* dimension reelle de la grille. Entre M_MIN et N_MAX *)
  le_m : INTEGER;       (* La taille min d'un alignement *)
  le_joueur : JOUEUR;   (* le joueur courant *)
  l_etat : ETAT_JEU;    (* l'etat courant du jeu *)


  --===========================================================================
  ---------------------Programme Principal-------------------------------------
BEGIN
            --initialiser le jeu--
  initialiser_jeu(la_grille, le_n, le_m, le_joueur); 

  
               --jouer--
  LOOP
        
    --afficher la GRILLE et le joueur courant--
     afficher_jeu(la_grille, le_n, le_joueur)
        
    --le joueur courant joue--
   jouer(la_grille, le_n, le_m, l_etat, le_joueur);
 EXIT WHEN l_etat /= EN_COURS;   --partie terminee  l_etat /= EN_COURS--
 END LOOP;

  --affichage de fin de partie--
  afficher_fin_de_jeu(la_grille, le_n, le_joueur, l_etat);

END puissance4;
  --===========================================================================
