%IAMSI - Sorbonne Université
%Yona MELLUL - 3800646

#hide arete/2.
#hide sommet/1.
#const n  = 4.

couleur(1..n).

% Chaque sommet n'est associé qu'à une seule couleur.
1{a_couleur(S,C) : couleur(C)}1 :- sommet(S).

% Deux sommets adjacents (reliés par une arête), ne peuvent pas avoir la même couleur.
:- arete(I,J), a_couleur(I, C), a_couleur(J,C), I!=J.

%pour le graphe de l'énoncé, il faut au minimum 4 couleurs. 
%pour le graphe chainé, il faut minimum 2 couleurs (c'est logique, il suffit d'alterner les couleurs).