** Analysing the effect of economic factors on oil prices using log transformed models
** Data from The U.S. Gasoline Market, 52 Yearly Observations, 1953-2004

clear all 
import delimited "/Users/sohit/Downloads/TableF2-2.csv"

gen per_capita = gasexp/(gasp*pop)
regress per_capita income gasp pnc puc ppt pd pn ps year

regress per_capita gasp
margins if year==2004, eyex(gasp) 

regress per_capita income
margins if year==2004, eyex(income) 

regress gasp ppt
margins if year==2004, eyex(ppt) 

gen log_gasexp = log(gasexp)
gen log_gasp = log(gasp)
gen log_income = log(income)
gen log_pnc = log(pnc)
gen log_puc = log(puc)
gen log_ppt = log(ppt)
gen log_pd = log(pd)
gen log_pn = log(pn)
gen log_ps = log(ps)
gen log_per_capita = log(per_capita)

regress log_per_capita log_gasp 
regress log_per_capita log_income 
regress log_gasp log_ppt

regress per_capita gasp pnc puc ppt pd pn ps
vif 

regress per_capita log_gasp log_pnc log_puc log_ppt log_pd log_pn log_ps
vif 

replace pnc = 100 if year == 2004 
replace puc = 100 if year == 2004
replace ppt = 100 if year == 2004
replace pd = 100 if year == 2004
replace pn = 100 if year == 2004
replace ps = 100 if year == 2004

replace log_pnc = 4.6051702 if year ==2004
replace log_puc = 4.6051702 if year ==2004
replace log_ppt = 4.6051702 if year ==2004
replace log_pd = 4.6051702 if year ==2004
replace log_pn = 4.6051702 if year ==2004
replace log_ps = 4.6051702 if year ==2004

regress per_capita income gasp pnc puc ppt pd pn ps year
regress log_per_capita log_income log_gasp log_pnc log_puc log_ppt log_pd log_pn log_ps year
