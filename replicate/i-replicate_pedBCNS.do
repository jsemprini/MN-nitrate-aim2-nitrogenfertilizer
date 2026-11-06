clear all

use  "C:\Users\jsemprini\OneDrive - Des Moines University\2-External-Collab\10-FRDC\2-Nitrogen\MN_nitrogen_infantBCNS.dta"

drop id 

egen id=group(year)

cd "C:\Users\jsemprini\OneDrive - Des Moines University\2-External-Collab\10-FRDC\2-Nitrogen\1-replicate-results"

log using "mylog-mort-MN.log", replace

***summary****
sum pedpop pedbcn pedbcrate population rate total_n lag2_total lag_total, det

****Association between 1 SD increase in nitrogen and P(infant BCNS in county****
xtgee infant lagtotal_std i.id [fw=pop] , family(binomial 1) link(probit) exposure(pedpop) corr(independent) vce(robust) 
margins , dydx(lagtotal_std)

log close



