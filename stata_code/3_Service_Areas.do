***********************************************************************************
/* Read in service area data */
***********************************************************************************
*************************************************************************
** Set local "month lists" to identify different files relevant for each year
/* Month lists differ by year just in case you work with data that are only available
   in a fraction of a year, which often happens for new data as new monthly releases
   are made. Some data sources are also only available in certain years.  */
*************************************************************************
loc monthlist_2006 "10 11 12"
loc monthlist_2007 "01 02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2008 "01 02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2009 "01 02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2010 "01 02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2011 "01 02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2012 "01 02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2013 "01 02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2014 "01 02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2015 "01 02 03 04 05 06 07 08 09 10 11 12"

forvalues y=2006(1)2015 {
  foreach m of loc monthlist_`y' {
    insheet using `"${DATA_MA}Monthly MA Contract Service Area\Extracted Data\MA_Cnty_SA_`y'_`m'.csv"', comma clear
    save temp_sa_`y'_`m', replace
  }
}

***********************************************************************************
** Append monthly files for each year
***********************************************************************************
loc monthlist_2006 "11 12"
loc monthlist_2007 "02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2008 "02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2009 "02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2010 "02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2011 "02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2012 "02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2013 "02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2014 "02 03 04 05 06 07 08 09 10 11 12"
loc monthlist_2015 "02 03 04 05 06 07 08 09 10 11 12"

use temp_sa_2006_10, clear
gen month="10"
foreach m of loc monthlist_2006 {
  append using temp_sa_2006_`m', force
  replace month="`m'" if month==""
}
destring month, replace
save temp_sa_2006, replace

forvalues y=2007(1)2015 {
  use temp_sa_`y'_01, clear
  gen month="01"
  foreach m of loc monthlist_`y' {
    append using temp_sa_`y'_`m', force
	replace month="`m'" if month==""
  }
  destring month, replace
  save temp_sa_`y', replace
}


***********************************************************************************
** Collapse from Monthly to Yearly data (keep if plan ever approved)
***********************************************************************************
forvalues y=2006(1)2015 {
  use temp_sa_`y', clear
  foreach x of varlist state county {
    gen byte nonmiss=!mi(`x')
    sort fips `x' nonmiss
    bys fips (nonmiss): replace `x'=`x'[_N] if nonmiss==0
    drop nonmiss
  }
  foreach x of varlist plantype partial eghp {
    gen byte nonmiss=!mi(`x')
	sort contractid `x' nonmiss
	bys contractid (nonmiss): replace `x'=`x'[_N] if nonmiss==0
	drop nonmiss
  }
  foreach x of varlist organizationtype organizationname {
    gen byte nonmiss=!mi(`x')
	sort contractid `x' nonmiss
	bys contractid (nonmiss): replace `x'=`x'[_N] if nonmiss==0
	drop nonmiss
  }
  bys contractid fips: gen obs=_n
  keep if obs==1  
  drop obs
  gen year=`y'
  save temp_`y', replace
}

***********************************************************************************
** Append yearly files
***********************************************************************************
use temp_2006, clear
forvalues y=2007(1)2015 {
  append using temp_`y'
}
drop month
sort contractid fips year
save "${DATA_FINAL}Contract_Service_Area.dta", replace
