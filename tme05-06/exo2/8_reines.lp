#hide pos/1. 
#const n =8 .
pos(1..n).


%question 1
1{queen(I,J):pos(J)}1 :- pos(I).

%question2 pour n = 8, 
:- queen(I1,J), queen(I2, J), I1 != I2, pos(I1), pos(I2), pos(J).

%question3 - pour n = 8 , 92 solutions
:- queen(I1,J1), queen(I2, J2), pos(I1;J1;I2;J2), I1 - I2 == J1 - J2, I1 != I2, J1 != J2.
:- queen(I1,J1), queen(I2, J2), pos(I1;J1;I2;J2), I1 - I2 == J2 - J1, I1 != I2, J1 != J2.

%question4

queen(1,1).

%Answer: 1
%queen(1,1) queen(8,5) queen(7,2) queen(6,4) queen(5,7) queen(4,3) queen(3,8) queen(2,6) 
%Answer: 2
%queen(1,1) queen(8,3) queen(7,5) queen(6,2) queen(5,8) queen(4,6) queen(3,4) queen(2,7) 
%Answer: 3
%queen(1,1) queen(8,4) queen(7,2) queen(6,7) queen(5,3) queen(4,6) queen(3,8) queen(2,5) 
%Answer: 4
%queen(1,1) queen(8,3) queen(7,6) queen(6,4) queen(5,2) queen(4,8) queen(3,5) queen(2,7) 

%question5 : mêmes solutions, car si il y a une reine en position (1,1),
%il n'y en aura pas en position (4,4) (contraintes diagonales)