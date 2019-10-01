** We analyse the effect of physical disability on the wages
** Dataset retrieved from: Central Population Survey 2017, National Bureau of Economic Research

clear
use "/Users/sohit/Downloads/cpsmar2017.dta"
drop if wsal_val == 0
gen wage_rate = wsal_val / (hrswk*wkswork)
drop if wage_rate < 1

summ wage_rate
summ pediseye 

kdensity wage_rate 
graph twoway (scatter a_age pediseye) ) (lfit a_age pediseye), xtitle(“Eyesight”) ytitle(“Age”) 
graph twoway lfit a_clswkr pediseye, xtitle(“Eyesight”) ytitle(“Class of the worker”) 

regress wage_rate pediseye 
y_bar = 0.345
mu = 0
se = 0.826 
t_stat = (y_bar - mu)/se 
p_value = ttail(87418,t_stat) 
t_critical = ttail(87418, 0.005)
twoway (function y = tden(87412,x),range(-5 -1.615) color(ltblue) recast(area)) (function y = tden(87412,x),range(1.615 5) color(ltblue) recast(area)) (function y = tden(87412,x),range(-5 5)), legend(off) plotregion(margin(zero)) ytitle("f(t)") xtitle("t") xlabel( -1.27 0 0.34 1.96) name(twotail, replace) title("Two-tail rejection region" "t(87412), alpha=0.05")
