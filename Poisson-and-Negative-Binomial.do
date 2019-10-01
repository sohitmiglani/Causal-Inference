** Poisson and Negative Binomial Regression
** Data from German Health Care Data, Unbalanced Panel, 7,293 Individuals, 27,326 Observations. Source: Riphahn, Wambach, Million (2003)

clear all
import delimited "/Users/sohit/Downloads/Assignment_Data2.csv"

poisson hospvis i.female year age hsat i.handdum handper hhninc educ i.working i.bluec i.whitec docvis i.public i.addon
margins, dydx(*) atmeans
estat gof

regress hospvis i.female year age hsat i.handdum handper hhninc educ i.working i.bluec i.whitec docvis i.public i.addon
vif

nbreg hospvis i.female year age hsat i.handdum handper hhninc educ i.working i.bluec i.whitec docvis i.public i.addon
