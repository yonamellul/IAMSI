#hide arete/2.
#hide sommet/1.
%#hide couleur/2.
#const n  = 4.

couleur(1..n).

1{a_couleur(S,C) : couleur(C)}1 :- sommet(S).
:- arete(I,J), a_couleur(I, C), a_couleur(J,C), I!=J.

%pour le graphe de l'enonce il faut au minimum 4 couleurs. 
%pour le graphe chainé, il faut minimum 2 couleurs (c'est logique, on alterne les couleurs)