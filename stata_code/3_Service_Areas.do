***********************************************************************************
/* Read in service area data */
***********************************************************************************
forvalues y=2006(1)2015 {
  foreach m of loc monthlist_`y' {
    insheet using `"${DATA_MA}Monthly MA Contract Service Area\Extracted Data\MA_Cnty_SA_`y'_`m'.csv"', comma clear
    save temp_sa_`y'_`m', replace
  }
}

***********************************************************************************
** Append monthly files for each year
***********************************************************************************
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
