
***********************************************************************************
** 2006 FFS Costs data
***********************************************************************************
insheet using "${DATA_FFS}FFS Costs\Extracted Data\Aged Only\AGED06.csv", comma clear
keep v1 v2 v3 v4 v5 v13 v14
rename v1 state
rename v2 ssa
rename v3 county
rename v4 parta_enroll_aged
rename v5 parta_reimb_aged
rename v13 partb_enroll_aged
rename v14 partb_reimb_aged
drop if _n<=6

foreach x of varlist part* {
  replace `x'=subinstr(`x',"*","",.)
  destring `x', replace
}
destring ssa, replace
gen Year=2006
save temp_ffs_2006aged, replace


insheet using "${DATA_FFS}FFS Costs\Extracted Data\Dsbld Only\DBLD06.csv", comma clear
keep v1 v2 v3 v4 v5 v13 v14
rename v1 state
rename v2 ssa
rename v3 county
rename v4 parta_enroll_dbld
rename v5 parta_reimb_dbld
rename v13 partb_enroll_dbld
rename v14 partb_reimb_dbld
drop if _n<=6

foreach x of varlist part* {
  replace `x'=subinstr(`x',"*","",.)
  destring `x', replace
}
destring ssa, replace
gen Year=2006
save temp_ffs_2006dbld, replace

***********************************************************************************
** 2007 FFS Costs data
***********************************************************************************
insheet using "${DATA_FFS}FFS Costs\Extracted Data\Aged Only\Aged07.csv", comma clear
keep v1 v2 v3 v4 v5 v13 v14
rename v1 state
rename v2 ssa
rename v3 county
rename v4 parta_enroll_aged
rename v5 parta_reimb_aged
rename v13 partb_enroll_aged
rename v14 partb_reimb_aged
drop if _n<=4

foreach x of varlist part* {
  replace `x'=subinstr(`x',"*","",.)
  replace `x'=subinstr(`x',",","",.)
  destring `x', replace
}
destring ssa, replace
gen Year=2007
save temp_ffs_2007aged, replace


insheet using "${DATA_FFS}FFS Costs\Extracted Data\Dsbld Only\Dbld07.csv", comma clear
keep v1 v2 v3 v4 v5 v13 v14
rename v1 state
rename v2 ssa
rename v3 county
rename v4 parta_enroll_dbld
rename v5 parta_reimb_dbld
rename v13 partb_enroll_dbld
rename v14 partb_reimb_dbld
drop if _n<=4

foreach x of varlist part* {
  replace `x'=subinstr(`x',"*","",.)
  replace `x'=subinstr(`x',",","",.)
  destring `x', replace
}
destring ssa, replace
gen Year=2007
save temp_ffs_2007dbld, replace

***********************************************************************************
** 2008 FFS Costs data
***********************************************************************************
insheet using "${DATA_FFS}FFS Costs\Extracted Data\Aged Only\AGED08.csv", comma clear
keep v1 v2 v3 v4 v5 v13 v14
rename v1 state
rename v2 ssa
rename v3 county
rename v4 parta_enroll_aged
rename v5 parta_reimb_aged
rename v13 partb_enroll_aged
rename v14 partb_reimb_aged
drop if _n<=3

foreach x of varlist part* {
  replace `x'=subinstr(`x',"*","",.)
  replace `x'=subinstr(`x',",","",.)
  destring `x', replace
}
destring ssa, replace
gen Year=2008
save temp_ffs_2008aged, replace


insheet using "${DATA_FFS}FFS Costs\Extracted Data\Dsbld Only\DBLD08.csv", comma clear
keep v1 v2 v3 v4 v5 v13 v14
rename v1 state
rename v2 ssa
rename v3 county
rename v4 parta_enroll_dbld
rename v5 parta_reimb_dbld
rename v13 partb_enroll_dbld
rename v14 partb_reimb_dbld
drop if _n<=3

foreach x of varlist part* {
  replace `x'=subinstr(`x',"*","",.)
  replace `x'=subinstr(`x',",","",.)
  destring `x', replace
}
destring ssa, replace
gen Year=2008
save temp_ffs_2008dbld, replace


***********************************************************************************
** 2009 FFS Costs data
***********************************************************************************
insheet using "${DATA_FFS}FFS Costs\Extracted Data\Aged Only\aged09.csv", comma clear
keep v1 v2 v3 v4 v5 v12 v13
rename v1 ssa
rename v2 state
rename v3 county
rename v4 parta_enroll_aged
rename v5 parta_reimb_aged
rename v12 partb_enroll_aged
rename v13 partb_reimb_aged
drop if _n<=6

foreach x of varlist part* {
  replace `x'=subinstr(`x',"*","",.)
  replace `x'=subinstr(`x',",","",.)
  destring `x', replace
}
destring ssa, replace
gen Year=2009
save temp_ffs_2009aged, replace


insheet using "${DATA_FFS}FFS Costs\Extracted Data\Dsbld Only\dbld09.csv", comma clear
keep v1 v2 v3 v4 v5 v12 v13
rename v1 ssa
rename v2 state
rename v3 county
rename v4 parta_enroll_dbld
rename v5 parta_reimb_dbld
rename v12 partb_enroll_dbld
rename v13 partb_reimb_dbld
drop if _n<=6

foreach x of varlist part* {
  replace `x'=subinstr(`x',"*","",.)
  replace `x'=subinstr(`x',",","",.)
  destring `x', replace
}
destring ssa, replace
gen Year=2009
save temp_ffs_2009dbld, replace


***********************************************************************************
** 2010 FFS Costs data
***********************************************************************************
insheet using "${DATA_FFS}FFS Costs\Extracted Data\Aged Only\aged10.csv", comma clear
keep v1 v2 v3 v4 v5 v12 v13
rename v1 ssa
rename v2 state
rename v3 county
rename v4 parta_enroll_aged
rename v5 parta_reimb_aged
rename v12 partb_enroll_aged
rename v13 partb_reimb_aged
drop if _n<=7

foreach x of varlist part* {
  replace `x'=subinstr(`x',"*","",.)
  replace `x'=subinstr(`x',",","",.)
  destring `x', replace
}
destring ssa, replace
gen Year=2010
save temp_ffs_2010aged, replace


insheet using "${DATA_FFS}FFS Costs\Extracted Data\Dsbld Only\dbld10.csv", comma clear
keep v1 v2 v3 v4 v5 v12 v13
rename v1 ssa
rename v2 state
rename v3 county
rename v4 parta_enroll_dbld
rename v5 parta_reimb_dbld
rename v12 partb_enroll_dbld
rename v13 partb_reimb_dbld
drop if _n<=7

foreach x of varlist part* {
  replace `x'=subinstr(`x',"*","",.)
  replace `x'=subinstr(`x',",","",.)
  destring `x', replace
}
destring ssa, replace
gen Year=2010
save temp_ffs_2010dbld, replace


***********************************************************************************
** 2011 FFS Costs data
***********************************************************************************
insheet using "${DATA_FFS}FFS Costs\Extracted Data\Aged Only\aged11.csv", comma clear
keep v1 v2 v3 v4 v5 v12 v13
rename v1 ssa
rename v2 state
rename v3 county
rename v4 parta_enroll_aged
rename v5 parta_reimb_aged
rename v12 partb_enroll_aged
rename v13 partb_reimb_aged
drop if _n<=2

foreach x of varlist part* {
  replace `x'=subinstr(`x',"*","",.)
  replace `x'=subinstr(`x',",","",.)
  destring `x', replace
}
destring ssa, replace
gen Year=2011
save temp_ffs_2011aged, replace


insheet using "${DATA_FFS}FFS Costs\Extracted Data\Dsbld Only\dbld11.csv", comma clear
keep v1 v2 v3 v4 v5 v12 v13
rename v1 ssa
rename v2 state
rename v3 county
rename v4 parta_enroll_dbld
rename v5 parta_reimb_dbld
rename v12 partb_enroll_dbld
rename v13 partb_reimb_dbld
drop if _n<=2

foreach x of varlist part* {
  replace `x'=subinstr(`x',"*","",.)
  replace `x'=subinstr(`x',",","",.)
  destring `x', replace
}
destring ssa, replace
gen Year=2011
save temp_ffs_2011dbld, replace


***********************************************************************************
** 2012 FFS Costs data
***********************************************************************************
insheet using "${DATA_FFS}FFS Costs\Extracted Data\Aged Only\aged12.csv", comma clear
keep v1 v2 v3 v4 v5 v12 v13
rename v1 ssa
rename v2 state
rename v3 county
rename v4 parta_enroll_aged
rename v5 parta_reimb_aged
rename v12 partb_enroll_aged
rename v13 partb_reimb_aged
drop if _n<=2

foreach x of varlist part* {
  replace `x'=subinstr(`x',"*","",.)
  replace `x'=subinstr(`x',",","",.)
  destring `x', replace
}
gen miss=strpos(ssa,"X")
replace ssa="" if miss!=0
destring ssa, replace
drop if ssa==.
drop miss
gen Year=2012
save temp_ffs_2012aged, replace


insheet using "${DATA_FFS}FFS Costs\Extracted Data\Dsbld Only\dbld12.csv", comma clear
keep v1 v2 v3 v4 v5 v12 v13
rename v1 ssa
rename v2 state
rename v3 county
rename v4 parta_enroll_dbld
rename v5 parta_reimb_dbld
rename v12 partb_enroll_dbld
rename v13 partb_reimb_dbld
drop if _n<=2

foreach x of varlist part* {
  replace `x'=subinstr(`x',"*","",.)
  replace `x'=subinstr(`x',",","",.)
  destring `x', replace
}
gen miss=strpos(ssa,"X")
replace ssa="" if miss!=0
destring ssa, replace
drop if ssa==.
drop miss
gen Year=2012
save temp_ffs_2012dbld, replace


***********************************************************************************
** 2013 FFS Costs data
***********************************************************************************
insheet using "${DATA_FFS}FFS Costs\Extracted Data\Aged Only\aged13.csv", comma clear
keep v1 v2 v3 v4 v5 v12 v13
rename v1 ssa
rename v2 state
rename v3 county
rename v4 parta_enroll_aged
rename v5 parta_reimb_aged
rename v12 partb_enroll_aged
rename v13 partb_reimb_aged
drop if _n<=2

foreach x of varlist part* {
  replace `x'=subinstr(`x',"*","",.)
  replace `x'=subinstr(`x',",","",.)
  destring `x', replace
}
gen miss=strpos(ssa,"X")
replace ssa="" if miss!=0
destring ssa, replace
drop if ssa==.
drop miss
gen Year=2013
save temp_ffs_2013aged, replace


insheet using "${DATA_FFS}FFS Costs\Extracted Data\Dsbld Only\dbld13.csv", comma clear
keep v1 v2 v3 v4 v5 v12 v13
rename v1 ssa
rename v2 state
rename v3 county
rename v4 parta_enroll_dbld
rename v5 parta_reimb_dbld
rename v12 partb_enroll_dbld
rename v13 partb_reimb_dbld
drop if _n<=2

foreach x of varlist part* {
  replace `x'=subinstr(`x',"*","",.)
  replace `x'=subinstr(`x',",","",.)
  destring `x', replace
}
gen miss=strpos(ssa,"X")
replace ssa="" if miss!=0
destring ssa, replace
drop if ssa==.
drop miss
gen Year=2013
save temp_ffs_2013dbld, replace



***********************************************************************************
** 2014 FFS Costs data
***********************************************************************************
insheet using "${DATA_FFS}FFS Costs\Extracted Data\Aged Only\aged14.csv", comma clear
keep v1 v2 v3 v4 v5 v12 v13
rename v1 ssa
rename v2 state
rename v3 county
rename v4 parta_enroll_aged
rename v5 parta_reimb_aged
rename v12 partb_enroll_aged
rename v13 partb_reimb_aged
drop if _n<=2

foreach x of varlist part* {
  replace `x'=subinstr(`x',"*","",.)
  replace `x'=subinstr(`x',",","",.)
  destring `x', replace
}
destring ssa, replace
gen Year=2014
save temp_ffs_2014aged, replace


insheet using "${DATA_FFS}FFS Costs\Extracted Data\Dsbld Only\dbld14.csv", comma clear
keep v1 v2 v3 v4 v5 v12 v13
rename v1 ssa
rename v2 state
rename v3 county
rename v4 parta_enroll_dbld
rename v5 parta_reimb_dbld
rename v12 partb_enroll_dbld
rename v13 partb_reimb_dbld
drop if _n<=2

foreach x of varlist part* {
  replace `x'=subinstr(`x',"*","",.)
  replace `x'=subinstr(`x',",","",.)
  destring `x', replace
}
destring ssa, replace
gen Year=2014
save temp_ffs_2014dbld, replace

***********************************************************************************
** 2015 FFS Costs data
***********************************************************************************
import excel using "${DATA_FFS}FFS Costs\Extracted Data\FFS15.xlsx", clear
keep A B C D E L M
rename A ssa
rename B state
rename C county
rename D parta_enroll
rename E parta_reimb
rename L partb_enroll
rename M partb_reimb
drop if _n<=2

foreach x of varlist part* {
  replace `x'=subinstr(`x',"*","",.)
  replace `x'=subinstr(`x',",","",.)
  destring `x', replace
}
gen miss=strpos(ssa,"X")
replace ssa="" if miss!=0
destring ssa, replace
drop if ssa==.
drop miss
gen Year=2015
save temp_ffs_2015, replace


***********************************************************************************
** Combine aged+dbld enrollments and reimbursements
forvalues t=2006/2014 {
	use temp_ffs_`t'aged, clear
	merge 1:1 state ssa county using temp_ffs_`t'dbld, nogenerate
	gen parta_enroll=parta_enroll_aged+parta_enroll_dbld
	gen parta_reimb=parta_reimb_aged+parta_reimb_dbld
	gen partb_enroll=partb_enroll_aged+partb_enroll_dbld
	gen partb_reimb=partb_reimb_aged+partb_reimb_dbld
	keep state ssa county parta_enroll parta_reimb partb_enroll partb_reimb Year
	save temp_ffs_`t', replace
}

***********************************************************************************
** Append Yearly Data
use temp_ffs_2006, clear
forvalues t=2007(1)2015 {
  append using temp_ffs_`t'
}
drop if ssa==.
rename Year year
save "${DATA_FINAL}FFS_Costs.dta", replace
