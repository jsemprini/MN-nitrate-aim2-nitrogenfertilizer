clear all

use  "C:\Users\jsemprini\OneDrive - Des Moines University\2-External-Collab\10-FRDC\2-Nitrogen\MN_nitrogen_infantBCNS.dta"

drop id _merge

egen id=group(year)

rename pop full_pop

drop rate

merge 1:1 fips year using "C:\Users\jsemprini\OneDrive - Des Moines University\2-External-Collab\10-FRDC\2-Nitrogen\raw-seer\pedcan04.dta"

gen pedcan04=0
replace pedcan04=1 if rate>0


cd "C:\Users\jsemprini\OneDrive - Des Moines University\2-External-Collab\10-FRDC\2-Nitrogen\2-extend-results"

log using "mylog-mort-MN-pedcan04.log", replace

***summary****
sum rate pedcan04, det

****Association between 1 SD increase in nitrogen and P(ped can 0-4 age cancer in county****
xtgee pedcan04 lagtotal_std i.id [fw=full_pop] , family(binomial 1) link(probit) exposure(pop) corr(independent) vce(robust) 
margins , dydx(lagtotal_std)



***association between 1 SD increase in nitrogen and change in pediatric (0-4 incidence rate) - continuous rate variable
xtgee rate lagtotal_std i.id [fw=full_pop] ,  exposure(pop) corr(independent) vce(robust) 

margins , dydx(lagtotal_std)

****relative association from mean rate 
display 0.7766183/1.50937

log close



