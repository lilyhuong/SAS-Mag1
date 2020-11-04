libname lily 'D:\S1 - MAG 1\SAS\TD';
data lily.td4;
set lily.WVS;
run;
data lily.td4;
set lily.td4;
if sex = 1 then femme = 0;
if sex = 2 then femme = 1;
run;
/* 2b */
data lily.td4;
set lily.td4;
if marital  = 1 or marital =  2 then married = 1;
else married = 0;
run;
/*
data lily.td4;
set lily.td4;
drop married;
run;
 /* 2c */
data lily.td4; set lily.td4;
if employ = 1 or employ = 2 or employ = 3 then employed = 1;
else employed = 0;
run;

/* 2d */
data lily.td4;
set lily.td4;
age2 = age * age;
run;
 /* 2e */
data lily.td4;
set lily.td4;
log_income = log(income);
run;
 /* alternative 
data lily.td4;
set lily.td4;
if employ = 1 or employ = 2 or employ = 3 then employed = 1;
else employed = 0;
age2 = age * age;
log_income = log(income);
run;
/ 3f */
proc means data = lily.td4;
var satislife;
run;
 /* 3g */
ods  rtf file = 'D:\S1 - MAG 1\SAS\TD\graph.rtf';
proc sgplot data = lily.td4;
vbar satislife;
title "Satisfaction dans la vie";
run;
ods rtf close;

/* 3h */
ods  rtf file = 'D:\S1 - MAG 1\SAS\TD\graph.rtf';
proc reg data = lily.td4;
model satislife = log_income;
run;
ods rtf close;

/* 
- satislife = 6,17 + 0,68 log_income + epsilon
- beta0 = 6,17
beta0 = E(Satislife ! log_income = 0) = la satilife moyenne quand log_income vaut 0
c'est à dire quand income = 1 
- beta1 = 0,68
Une augmentation de 100% du revenu (= double) va entrainer une augmentation de satisfaction de
0,68/100 = 0,0068 points
Une augmentation de 100% revenu
 Explique pourquoi on divise ?
Log salaire = alpha + beta femme + epsilo,
entre une femme diminiue le salaire de beta * 100% par rapport à un homme

satisfaction = alpha + beta log salaire + epsilon
une augmentation de 1% du salaire augmente la satifaction de beta/100 unités
 /* 3i */
ods rtf file = 'D:\S1 - MAG 1\SAS\TD\graph.rtf'; 
proc reg data = lily.td4;
model satislife = Log_income Employed married educ children age age2 femme;
run;
ods rtf close;
/* 
- beta1 = 0,64du revenu
Une augmentation de 1% du revenu va augmenter la satisfaction de 0,0064 points
(Toutes choses égales par ailleurs, cad conditionnellement au status dans emploi,
au niveau d'éducation, à l'age, etc)
- beta2 = 0,16
Etre en emploi augmente la satisfaction dans la vie de 0,16 points par rapport à etre 
sans emploi
- beta5 = -0,06
Avoir un enfant supplémentaire réduit la satisfaction dans la vie de 0,66 points
-beta8 = 0,21
Etre une femme augmente la satisfaction de 0,21 points par rapport à un homme
*/
/* 4.A quelle périod de la vie est on le plus heureux ?
- beta6 = -0,037
- beta7 = 0,0005
sattislife = .....beta6 age + beta7 age2+...
d(E(Satislife ! x)) / d(age) = beta6 + beta7 * 2 * age = -0,037 + 0,0005 * 2 * age

age = 0 > effet marginal de l'age = -0,037
age = 10 > effet marginal de l'age = -0,037 + 0,0005 * 2 * 10
age = 100 > effet marginal de l'age = -0,037 + 0,0005 * 2 * 100
*/
 proc sort data = lily.td4;
 by age;
 run;
 proc means data = lily.td4;
 var satislife; 
 by age;
 output out = lily.newdatabase mean = mean_satisfaction;
 run;
 proc sgplot data = lily.newdatabase;
 scatter y = mean_satisfaction x = age;
 reg y = mean_satisfaction x = age / degree = 2;
 title "satisfaction au cours de la vie";
 run;
 /* Exercice 5 */
 /* 5n */
proc reg data = lily.td4;
model satislife = log_income employed married educ children age age2;
where femme = 1;
run;
proc reg data = lily.td4;
model satislife = log_income employed married educ children age age2;
where femme = 0;
run;
/*
Par comparer les coefficient, 
il y a des effets différence entre les hommes 
les femmes*/
/* 5o */
data lily.td4; set lily.td4;;
Emp_fem = employed * femme;
run; 
/* 5p */
proc reg data = lily.td4;
model satislife = log_income employed emp_fem married educ children age age2 femme;
run;
/* 
- beta2 = 0,24424
Mesure l'effet: Etre emploi augmente la satisfaction dans la vie de 0,24424 points
points rapport sans emploi pour les hommes
le coefficent beta2 est significatif à 5% et 10%
- beta3 = - 0,1187
Mesurer directement la différence de satisfaction dans la vie d'etre emploi 
entre les hommes et les femmes est 11,87 points
Autrement dit, etre une femme avec emploi a le niveau de satisfaction moins élevés
de 11,87 points par rapport à un homme
le coefficent beta3 n'est pas significatif à 5% et 10%
-beta9 = 0,29
Entre une femme sans emploi augmente la satisfaction dans la vie de 0,29 points par rapport 
à un homme
Le coefficent bet9a est significatif à 5% et 10%
*/
/* 5q */
data lily.td4; set lily.td4;;
mar_fem = married * femme;
run;
/* 5r */
proc reg data = lily.td4;
model satislife = log_income employed married mar_fem educ children age age2 femme;
run;
/* 
-beta4 = 0.12931
Mesurer directement la différence de satisfaction dans la vie d'etre married 
entre les hommes et les femmes est 0,12931 points
Entre une femme sans married augmente la satisfaction dans la vie de
0,12931 points par rapport à un homme
le coefficent beta4 n'est pas significatif à 5%
*/
