** Building a probabilistic and a ordered choice model for a dataset on the choice to engage in extramarital affairs
** Data: Fair, Redbook Survey on Extramarital Affairs, 6,366 Observations. Source: Fair (1978)

clear all 
import delimited "/Users/sohit/Downloads/TableF17-2.csv"

gen A = (yrb > 0)

probit A v1 v2 v3 v4 v5 v6 v7 v8
margins, dydx(*) atmeans
vif, uncentered

logit A v1 v2 v3 v4 v5 v6 v7 v8
margins, dydx(*) atmeans
vif, uncentered

oprobit v1 v2 v3 v4 v5 v6 v7 v8
margins, dydx(*) atmeans
