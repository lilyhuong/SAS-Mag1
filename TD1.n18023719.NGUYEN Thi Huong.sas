libname lily "D:\S1 - MAG 1\SAS\TD";
/* 1. Ouvrir enquete l'emploi */
data lily.TD1;
Set lily.eec2012;
run;
data lily.TD1;
set lily.TD1;
run;
/* 2.description de l'Enquete emploi */
/* a */
proc contents data = lily.TD1;
run;
/* b */
proc means data = lily.TD1;
var age;
run;
/* c */
proc freq data = lily.TD1;
table sexe;
run;
/* 3. Emploi, chômage et niveau d'education */
/* d */
proc freq data = lily.TD1;
table acteu;
run;
/* e */
data lily.TD1;
set lily.TD1;
if acteu = 3 then delete
run;
proc freq data = lily.TD1;
table acteu;
run;
/* h  */
proc sort data = lily.TD1;
by ddipl;
run;
proc freq data = lily.TD1;
table acteu;
by ddipl;
run;
/* autre methode pour calculer */
data lily.TD1;
set lily.TD1;
if acteu = 1 then chomage = 0
if acteu = 0 then chomage = 1
run;
proc means data = lily.TD1;
var chomage;
by DDIL;
run;
/* g */
proc freq data = lily.TD1;
table ddipl;
run;
/* 4. Salaire et niveau d'éducation */
/* i */
proc means data = lily.TD1;
var salred;
run;
/* j */
data lily.TD1;
set lily.td1;
hoursmonth = (HHC * 52)/ 12;
salhor = salred /hoursmonth;
run;
proc means data = lily.td1;
var salhor;
run;
/* k */
proc sort data = lily.td1;
by ddipl;
run;
proc means data = lily.td1;
var salhor;
by ddipl;
run;


