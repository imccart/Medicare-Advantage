***********************************************************************************
/* Read in MA penetration data */
***********************************************************************************
*************************************************************************
** Set local "month lists" to identify different files relevant for each year
/* Month lists differ by year just in case you work with data that are only available
   in a fraction of a year, which often happens for new data as new monthly releases
   are made. Some data sources are also only available in certain years.  */
*************************************************************************
loc monthlist_2008 "06 07 08 09 10 11 12"
loc monthlist_2009 "01 02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2010 "01 02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2011 "01 02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2012 "01 02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2013 "01 02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2014 "01 02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2015 "01 02 03 04 05 06 07 08 09 10 11 12"

forvalues y=2008(1)2015 {
  foreach m of loc monthlist_`y' {
    insheet using `"${DATA_MA}Monthly MA State and County Penetration\Extracted Data\State_County_Penetration_MA_`y'_`m'.csv"', comma clear
    save temp_pen_`y'_`m', replace
  }
}



***********************************************************************************
** Append monthly files for each year
***********************************************************************************
loc monthlist_2008 "07 08 09 10 11 12"
loc monthlist_2009 "02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2010 "02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2011 "02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2012 "02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2013 "02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2014 "02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2015 "02 03 04 05 06 07 08 09 10 11 12"

use temp_pen_2008_06, clear
gen month="06"
foreach m of loc monthlist_2008 {
  append using temp_pen_2008_`m', force
  replace month="`m'" if month==""
}
destring month, replace
save temp_pen_2008, replace

forvalues y=2009(1)2015 {
  use temp_pen_`y'_01, clear
  gen month="01"
  foreach m of loc monthlist_`y' {
    append using temp_pen_`y'_`m', force
	replace month="`m'" if month==""
  }
  destring month, replace
  save temp_pen_`y', replace
}


***********************************************************************************
** Collapse from Monthly to Yearly data (keep if plan ever approved)
***********************************************************************************
forvalues y=2008(1)2015 {
  use temp_pen_`y', clear
  drop if fipscnty==.
  capture confirm string variable fips
	if !_rc {
	  replace fips="" if fips=="UK"
	  destring fips, replace
	}
  foreach x of varlist eligibles enrolled {
    replace `x'= subinstr(`x', ",", "",.)  
    replace `x'="" if `x'=="*"
    destring `x', replace
    bys fips: egen avg_`x'=mean(`x')
  }
  bys fips: gen obs=_n
  keep if obs==1
  drop obs
  gen year=`y'

  keep fips avg_eligibles avg_enrolled statename countyname ssa year
  save temp_`y', replace
}

***********************************************************************************
** Append yearly files
***********************************************************************************
use temp_2008, clear
forvalues y=2009(1)2015 {
  append using temp_`y'
}
sort fips year
save "${DATA_FINAL}MA_Penetration.dta", replace
