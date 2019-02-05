***********************************************************************************
/* Read in enrollment data */
***********************************************************************************
forvalues y=2006(1)2015 {
  foreach m of loc monthlist_`y' {

  ** Plan Information and Type
  insheet using `"${DATA_MA}Monthly MA and PDP Enrollment by CPSC\Monthly MA and PDP Enrollment by CPSC\Extracted Data\CPSC_Contract_Info_`y'_`m'.csv"', comma clear
	capture confirm variable contractnumber 
	if !_rc {
	  rename contractnumber contractid
	}	
	bys contractid planid: gen obs=_n
	drop if obs>1 & contractid!=""
	drop obs
    save temp_info, replace

    ** Plan Enrollment
    insheet using `"${DATA_MA}Monthly MA and PDP Enrollment by CPSC\Monthly MA and PDP Enrollment by CPSC\Extracted Data\CPSC_Enrollment_Info_`y'_`m'.csv"', comma clear
	capture confirm variable contractnumber 
	if !_rc {
	  rename contractnumber contractid
	}
    capture confirm variable fipscode
	if !_rc {
	  rename fipscode fipsstatecountycode
	}	

	replace enrollment="" if enrollment=="*"
	destring enrollment, replace
    save temp_enroll, replace

    ** Merge data
    use temp_enroll, clear
    merge m:1 contractid planid using temp_info, nogenerate keep(match)
    save temp_merge_`y'_`m', replace
  }
}

***********************************************************************************
** Append monthly files for each year
***********************************************************************************
use temp_merge_2006_07, clear
gen month="07"
foreach m of loc monthlist_2006 {
  append using temp_merge_2006_`m', force
  replace month="`m'" if month==""
}
destring month, replace
save temp_merge_2006, replace

forvalues y=2007(1)2015 {
  use temp_merge_`y'_01, clear
  gen month="01"
  tostring parentorganization, replace
  foreach m of loc monthlist_`y' {
    append using temp_merge_`y'_`m', force
	replace month="`m'" if month==""
  }
  destring month, replace
  save temp_merge_`y', replace
}

***********************************************************************************
** Collapse from Monthly to Yearly data (using average enrollments)
***********************************************************************************
forvalues y=2006(1)2015 {
  use temp_merge_`y', clear
  rename fipsstatecountycode fips
  foreach x of varlist state county {
    gen byte nonmiss=!mi(`x')
    sort fips `x' nonmiss
    bys fips (nonmiss): replace `x'=`x'[_N] if nonmiss==0
    drop nonmiss
  }
  foreach x of varlist plantype offerspartd snpplan eghp planname {
    gen byte nonmiss=!mi(`x')
	sort contractid planid `x' nonmiss
	bys contractid planid (nonmiss): replace `x'=`x'[_N] if nonmiss==0
	drop nonmiss
  }
  foreach x of varlist organizationtype organizationname organizationmarketingname parentorganization {
    gen byte nonmiss=!mi(`x')
	sort contractid `x' nonmiss
	bys contractid (nonmiss): replace `x'=`x'[_N] if nonmiss==0
	drop nonmiss
  }
  bys contractid planid fips: egen avg_enrollment=mean(enrollment)
  bys contractid planid fips: egen sd_enrollment=sd(enrollment)
  bys contractid planid fips: egen min_enrollment=min(enrollment)
  bys contractid planid fips: egen max_enrollment=max(enrollment)  
  
  sort contractid planid fips month
  by contractid planid fips: gen start_enrollment=enrollment if _n==1
  by contractid planid fips: gen end_enrollment=enrollment if _n==_N
  foreach x of varlist start_enrollment end_enrollment {
    gen byte nonmiss=!mi(`x')
	sort contractid planid fips `x' nonmiss
	bys contractid planid fips (nonmiss): replace `x'=`x'[_N] if nonmiss==0
	drop nonmiss
  }  
  
  bys contractid planid fips: gen obs=_n
  keep if obs==1
  drop obs
/*  
  collapse (mean) enrollment (first) state county organizationtype plantype offerspartd snpplan eghp organizationname ///
    organizationmarketingname planname parentorganization contracteffectivedate, by(contractid planid fipsstatecountycode)
*/
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
drop month enrollment
sort contractid planid fips year
save "${DATA_FINAL}Full_Contract_Plan_County.dta", replace
