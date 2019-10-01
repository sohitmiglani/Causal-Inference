** Basic mean-variance analysis of the German Findex database from 3 different years.
** All datasets retrieved from: 

Group, D. R. (2012, December 12). Germany - Global Financial Inclusion (Global Findex) 
	Database 2011. Retrieved October 26, 2018, from 
	http://microdata.worldbank.org/index.php/catalog/1150

** 

**For 2011
 
use "/Users/sohit/Downloads/DEU_2011_FINDEX_v02_M_STATA8/micro_DEU.dta"
mean inc_q 
mean q11      *savings  
mean q14a    *borrowed money

**For 2014

use "/Users/sohit/Downloads/DEU_2014_FINDEX_v02_M_STATA8/micro_DEU.dta"
mean inc_q 
mean saved 
mean borrrowed 

** For collected data
 
use "/Users/sohit/Downloads/data.csv"
mean income_quintile
mean saved
mean borrowed
mean more_saved_than_before 
mean more_borrowed_than_before
mean effect_of_welfare_benefits
