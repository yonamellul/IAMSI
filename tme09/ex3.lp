% IAMSI - Sorbonne Université
% Yona MELLUL - 3800646


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HYPOTHESE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% On a considéré qu'à partir d'un moment où une cargaison est chargée dans
%un avion elle ne se situe plus dans l'aeroport où elle se trouvait.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% RESULTATS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Il faut au moins 12 étapes (actions) pour atteindre les buts de l'exercice
% Voici un des 5940 modèles trouvés par clingo:

%Answer: 5940
%action(charger(c3,a2,teg),0)
%action(charger(c1,a1,teg),1)  
%action(voler(a2,teg,bar),2)
%action(decharger(c3,a2,bar),3) 
%action(voler(a1,teg,bar),4) 
%action(voler(a2,bar,teg),5) 
%action(charger(c2,a2,teg),6) 
%action(voler(a2,teg,bar),7)
%action(decharger(c2,a2,bar),8) 
%action(voler(a2,bar,cdg),9) 
%action(decharger(c1,a1,bar),10) 
%action(voler(a1,bar,cdg),11) 

%SATISFIABLE


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HIDE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

#hide cargaison/1.
#hide avion/1.
#hide aeroport/1.
#hide time/1.
#hide holds/2.
#hide -holds/2.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FAITS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cargaison(c1; c2; c3).
avion(a1; a2).
aeroport(teg; cdg; bar).
#const last_time = 11.
time(0..last_time).


%%%%%%%%%%%%%%%%%%%%%%%%% ETATS INITIALS DES FLUENTS %%%%%%%%%%%%%%%%%%%%%%%%%

holds(vide(a1), 0).
holds(vide(a2), 0).
holds(situe(c1, teg), 0).
holds(situe(c2, teg), 0).
holds(situe(c3, teg), 0).
holds(situe(a1, teg), 0).
holds(situe(a2, teg), 0).


%%%%%%%%%%%%%%%%%%%%%%%%%%% REPRESENTATION DES BUTS %%%%%%%%%%%%%%%%%%%%%%%%%%%

%% LES 3 cargaisons doivent se trouver a barajas a l'etat final

:- not holds(situe(c1, bar), last_time).
:- not holds(situe(c2, bar), last_time).
:- not holds(situe(c3, bar), last_time).

%% Les 2 avions a CDG a l'etat final

:- not holds(situe(a1, cdg), last_time).
:- not holds(situe(a2, cdg), last_time).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PRE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Charger

:- action(charger(CAR, AV, AER), T), not holds(vide(AV), T), cargaison(CAR), avion(AV), aeroport(AER), time(T) .
:- action(charger(CAR, AV, AER), T), not holds(situe(AV, AER), T), cargaison(CAR), avion(AV), aeroport(AER), time(T).
:- action(charger(CAR, AV, AER), T), not holds(situe(CAR, AER), T), cargaison(CAR), avion(AV), aeroport(AER), time(T).

% Decharger

:- action(decharger(CAR, AV, AER), T), not holds(dans(CAR, AV), T), cargaison(CAR), avion(AV), aeroport(AER), time(T).
:- action(decharger(CAR, AV, AER), T), not holds(situe(AV, AER), T), cargaison(CAR), avion(AV), aeroport(AER), time(T).
%:- action(decharger(CAR, AV, AER), T), not holds(situe(CAR, AER), T), cargaison(CAR), avion(AV), aeroport(AER), time(T).

% Voler

:- action(voler(AV, AER1, AER2), T), not holds(situe(AV, AER1), T), cargaison(CAR), avion(AV), aeroport(AER1; AER2), time(T).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ADD %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

holds(dans(CAR, AV), T+1):- action(charger(CAR,AV,AER), T),  time(T), time(T+1),
                            cargaison(CAR), avion(AV), aeroport(AER). 

holds(vide(AV), T+1) :- action(decharger(CAR, AV, AER), T), time(T),  time(T+1),
                            cargaison(CAR), avion(AV), aeroport(AER). 

holds(situe(CAR, AER), T+1):- action(decharger(CAR, AV, AER), T), time(T),  time(T+1),
                            cargaison(CAR), avion(AV), aeroport(AER). 


holds(situe(AV, AER2), T+1) :- action(voler(AV, AER1, AER2), T), time(T),  time(T+1),
                            cargaison(CAR), avion(AV), aeroport(AER1; AER2).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DEL %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

-holds(vide(AV), T+1):- action(charger(CAR,AV,AER), T),  time(T), time(T+1),
                            cargaison(CAR), avion(AV), aeroport(AER). 

-holds(situe(CAR, AER), T+1):- action(charger(CAR,AV,AER), T),  time(T), time(T+1),
                            cargaison(CAR), avion(AV), aeroport(AER). 

-holds(dans(CAR, AV), T+1):- action(decharger(CAR,AV,AER), T),  time(T), time(T+1),
                            cargaison(CAR), avion(AV), aeroport(AER). 

-holds(situe(AV, AER1), T+1) :- action(voler(AV, AER1, AER2), T), time(T),  time(T+1),
                            cargaison(CAR), avion(AV), aeroport(AER1; AER2).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INERTIE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


holds(vide(AV), T+1) :- holds(vide(AV), T), not -holds(vide(AV), T+1), avion(AV), time(T), time(T+1).
-holds(vide(AV), T+1) :- -holds(vide(AV), T), not holds(vide(AV), T+1), avion(AV), time(T), time(T+1).

holds(dans(CAR, AV), T+1) :- holds(dans(CAR, AV), T), not -holds(dans(CAR, AV), T+1), cargaison(CAR), avion(AV), time(T), time(T+1).
-holds(dans(CAR, AV), T+1) :- -holds(dans(CAR, AV), T), not holds(dans(CAR, AV), T+1), cargaison(CAR), avion(AV), time(T), time(T+1).

holds(situe(AV, AER), T+1) :- holds(situe(AV, AER), T), not -holds(situe(AV, AER), T+1), aeroport(AER), avion(AV), time(T), time(T+1).
-holds(situe(AV, AER), T+1) :- -holds(situe(AV, AER), T), not holds(situe(AV, AER), T+1), aeroport(AER), avion(AV), time(T), time(T+1).

holds(situe(CAR, AER), T+1) :- holds(situe(CAR, AER), T), not -holds(situe(CAR, AER), T+1), cargaison(CAR), aeroport(AER), time(T), time(T+1).
-holds(situe(CAR, AER), T+1) :- -holds(situe(CAR, AER), T), not holds(situe(CAR, AER), T+1), cargaison(CAR), aeroport(AER), time(T), time(T+1).


%%%%%%%%%%%%%%%%%%%%%%%%%% SPECIFICATION DES CONTRAINTES %%%%%%%%%%%%%%%%%%%%%%%%%%

:- holds(situe(AV, AER1), T), holds(situe(AV, AER2), T), AER1 != AER2, avion(AV), aeroport(AER1;AER2), time(T).
:- holds(dans(CAR1, AV), T), holds(dans(CAR2, AV), T), CAR1 != CAR2, avion(AV), cargaison(CAR1; CAR2), time(T). 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% REGLES DE GENERATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

0{ action(charger(CAR1, AV1, AER1), T): cargaison(CAR1): avion(AV1): aeroport(AER1),
action(decharger(CAR2, AV2, AER2), T): cargaison(CAR2): avion(AV2): aeroport(AER2),
action(voler(AV3, AER3, AER4), T): avion(AV3): aeroport(AER3; AER4)
}1 :- time(T), T<last_time.


