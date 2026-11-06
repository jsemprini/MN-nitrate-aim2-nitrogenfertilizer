clear all

use  "C:\Users\jsemprini\OneDrive - Des Moines University\2-External-Collab\10-FRDC\2-Nitrogen\MN_nitrogen_infantBCNS.dta"

drop id _merge

egen id=group(year)

rename pop full_pop

drop rate

merge 1:1 fips year using "C:\Users\jsemprini\OneDrive - Des Moines University\2-External-Collab\10-FRDC\2-Nitrogen\raw-seer\eocan2049male.dta"

cd "C:\Users\jsemprini\OneDrive - Des Moines University\2-External-Collab\10-FRDC\2-Nitrogen\2-extend-results"

log using "mylog-mort-MN-eocan2049male.log", replace

***summary****
sum rate , det

***association between 1 SD increase in nitrogen and change in early-onset (20-49 incidence rate) - continuous rate variable
xtgee rate lagtotal_std i.id [fw=full_pop] ,  exposure(pop) corr(independent) vce(robust) 

margins , dydx(lagtotal_std)

display 0.8464768/12.50465

log close



