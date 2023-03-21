%question1

#hide meme_carre/4
#hide 
pos(0..8).
chiffre(1..9).
1{case(I,J,N): chiffre(N)}1:- pos(I;J).


meme_carre(I1, J1, I2, J2) :- I1/3 ==I2/3, J1/3==J2/3, pos(I1; J1; I2; J2).

%On n'a qu'un seul occurence d'un chiffre dans une ligne
:- case(I,J1,N), case(I, J2, N), J1 != J2, pos(I;J1;J2), chiffre(N).

%On n'a qu'un seul occurence d'un chiffre dans une colonne
:- case(I1,J,N), case(I2, J, N), I1 != I2, pos(I1;I2;J), chiffre(N).

%On n'a qu'un seul occurence d'un chiffre dans une carré
:- case(I1,J1,N), case(I2, J2, N), meme_carre(I1, J1, I2, J2), pos(I1; I2; J1; J2), I1 != I2, J1 != J2.