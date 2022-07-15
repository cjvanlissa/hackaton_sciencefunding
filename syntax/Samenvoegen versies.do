/* 
Let op: deze do-file is voor eenmalig gebruik
Deze is bedoeld om de versies samen te voegen tot één hoofdbestand om de analyses te doen
Deze do-file creëert het bestand ORS_def.dta, waarmee we verdere analyses doen
*/

clear all

* Stap 1: selecteer de juist CD

** for Tom
cd "C:\Users\tomge\Populytics\Projects Populytics - Documenten\PS0108 Jonge Akademie\2. Uitvoering\4. Data en analyse\Stata"
** for


/* Stap 2: Hernoemen variabelen in twee versies

Dit doen we voor elke versie apart, omdat de twee versies ieder verschillende variabelennamen hebben, die we hetzelfde willen maken.
In elke versie maken we ook een variabele aan die de versie identificeert
*/

** Versie 1

import excel "..\Data\Laatste uitdraai\v1.xlsx", sheet("Worksheet") firstrow case(lower)

save "temp1.dta", replace

gen versie = "1"

do "Hernoemen_v1.do"

save "temp1.dta", replace

** Versie 2

clear

import excel "..\Data\Laatste uitdraai\v2.xlsx", sheet("Worksheet") firstrow case(lower)

save "temp2.dta", replace

gen versie = "2"

do "Hernoemen_v2.do"

save "temp2.dta", replace

** Versie 3

clear

import excel "..\Data\Laatste uitdraai\v3.xlsx", sheet("Worksheet") firstrow case(lower)

save "temp3.dta", replace

gen versie = "3"

do "Hernoemen_v3.do"

save "temp3.dta", replace


/* Stap 3: Samenvoegen versies
Hier voegen we de versies samen. Omdat hiervoor alle variabelen gelijke namen hebben gekregen in de twee versies, kunnen we ze nu goed appenden.

*/
use "temp1.dta"

append using "temp2.dta", force
append using "temp3.dta", force

/* Stap 4: Toevoegen labels
Pas nu voegen we de labels toe, zodat we die alleen maar aan de nieuwe variabelennamen hoeven te koppelen

*/
do "Labels.do"


* Stap 6: OPSLAAN ALS NIEUW BESTAND en temp-bestanden verwijderen

save "DJA_def.dta", replace

erase "temp1.dta"

erase "temp2.dta"

erase "temp3.dta"


