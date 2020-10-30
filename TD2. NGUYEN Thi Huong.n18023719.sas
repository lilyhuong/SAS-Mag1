libname lily2 "D:\S1 - MAG 1\SAS\TD";
data lily2.td2;
set lily2.covid;
run;
/*  Description de l’Enquête COVID*/
/* a */
proc contents data = lily2.td2;
run;
/* b */
proc means data = lily2.td2;
var total_cases;
run;
proc freq data = lily2.td2;
tables location;
where total_cases = 7417845;
run;
/* ou 
proc freq data = lily2.td2;
tables total_cases * location;
where total_cases = max (total_cases);
run; */
/* d */
proc sgplot data = lily2.td2;
reg x = aged_65_older y = total_deaths;
title ' Relation ';
run;
/* les payes a plus les personnes agés avoir plus de taux de morts */
/* e */
proc reg data = lily2.td2;
model total_deaths_per_million = aged_65_older;
run;
/* j */
proc reg data = lily2.td2;
model total_deaths_per_million = aged_65_older;
where continent = "Europe";
run;
/* k */
proc reg data = lily2.td2;
model total_deaths_per_million = aged_70_older;
run;
