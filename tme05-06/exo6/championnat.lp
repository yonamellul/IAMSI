#const ne = 5.
#const nj = 9.

#hide equipe/1.
#hide jour/1.

equipe(1..ne).
jour(1..nj).

%match(J, E1, E2) == le jour J, E1 (a domicile) affronte E2. 

% Une equipe ne saffronte pas elle-meme.
:- match(J, E, E), jour(J).


% Chaque jour, une equipe joue au maximum une fois, que ce soit a domicile ou a lexterieur.

0{match(J, E1, E2) : equipe(E2)}1 :- equipe(E1), jour(J).
0{match(J, E1, E2) : equipe(E1)}1 :- equipe(E2), jour(J).
:- match(J, E, E1), match(J, E2, E).


% Chaque equipe rencontre 2 fois chaque equipe (1 fois à domicile, 1 fois à l'exterieur)

(ne-1){match(J, E1, E2) : jour(J): equipe(E2)}(ne-1) :- equipe(E1).
(ne-1){match(J, E2, E1) : jour(J): equipe(E2)}(ne-1) :- equipe(E1).



% 2 équipes ne s'affrontent pas 2 fois au même endroit.
:- match(J1, E1, E2), match(J2, E1, E2), J1 != J2. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% experiences %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%ù

% comme vu dans le tme4

% Pour 2 equipes il faut au minimum 2 jours, et on obtient ces modèles:

%   Answer: 1
%   match(2,2,1) match(1,1,2) 
%   Answer: 2
%   match(1,2,1) match(2,1,2) 
%   SATISFIABLE

% Pour 3 equipes, il faut au minimun 6 jours, et on obtient 720 modeles:

%   Answer: 720
%   match(2,3,1) match(1,3,2) match(4,2,1) match(3,2,3) match(6,1,2) match(5,1,3) 
%   SATISFIABLE

% Pour 4 equipes, il faut au minimun 6 jours, et on obtient 5760 modèles:

%   Answer: 5760
%   match(5,4,1) match(4,4,3) match(3,4,2) match(3,3,1) match(2,3,4) match(1,3,2) 
%   match(6,2,4) match(5,2,3) match(2,2,1) match(6,1,3) match(4,1,2) match(1,1,4) 
%   SATISFIABLE

% C'est tout ce que j'avais pu tester avec le solveur glucose, le reste prenait
% trop de temps. J'en ai profité donc pour tester un peu plus ici.

% Pour 5 équipes, il faut au minimum 10 jours. voici un modèle:

%   Answer: 2173756
%   match(10,5,4) match(8,5,1) match(4,5,3) match(3,5,2) match(9,4,1) 
%   match(6,4,5) match(5,4,3) match(2,4,2) match(9,3,2) match(7,3,4) 
%   match(2,3,5) match(1,3,1) match(8,2,3) match(7,2,5) match(6,2,1) 
%   match(1,2,4) match(10,1,2) match(5,1,5) match(4,1,4) match(3,1,3) 
