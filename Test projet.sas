libname lily "D:\S1 - MAG 1\SAS\projet";
data lily.test;
set lily.eec2012;
run;
proc contents data =  lily.test;
run;
data lily.test; set lily.test;
log_salred = log(salred);
if sexe = 1 then Femme = 0;
if sexe = 2 then Femme = 1;
if ddipl = 1 then Bac_plus2 = 1;
else Bac_plus2 = 0;
if ddipl = 3 then Bac2 = 1;
else bac2 = 0;
if ddipl = 4 then Bac = 1;
else Bac = 0;
if ddipl = 5 then Cap_Bep = 1;
else Cap_Bep = 0;
if ddipl = 6 then Brevet = 1;
else Brevet = 0;
if ddipl = 7 then NoDiplome = 1;
if ddipl = 1 or ddipl = 3 or ddipl = 4 or ddipl = 5 or ddipl = 6 then NoDiplome = 0;
if fonctc = 1 then Fonctc_index = 1;
if fonctc = 2 then Fonctc_index = 2;
if fonctc = 3 then Fonctc_index = 3;
if fonctc = 4 then Fonctc_index = 4;
if fonctc = 5 then Fonctc_index = 5;
if fonctc = 6 then Fonctc_index = 6;
if fonctc = 7 then Fonctc_index = 7;
if fonctc = 8 then Fonctc_index = 8;
if fonctc = 9 then Fonctc_index = 9;
if fonctc = 10 then Fonctc_index = 10;
if cohab = 1 then statut = 1;
else statut = 0;
run;
proc contents data =  lily.test;
run;
proc means data =  lily.test;
var salred;
run;
proc corr data =  lily.test;
var age Femme ancentr hhc Fonctc_index statut Bac Bac_plus2 Bac2 Brevet Cap_Bep salred;
run;
proc reg data =  lily.test;
model log_salred = Femme age ancentr hhc Fonctc_index statut Bac Bac_plus2 Bac2 Brevet Cap_Bep ;
run;