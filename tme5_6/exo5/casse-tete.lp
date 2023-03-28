#hide nationalite/1.
#hide animal/1.
#hide coul/1.
#hide pos/1.
#hide boisson/1.
#hide cigarettes/1.

%#hide a_anim/2.
#hide a_maison_coul/2.
#hide a_maison_pos/2.
#hide a_boisson/2.
#hide a_cigs/2.

#hide a_gauche/2.
#hide a_droite/2.
#hide a_cote/2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Unaire %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nationalite(britannique;suedois;danois;norvegien;allemand).

animal(chien;oiseaux;chat;chevaux;poissons).

coul(rouge;verte;blanche;jaune;bleue).
pos(1..5).

boisson(the;cafe;lait;biere;eau).

cigarettes(pallmall;dunhill;blend;bluemaster;princess).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Binaires %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

1{a_anim(N, A) : animal(A)}1 :- nationalite(N).
:- a_anim(N1, A), a_anim(N2, A), N1 != N2.


1{a_maison_coul(N, A) : coul(A)}1 :- nationalite(N).
1{a_maison_pos(N, A) : pos(A)}1 :- nationalite(N).
:- a_maison_coul(N1, C), a_maison_coul(N2, C), N1 != N2.
:- a_maison_pos(N1, C), a_maison_pos(N2, C), N1 != N2.

1{a_boisson(N, A) : boisson(A)}1 :- nationalite(N).
:- a_boisson(N1, B), a_boisson(N2, B), N1 != N2.

1{a_cigs(N, A) : cigarettes(A)}1 :- nationalite(N).
:- a_cigs(N1, C), a_cigs(N2, C), N1 != N2.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Utils %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a_gauche(P1,P2):- pos(P1), pos(P2), P2-P1 == 1.
a_droite(P1, P2):- pos(P1), pos(P2), P1-P2 == 1.
a_cote(P1, P2) :- a_gauche(P1, P2).
a_cote(P1, P2) :- a_droite(P1,P2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Faits de l'enoncé %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1
a_maison_coul(britannique, rouge).
a_anim(suedois, chien).
a_boisson(danois, the).

:- a_maison_coul(N1, verte), a_maison_pos(N1, P1), 
   a_maison_coul(N2, blanche), a_maison_pos(N2, P2),
   not a_gauche(P1, P2).

:- a_maison_coul(N, verte), not a_boisson(N, cafe).
%:- a_maison_coul(N1, verte), a_boisson(N2, cafe), N1 != N2.

:- a_cigs(N1, pallmall), a_anim(N2, oiseaux), N1 != N2.

:- a_maison_coul(N1, jaune), a_cigs(N2, dunhill), N1 != N2.     % On a 300 672 modèles 

:- a_maison_pos(N1, 3), a_boisson(N2, lait), N1 != N2.          % On a 55 584 modèles.
a_maison_pos(norvegien, 1).                                     % On a 11 232 modèles.

:- a_cigs(N1, blend), a_maison_pos(N1, P1),                     % On a 3 280 modèles.
   a_anim(N2, chat), a_maison_pos(N2, P2),
   not a_cote(P1, P2).

:- a_anim(N1, chevaux), a_maison_pos(N1, P1),                   % On a 1 068 modèles.
   a_cigs(N2, dunhill), a_maison_pos(N2, P2),
   not a_cote(P1, P2).

:- a_cigs(N1, bluemaster), a_boisson(N2, biere), N1 != N2.      % On a 220 modèles.
a_cigs(allemand, princess).                                     % On a 41 modèles.

:- a_maison_pos(norvegien, P1), a_maison_pos(N, P2),
   a_maison_coul(N, bleue), not a_cote(P1, P2).                 % On a 1 modèle.

:- a_cigs(N1, blend), a_maison_pos(N1, P1),
a_boisson(N2, eau), a_maison_pos(N2, P2),                        
not a_cote(P1, P2).

%C'est l'allelemand qui possède des poissons!


