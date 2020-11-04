libname lily3 "D:\S1 - MAG 1\SAS\TD";
data lily3.td3;
set lily3.eec2012_1;
run;
/* 2.a */
/* salaires moyenne par genre */
proc sort data = lily3.td3;
by sexe;
run;
proc means data = lily3.td3;
by sexe;
var salred;
run;
/* les hommes ont un salaire moyen de 2073 euros et les femmes de 1562 euros par mois */
/* 2.b */
proc reg data = lily3.td3;
model salred = fem;
run;
/* beta: -511,.. la diff entre salaire moyenne entre les hommes et les femme
alpha: 2073, 87503: salaires des hommes
dit autrement, les femmes touchent en moyenne 511 euros de moins que les hommes par mois
le coefficent beta est significatif à 5%, puis que la t -stat (-49,14) est supérieur en valeur
absolue à 1,96
Salaire moyen des femmes = 2073 - 511 = 1562 
*/
/* 2c */
proc reg data = lily3.td3;
model salred = fem hom;
run;
/* il y a colinéarité, puisqu'on peut écrire fem = 1 - hom */
/* 2d */
proc reg data = lily3.td3;
model lsalred = fem;
run;
/* alpha2: la moyenne du log du salaire des hommes
beta2 = -0,29: les femmes touchent en moyenne beta2 * 100 = 29% de moins 
que les hommes par mois
le cofficent beta2 est significatif à 5% 
*/
/* 3.Facteurs explicatives */
/* 3e */
proc sort data = lily3.td3;
by sexe;
run;
proc means data = lily3.td3;
var tp;
by sexe;
run;
/* 6% d'hommes travaillent à temps partiel et 31% de femmes trvaillent
à temps partiel dans notre échantillon */
/* 3f */
proc reg data = lily3.td3;
model lsalred = fem tp;
run;
/* alpha3 = la moyenne du lod du salaire des hommes qui travaillent
à temps complet
alpha3 = E(log salaire ! fem = 0, tp = 0)
log salaire = alpha3 + beta3 + mu3 tp + epsilon
E(log salaire) = E(alpha3 + beta3 + mu3 tp + epsilon)
				alpha3 + beta3 fem + mu3 tp
E (log salaire § fem = 0, tp = 0) = alpha3

*/
/* 3g */
/* beta3 = -0,11 les femmes touchent en moyenne 11% de moins que les hommes 
conditionellement au femmes fait de travailler à temps partiel ou à temps complts
log salaire - mu3 tp = alpha3 + beta3 fem + epsilon

/* 3h */
/* mu3 = -0,75: les individus qui travillent à temps partiel vont toucher en moyenne 75%
de moins que les individus qui travallent à temps complet, qu'ils soient 
des hommes ou des femmes
 /*3i
 - la moyenne du log du salaire des homme qui travaillent à temps complet: alpha3
E(log salaire/fem = 0, tp = 0) = alpha 3
7,5

- La moyenne du log salaire des femmes qui trvaillent à temps partiel
log salaire = alpha3 + beta3 fem + mu3 tp epsilon
E(log salaire) = alpha3 + beta3 fem + mu3 tp
E(log salaire ! fem = 1, tp = 1) = alpha3 + beta3 fem + mu3 tp = 7,5 - 0,11 - 0,74

- Ecart de moyenne de log salaire entre un homme qui travaile à temps complet
et une femme qui travaille à temps partiel = 7,5 - (7,5 - 0,11 - 0,74) = 0,85
= beta2 + mu3

- Une femme qui travaille à temps partiel touche 85% de moins qu'un homme qui trvaille 
à temps complet
*/
 
/*3j */
proc reg data = lily3.Td3;
model lsalred = fem lhhc;
run;
/* 
- alpha4 = 3,83
log salaire = alpha4 + beta4 + mu4 log hours + epsilon
E(log salaire ! fem = 0, log hours = 0) = alpha 4
la moyenne du log du salaire des hommes pour qui log  hours  = 0
(donc qui travaillent 1 heure)

- beta4 = -0,42
les femmes gagnent en moyenne 12% de moins que les hommes par mois, 
conditionnellement qu nombre d'heure travaillés

- mu4 = 1
lorsque le nbr d'heure travaillé des augument de 1% le salaire augement 
en moyenne de (mu4)% (1%) (conditionnelement au fait d'etre une femme ou un homme)
*/

/*3k*/
proc reg data = lily3.td3;
model lsalred = fem lhhc brevet cap_bep bac bac2 bac2sup;
run;
/*
- alpha5 = E(log salaire ! fem = 0, lhhc = 0, brevet = 0, cap_bep = 0, bac = 0,
bac2 = 0, bac2sup = 0) = 3,9
log de salaire moyenne d'un homme qui travaille 1h et qui n'a pas de diplome

- mu5 = 0,93
lorsque le nbr d'heure travaillées va augmenter de 1%, alors le salaire va 
augmenter en moyenne de 0,93% (touts choses égales par ailleurs)

- beta5 = -0,15
Les femmes touchent en moyenne 15% de moisn que les hommes par mois (toutes choses 
par ailleurs ou dit autrement conditionnellement  nbr d'heure trvaillées et 
au niveau d'éducation)
Dit autrement, si je compare des hommes et des femmmes à niveau d'éducatio, équivalent
et qui travaillent le meme nbr d'heure, alors on observait des différeces 
de salaires et ces hommes et ces femmes 15%

- brevet = 0,08
par rapport à individus qui n'a pas de diplome, un individus qui a le brevet gagne
en moyenne 8% en plus
*/

/*3l */
proc reg data = lily3.td3;
model lsalred = fem lhhc brevet cap_bep bac bac2 bac2sup
 ancan cdi manag agr indus constr pub;
 run;
 /* 
- beta6 = -0,145
 Les femmes gagnent en moyenne 14,5% de moins que les hommes par mois (toutes chose
 égales par  14,5% = part expliquées 
