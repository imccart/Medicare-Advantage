########################################################################################
## Author:        Ian McCarthy
## Date Created:  7/8/2019
## Date Edited:   7/8/2019
## Notes:         R file to build Medicare Advantage dataset
########################################################################################
if (!require("pacman")) install.packages("pacman")
pacman::p_load(tidyverse, ggplot2, dplyr, lubridate, stringr, readxl)

#########################################################################
## First set all file/folder paths
#########################################################################
##path.code="C:\\Users\\immccar\\CloudStation\\Professional\\Research Projects\\_Git\\medicare-advantage\\R_code"
##path.data.final="C:\\CloudStation\\Professional\\Research Projects\\_Git\\medicare-advantage\\data"
##path.data.ma="C:\\Users\\immccar\\CloudStation\\Professional\\Research Data\\Medicare Advantage"

path.code="D:\\CloudStation\\Professional\\Research Projects\\_Git\\medicare-advantage\\R_code"
path.data.final="D:\\CloudStation\\Professional\\Research Projects\\_Git\\medicare-advantage\\data"
path.data.ma="D:\\CloudStation\\Professional\\Research Data\\Medicare Advantage"
path.data.ffs="D:\\CloudStation\\Professional\\Research Data\\Medicare FFS"


#########################################################################
## Build plan-level dataset
#########################################################################
source(paste(path.code,"\\1_Plan_data.R",sep=""),local=TRUE,echo=FALSE)
source(paste(path.code,"\\2_Plan_Characteristics.R",sep=""),local=TRUE,echo=FALSE)
source(paste(path.code,"\\3_Serivce_Areas.R",sep=""),local=TRUE,echo=FALSE)
source(paste(path.code,"\\4_Penetration_Files.R",sep=""),local=TRUE,echo=FALSE)
source(paste(path.code,"\\5_Star_Ratings.R",sep=""),local=TRUE,echo=FALSE)
source(paste(path.code,"\\6_Risk_Rebates.R",sep=""),local=TRUE,echo=FALSE)
source(paste(path.code,"\\7_MA_Benchmark.R",sep=""),local=TRUE,echo=FALSE)
source(paste(path.code,"\\8_FFS_Costs.R",sep=""),local=TRUE,echo=FALSE)


#########################################################################
## Organize final data
#########################################################################

use "${DATA_FINAL}Full_Contract_Plan_County.dta", clear
merge m:1 contractid fips year using "${DATA_FINAL}Contract_Service_Area.dta", keep(master match)

** Part C Approved Plans
gen CMS_Approved=(_merge==3)
drop _merge

** Drop special needs plans and other specific observations
drop if state=="VI" | state=="PR" | state=="MP" | state=="GU" | state=="AS"
drop if snpplan=="Yes"
drop if planid>=800 & planid<=899
drop if planid==.
drop if fips==.
keep if CMS_Approved==1
drop CMS_Approved

** Merge remaining files
merge m:1 contractid year using "${DATA_FINAL}Star_Ratings.dta", keep(master match) nogenerate
merge m:1 fips year using "${DATA_FINAL}MA_Penetration.dta", keep(master match) nogenerate

gen byte nonmiss=!mi(statename)
sort state statename nonmiss
bys state (nonmiss): replace statename=statename[_N] if nonmiss==0
drop nonmiss
rename state state_short
rename statename state
merge 1:1 contractid planid state county year using "${DATA_FINAL}Plan_Premiums.dta", keep(master match) nogenerate
merge m:1 contractid planid year using "${DATA_FINAL}RiskRebate.dta", keep(master match) nogenerate
merge m:1 ssa year using "${DATA_FINAL}MA_Benchmark.dta", keep(master match) nogenerate


*****************************************************  
** Calculate star rating (part C/D rating if plan offers Part D, otherwise Part C rating only)
gen StarRating=PartC_Summary_Star if offerspartd=="No" | (offerspartd=="Yes" & PartCD_Summary_Star==.)
replace StarRating=PartCD_Summary_Star if offerspartd=="Yes" & PartCD_Summary_Star!=.
qui tab StarRating, gen(starfx)

*****************************************************  
** Benchmarks
gen ma_rate=Risk if year<2012
replace ma_rate=Risk_Star50 if StarRating==5   & year>=2012 & year<2015
replace ma_rate=Risk_Star45 if StarRating==4.5 & year>=2012 & year<2015
replace ma_rate=Risk_Star40 if StarRating==4   & year>=2012 & year<2015
replace ma_rate=Risk_Star35 if StarRating==3.5 & year>=2012 & year<2015
replace ma_rate=Risk_Star30 if StarRating==3   & year>=2012 & year<2015
replace ma_rate=Risk_Star25 if StarRating<3    & year>=2012 & year<2015
replace ma_rate=Risk_Star35 if StarRating==.   & year>=2012 & year<2015
replace ma_rate=Risk_Bonus5 if StarRating>=4   & year==2015
replace ma_rate=Risk_Bonus0 if StarRating<4    & year==2015
replace ma_rate=Risk_Bonus35 if StarRating==.  & year==2015

*****************************************************  
** Premium and bid variables
gen PartD=(offerspartd=="Yes")
gen basic_premium=Premium_PartC
replace basic_premium=0 if Rebate_PartC>0 & Rebate_PartC!=.
replace basic_premium=Premium if PartD==0 & Premium!=. & basic_premium==.
gen bid=Payment_PartC/RiskScore_PartC if (Rebate_PartC>0 | basic_premium==0)
replace bid=(Payment_PartC+basic_premium)/RiskScore_PartC if (Rebate_PartC==0 & basic_premium>0 & basic_premium!=.)

*****************************************************  
/* Incorporate Medicare FFS Cost Data */
merge m:1 ssa year using "${DATA_FINAL}FFS_Costs.dta", keep(master match) nogenerate
gen AvgFFSCost=(parta_reimb/parta_enroll) + (partb_reimb/partb_enroll)

save "${DATA_FINAL}MA_Data.dta", replace


