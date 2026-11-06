clear all

use  "C:\Users\jsemprini\OneDrive - Des Moines University\2-External-Collab\10-FRDC\2-Nitrogen\MN_nitrogen_infantBCNS.dta"

drop id _merge

egen id=group(year)

rename pop full_pop

drop rate

merge 1:1 fips year using "C:\Users\jsemprini\OneDrive - Des Moines University\2-External-Collab\10-FRDC\2-Nitrogen\raw-seer\ayacan0519.dta"

gen ayacan0519=0
replace ayacan0519=1 if rate>0


cd "C:\Users\jsemprini\OneDrive - Des Moines University\2-External-Collab\10-FRDC\2-Nitrogen\2-extend-results"

log using "mylog-mort-MN-ayacan0519.log", replace

***summary****
sum rate ayacan0519, det

****Association between 1 SD increase in nitrogen and P(aya can 5-19 age cancer in county****
xtgee ayacan0519 lagtotal_std i.id [fw=full_pop] , family(binomial 1) link(probit) exposure(pop) corr(independent) vce(robust) 
margins , dydx(lagtotal_std)

***association between 1 SD increase in nitrogen and change in aya (5-19 incidence rate) - continuous rate variable
xtgee rate lagtotal_std i.id [fw=full_pop] ,  exposure(pop) corr(independent) vce(robust) 

margins , dydx(lagtotal_std)

display 0.5273892/1.859484

log close



