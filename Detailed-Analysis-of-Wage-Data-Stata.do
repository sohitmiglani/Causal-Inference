** We perform a detaild analysis of the effect of different factors of a family on their income
** Data from Koop and Tobias (2004) Labor Market Experience Data

clear all 
import delimited "/Users/sohit/Downloads/Koop-Tobias.csv"

drop if personid > 15 
drop in 2/4
drop in 3/10 
drop in 5/15
drop in 6/7
drop in 7/17
drop in 8/9
drop in 9/21
drop in 10/11
drop in 11/16
drop in 12/13
drop in 13/23
drop in 14/24
drop in 15/16
drop in 16/25

global x1 educ potexper ability
global x2 mothered fathered siblings

global y logwage

regress $y $x1
predict yhat1, xb
predict r1, resid
vif 

graph twoway (scatter yhat1 logwage) (lfit yhat1 logwage)
graph twoway (scatter r1 yhat1) (lfit r1 yhat1)
graph twoway (scatter r1 yhat1) (lfit r1 yhat1)
kdensity r1

regress $y $x1 $x2

predict yhat2, xb
predict r2, resid
vif 

graph twoway (scatter yhat2 logwage) (lfit yhat2 logwage)
graph twoway (scatter r2 yhat2) (lfit r2 yhat2)
graph twoway (scatter r2 yhat2) (lfit r2 yhat2)
kdensity r2

regress $y $x1 $x2, noconstant
