** Building a synthetic control using world financial data from 

Lane, P., & Milesi-Ferretti, G. (2007). The external wealth of nations mark ii: Revised and 
	extended estimates of foreign assets and liabilities, 1970-2004. Journal of International 
	Economics, 73(2), 223-250. doi:10.1016/j.jinteco.2007.02.003
  
** Please email me for a copy of the dataset.
** We build a synthetic control for India to observe the effect of introducing capitalism to the Indian economy in 1991.

clear all 
use "/Users/sohit/Desktop/ewn2011.dta"
sort country_name year, stable

gen code = 1 + floor((_n - 1)/42)
tsset code year

graph twoway line gdp year if code == 29
summ gdp if code == 29

graph twoway line fx_res_minus_gold year if code == 29
summ fx_res_minus_gold if code == 29

graph twoway line tot_assets year if code == 29
summ tot_assets if code == 29

graph twoway line tot_liab if code == 29
summ tot_liab if code == 29

graph twoway line nfa if code == 29
summ nfa if code == 29

graph twoway line ex_rate_avg if code == 29
summ ex_rate_avg if code == 29

synth gdp nfa ex_rate_avg fx_res_minus_gold,trunit(29) trperiod(1997) unitnames(country_name) keep(/users/sohit/downloads/data/synth/synth_gdp.dta) fig; mat list e(V_matrix); graph save Graph /users/sohit/downloads/data/synth/synth_ind.gph, replace

use /users/sohit/Downloads/data/synth/synth_gdp.dta, clear
drop if _time==.
rename _time year
rename _Y_treated  treat
rename _Y_synthetic counterfact
gen gap=treat-counterfact

gen post = 1 if year > 1996
replace post = 0 if year <1990
drop if year >1989 & year <1997

regress gap post
outreg2 using myreg.doc, replace ctitle(Differences in Differences - Direct Regression)

sort year 
twoway (line gap year,lp(solid)lw(vthin)lcolor(black)), yline(0, lpattern(shortdash) lcolor(black)) xline(1997, lpattern(shortdash) lcolor(black)) xtitle("",si(medsmall)) xlabel(#10) ytitle("Gap in GDP prediction error", size(medsmall)) legend(off)
save "/users/sohit/Downloads/data/synth/synth_gdp.dta", replace

clear

use "/Users/sohit/Desktop/ewn2011.dta"
local countrylist 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68


foreach i of local countrylist { synth gdp nfa ex_rate_avg fx_res_minus_gold, trunit(`i') trperiod(1997) unitnames(country_name) keep(/users/sohit/Downloads/data/synth/synth_gdp_`i'.dta), matrix state`i' = e(RMSPE) /* check the V matrix*/}

foreach i of local countrylist {
 	use /users/sohit/Downloads/data/synth/synth_gdp_`i' ,clear
 	keep _Y_treated _Y_synthetic _time
 	drop if _time==.
	rename _time year
 	rename _Y_treated  treat`i'
 	rename _Y_synthetic counterfact`i'
 	gen gap`i'=treat`i'-counterfact`i'
 	sort year 
 	save /users/sohit/Downloads/data/synth/synth_gap_gdp`i', replace
}

foreach i of local countrylist {
		
		merge year using /users/sohit/Downloads/data/synth/synth_gap_gdp`i'
		drop _merge
		sort year
		
	save /users/sohit/Downloads/data/synth/placebo_gdp.dta, replace
}

use /users/sohit/Downloads/data/synth/placebo_gdp.dta, replace

graph twoway (line gap1 year ,lp(solid)lw(vthin)) (line gap2 year ,lp(solid)lw(vthin)) (line gap4 year ,lp(solid)lw(vthin)) (line gap5 year ,lp(solid)lw(vthin)) (line gap6 year ,lp(solid)lw(vthin)) (line gap7 year ,lp(solid)lw(vthin)) (line gap8 year ,lp(solid)lw(vthin))  (line gap11 year ,lp(solid)lw(vthin))  (line gap12 year ,lp(solid)lw(vthin))  (line gap13 year ,lp(solid)lw(vthin))  (line gap14 year ,lp(solid)lw(vthin))  (line gap15 year ,lp(solid)lw(vthin))  (line gap16 year ,lp(solid)lw(vthin))  (line gap17 year ,lp(solid)lw(vthin))  (line gap18 year ,lp(solid)lw(vthin))  (line gap19 year ,lp(solid)lw(vthin))  (line gap20 year ,lp(solid)lw(vthin)) (line gap23 year ,lp(solid)lw(vthin)) (line gap24 year ,lp(solid)lw(vthin)) (line gap25 year ,lp(solid)lw(vthin)) (line gap26 year ,lp(solid)lw(vthin)) (line gap27 year ,lp(solid)lw(vthin)) (line gap28 year ,lp(solid)lw(vthin)) (line gap30 year ,lp(solid)lw(vthin)), yline(0, lpattern(shortdash) lcolor(black)) xline(1997, lpattern(shortdash) lcolor(black)) xtitle("",si(small)) xlabel(#10) ytitle("Gap in GDP prediction error", size(small)) legend(off)
