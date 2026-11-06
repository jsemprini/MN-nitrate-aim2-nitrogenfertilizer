clear all

use "C:\Users\jsemprini\OneDrive - Des Moines University\6-Student-Research\Sp26-Elective\Tanisha\2-Nitrates\i-raw\cancer_nutriets87-10.dta"

gen rate=pedbcn/pedpop

egen time=group(year)

xtset fipsno time

gen lag_farm=L.meanfarm_sqmi
gen lag_non=L.meannon_sqmi

gen infantbcsn=0
replace infantbcsn=1 if pedbcn>0 & pedbcn!=.

sum infant

replace farmn=0 if farmn==.


gen total_n=sum_farmn+sum_nonfn

summarize total_n
gen total_std = (total_n - r(mean)) / r(sd)

gen lag2_total=L2.total_n

summarize lag2_total
gen lag2total_std = (lag2_total - r(mean)) / r(sd)

gen lag_total=L.total_n

summarize lag_total
gen lagtotal_std = (lag_total - r(mean)) / r(sd)

drop if year=="1987-1989"

gen ln_lag=log(lag_total)
gen ln_lag2=log(lag2_total)

egen id=group(fips_st time)
gen ln_pedpop=log(pop)

keep if state=="MN"

save "C:\Users\jsemprini\OneDrive - Des Moines University\2-External-Collab\10-FRDC\2-Nitrogen\MN_nitrogen_infantBCNS.dta", replace
