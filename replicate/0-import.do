version 17
clear all
set more off

cd "C:\Users\jsemprini\OneDrive - Des Moines University\2-External-Collab\10-FRDC\2-Nitrogen\raw-seer"

foreach x in     "ayacan0519" ///
    "eocan2049female" ///
    "eocan2049male" ///
    "pedcan04" ///
    "tradcan50plusfemale" ///
    "tradcan50plusmale"{
		
		clear all
		
		import delimited "`x'.csv"
		save "`x'.dta"
	}
